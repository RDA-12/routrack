import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/tracker/tracker.dart';

import '../../../helper.dart';
import '../../../routine/domain/entities/routine_mocks.dart';

void main() {
  Future<void> pumpWidget(
    WidgetTester tester, {
    bool isTracked = false,
    OnRoutineTrackChanged? onChanged,
  }) {
    return tester.pumpWidgetForTest(
      (context) => TrackableRoutineListTile(
        routine: mockRoutine,
        isTracked: isTracked,
        onChanged: onChanged,
      ),
    );
  }

  group('TrackableRoutineListTile', () {
    group('Render', () {
      testWidgets('shows routine name', (tester) async {
        await pumpWidget(tester);

        final finder = find.descendant(
          of: find.byType(CheckboxListTile),
          matching: find.text(mockRoutine.name),
        );

        expect(finder, findsOneWidget);
      });

      testWidgets('shows checkbox', (tester) async {
        await pumpWidget(tester);

        final finder = find.descendant(
          of: find.byType(CheckboxListTile),
          matching: find.byType(Checkbox),
        );

        expect(finder, findsOneWidget);
      });

      testWidgets(
        'shows checked checkbox when isTracked is true',
        (tester) async {
          await pumpWidget(tester, isTracked: true);

          final finder = find.descendant(
            of: find.byType(CheckboxListTile),
            matching: find.byType(Checkbox),
          );
          expect(finder, findsOneWidget);
          final widget = tester.widget<Checkbox>(finder);

          expect(widget.value, isTrue);
        },
      );

      testWidgets(
        'shows unchecked checkbox when isTracked is false',
        (tester) async {
          // ignore: avoid_redundant_argument_values need verbosity
          await pumpWidget(tester, isTracked: false);

          final finder = find.descendant(
            of: find.byType(CheckboxListTile),
            matching: find.byType(Checkbox),
          );
          expect(finder, findsOneWidget);
          final widget = tester.widget<Checkbox>(finder);

          expect(widget.value, isFalse);
        },
      );
    });

    group('Interactions', () {
      testWidgets(
        'calls onChanged when the tile is pressed with correct isTracked',
        (tester) async {
          var value = false;
          await pumpWidget(
            tester,
            onChanged: (context, {required isTracked}) {
              value = isTracked;
            },
          );

          final finder = find.ancestor(
            of: find.text(mockRoutine.name),
            matching: find.byType(CheckboxListTile),
          );
          expect(finder, findsOneWidget);

          await tester.tap(finder);
          await tester.pumpAndSettle();
          expect(value, isTrue);
        },
      );
    });
  });
}
