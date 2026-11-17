import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/routine/routine.dart';

import '../../../helper.dart';
import '../../domain/entities/routine_mocks.dart';

void main() {
  Future<void> pumpWidget(
    WidgetTester tester, {
    OnRoutineSaved? onRoutineSaved,
  }) {
    return tester.pumpWidgetForTest((context) {
      return RoutineDetail(
        routine: mockRoutine,
        onRoutineSaved: onRoutineSaved,
      );
    });
  }

  group('RoutineDetail', () {
    group('Render', () {
      testWidgets('shows correct RoutineForm', (tester) async {
        await pumpWidget(tester);

        final finder = find.byType(RoutineForm);
        expect(finder, findsOneWidget);
        final widget = tester.widget<RoutineForm>(finder);
        expect(widget.initialRoutine, mockRoutine);
      });
    });

    group('Interactions', () {
      testWidgets(
        'calls onRoutineSaved when RoutineForm fires onRoutineSaved',
        (tester) async {
          CreateRoutineParams? p;
          await pumpWidget(
            tester,
            onRoutineSaved: (params) {
              p = params;
            },
          );

          await tester.enterText(
            find.ancestor(
              of: find.text(mockRoutine.name),
              matching: find.byType(TextFormField),
            ),
            'text',
          );
          await tester.tap(
            find.descendant(
              of: find.byType(RoutineForm),
              matching: find.byType(FilledButton),
            ),
          );

          expect(
            p,
            CreateRoutineParams(name: 'text', days: mockRoutine.weekDays),
          );
        },
      );
    });
  });
}
