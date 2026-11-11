import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/routine/routine.dart';

import '../../../helper.dart';

void main() {
  Future<void> pumpWidget(
    WidgetTester tester, {
    OnRoutineSaved? onRoutineSaved,
  }) {
    return tester.pumpWidgetForTest((context) {
      return RoutineForm(
        onRoutineSaved: onRoutineSaved,
      );
    });
  }

  group('RoutineForm', () {
    Future<void> tapSaveButton(WidgetTester tester) async {
      final saveButtonFinder = find.ancestor(
        of: find.text('Save'),
        matching: find.byType(FilledButton),
      );
      await tester.ensureVisible(saveButtonFinder);
      await tester.tap(saveButtonFinder);
      await tester.pumpAndSettle();
    }

    Future<void> enterName(String name, {required WidgetTester tester}) async {
      final nameFieldFinder = find.ancestor(
        of: find.text('Routine Name'),
        matching: find.byType(TextFormField),
      );
      await tester.enterText(nameFieldFinder, name);
    }

    Future<void> selectDays(
      Set<WeekDay> days, {
      required WidgetTester tester,
    }) async {
      for (final day in days) {
        final finder = find.ancestor(
          of: find.text(day.name),
          matching: find.byType(CheckboxListTile),
        );
      await tester.ensureVisible(finder);
        await tester.tap(finder);
      }
    }

    group('Render', () {
      testWidgets('shows name field', (tester) async {
        await pumpWidget(tester);

        final finder = find.ancestor(
          of: find.text('Routine Name'),
          matching: find.byType(TextFormField),
        );
        expect(finder, findsOneWidget);

        final helperTextFinder = find.descendant(
          of: finder,
          matching: find.text('minimum 6 letters'),
        );
        expect(helperTextFinder, findsOneWidget);

        final hintTextFinder = find.descendant(
          of: finder,
          matching: find.text('e.g. do 1 push up, drink at least 1.5 liters'),
        );
        expect(hintTextFinder, findsOneWidget);

        final counterTextFinder = find.descendant(
          of: finder,
          matching: find.text('0/32'),
        );
        expect(counterTextFinder, findsOneWidget);
      });

      testWidgets('shows save button', (tester) async {
        await pumpWidget(tester);

        final finder = find.ancestor(
          of: find.text('Save'),
          matching: find.byType(FilledButton),
        );

        expect(finder, findsOneWidget);
      });

      testWidgets(
        'shows required error text when submit with empty name',
        (tester) async {
          await pumpWidget(tester, onRoutineSaved: (params) {});

          await tapSaveButton(tester);

          expect(
            find.text('routine name is required'),
            findsOneWidget,
          );
        },
      );

      testWidgets('shows WeekDaySelector', (tester) async {
        await pumpWidget(tester);

        final finder = find.byType(WeekDaySelector);

        expect(finder, findsOneWidget);
      });
    });

    group('Interactions', () {
      testWidgets(
        'calls onRoutineSaved when save button pressed with valid fields',
        (tester) async {
          late final CreateRoutineParams params;
          await pumpWidget(
            tester,
            onRoutineSaved: (value) {
              params = value;
            },
          );

          await enterName('name', tester: tester);
          await selectDays({.mon, .fri}, tester: tester);
          await tapSaveButton(tester);

          expect(
            params,
            const CreateRoutineParams(name: 'name', days: {.mon, .fri}),
          );
        },
      );
    });
  });
}
