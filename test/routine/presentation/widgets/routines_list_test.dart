import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/routine/routine.dart';

import '../../../helper.dart';
import '../../domain/entities/routine_mocks.dart';

void main() {
  Future<void> pumpWidget(
    WidgetTester tester, {
    List<Routine>? routines,
    void Function(BuildContext, Routine)? onPressed,
    VoidCallback? onCreatePressed,
  }) {
    return tester.pumpWidgetForTest(
      (context) => RoutinesList(
        routines: routines ?? mockRoutines,
        onPressed: onPressed,
        onCreatePressed: onCreatePressed,
      ),
    );
  }

  group('RoutinesList', () {
    group('Render', () {
      testWidgets(
        'shows each routines when routines is not empty',
        (tester) async {
          await pumpWidget(tester);

          for (final routine in mockRoutines) {
            final finder = find.ancestor(
              of: find.text(routine.name),
              matching: find.byType(RoutineListTile),
            );
            expect(finder, findsOneWidget);
            await tester.ensureVisible(finder);
          }
        },
      );

      testWidgets(
        'shows AppEmptyBox when routines is empty',
        (tester) async {
          await pumpWidget(tester, routines: []);

          final finder = find.byType(AppEmptyBox);
          final widget = tester.widget<AppEmptyBox>(finder);

          expect(finder, findsOne);
          expect(widget.title, 'Routines empty');
          expect(
            widget.content,
            'You never create your routine data. '
            'Start create now and reach your ultimate goals ',
          );

          final createButtonFinder = find.ancestor(
            of: find.text('Create now'),
            matching: find.byType(FilledButton),
          );
          expect(createButtonFinder, findsOneWidget);
        },
      );
    });

    group('Interactions', () {
      testWidgets(
        'calls onPressed when on of routines is pressed',
        (tester) async {
          Routine? pressedRoutine;
          await pumpWidget(
            tester,
            onPressed: (context, routine) {
              pressedRoutine = routine;
            },
          );

          final finder = find.ancestor(
            of: find.text(mockRoutines.first.name),
            matching: find.byType(ListTile),
          );
          await tester.tap(finder);

          expect(pressedRoutine, mockRoutines.first);
        },
      );

      testWidgets(
        'calls onCreatePressed when create button is pressed',
        (tester) async {
          var pressed = false;
          await pumpWidget(
            tester,
            routines: [],
            onCreatePressed: () {
              pressed = true;
            },
          );

          final finder = find.ancestor(
            of: find.text('Create now'),
            matching: find.byType(FilledButton),
          );
          expect(finder, findsOneWidget);

          await tester.tap(finder);

          expect(pressed, isTrue);
        },
      );
    });
  });
}
