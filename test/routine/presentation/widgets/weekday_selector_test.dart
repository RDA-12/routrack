import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/routine/routine.dart';

import '../../../helper.dart';

void main() {
  Future<void> pumpWidget(
    WidgetTester tester, {
    WeekDaySelectorController? controller,
    String? label,
  }) {
    final effectiveController = controller ?? WeekDaySelectorController();
    return tester.pumpWidgetForTest((context) {
      return WeekDaySelector(
        controller: effectiveController,
        label: label ?? 'Label',
      );
    });
  }

  group('WeekDaySelectorController', () {
    test('have initial empty selected', () {
      final controller = WeekDaySelectorController();

      expect(controller.selected.isEmpty, isTrue);
    });

    test('set initial selected from constructor', () {
      final controller = WeekDaySelectorController(initialSelected: {.mon});

      expect(controller.selected, <WeekDay>{.mon});
    });

    test('add day to selected when select called', () {
      final controller = WeekDaySelectorController()..select(.mon);

      expect(controller.selected, <WeekDay>{.mon});
    });

    test('add all days to selected when selectAll called', () {
      final controller = WeekDaySelectorController()..selectAll();

      expect(controller.selected, WeekDay.values.toSet());
    });

    test('remove day from selected when remove called', () {
      final controller = WeekDaySelectorController()
        ..select(.mon)
        ..select(.tue);
      expect(controller.selected, <WeekDay>{.mon, .tue});
      controller.deselect(.mon);

      expect(controller.selected, <WeekDay>{.tue});
    });

    test('remove all days from selected when clear called', () {
      final controller = WeekDaySelectorController()..selectAll();
      expect(controller.selected, WeekDay.values.toSet());

      controller.clear();

      expect(controller.selected, <WeekDay>{});
    });

    test('returns correct isSelected', () {
      final controller = WeekDaySelectorController()..select(.mon);

      expect(controller.isSelected(.mon), isTrue);
      expect(controller.isSelected(.wed), isFalse);
    });

    test('returns correct tristate', () {
      final controller = WeekDaySelectorController()..selectAll();

      expect(controller.tristate, isTrue);

      controller.deselect(.mon);
      expect(controller.tristate, isNull);

      controller.clear();
      expect(controller.tristate, isFalse);
    });
  });

  group('WeekDaySelector', () {
    group('Render', () {
      testWidgets('shows label', (tester) async {
        await pumpWidget(tester, label: 'Test');

        final finder = find.descendant(
          of: find.byType(CheckboxListTile),
          matching: find.text('Test'),
        );

        expect(finder, findsOneWidget);
      });

      testWidgets('shows correct weekdays checkboxes', (tester) async {
        final controller = WeekDaySelectorController(initialSelected: {.mon});
        await pumpWidget(tester, controller: controller);

        for (final day in WeekDay.values) {
          final finder = find.ancestor(
            of: find.text(day.name),
            matching: find.byType(CheckboxListTile),
          );
          expect(finder, findsOneWidget);
          final widget = tester.widget<CheckboxListTile>(finder);
          expect(widget.value, controller.isSelected(day));
        }
      });

      testWidgets('shows correct tristate value', (tester) async {
        final controller = WeekDaySelectorController();
        await pumpWidget(tester, controller: controller, label: 'text');

        final tristateCheckboxFinder = find.ancestor(
          of: find.text('text'),
          matching: find.byType(CheckboxListTile),
        );
        expect(tristateCheckboxFinder, findsOneWidget);

        CheckboxListTile getCheckbox() =>
            tester.widget<CheckboxListTile>(tristateCheckboxFinder);

        expect(getCheckbox().tristate, isTrue);
        expect(getCheckbox().value, isFalse);

        controller.select(.mon);
        await tester.pumpAndSettle();
        expect(getCheckbox().value, isNull);

        controller.selectAll();
        await tester.pumpAndSettle();
        expect(getCheckbox().value, isTrue);
      });
    });

    group('Interactions', () {
      testWidgets('allows selecting all days', (tester) async {
        final controller = WeekDaySelectorController();
        await pumpWidget(tester, controller: controller);

        final tristateFinder = find.ancestor(
          of: find.text('Label'),
          matching: find.byType(CheckboxListTile),
        );
        await tester.tap(tristateFinder);
        await tester.pumpAndSettle();

        expect(controller.selected, WeekDay.values.toSet());
      });

      testWidgets('allows select a day', (tester) async {
        final controller = WeekDaySelectorController();
        await pumpWidget(tester, controller: controller);

        final monFinder = find.ancestor(
          of: find.text(WeekDay.mon.name),
          matching: find.byType(CheckboxListTile),
        );
        await tester.tap(monFinder);
        await tester.pumpAndSettle();

        expect(controller.selected, <WeekDay>{.mon});
      });

      testWidgets('allows deselect a day', (tester) async {
        final controller = WeekDaySelectorController(initialSelected: {.mon});
        await pumpWidget(tester, controller: controller);
        expect(controller.selected, <WeekDay>{.mon});

        final monFinder = find.ancestor(
          of: find.text(WeekDay.mon.name),
          matching: find.byType(CheckboxListTile),
        );
        await tester.tap(monFinder);
        await tester.pumpAndSettle();

        expect(controller.selected, <WeekDay>{});
      });

      testWidgets('allows deselect all days', (tester) async {
        final controller = WeekDaySelectorController()..selectAll();
        await pumpWidget(tester, controller: controller);
        expect(controller.selected, WeekDay.values.toSet());

        final tristateFinder = find.ancestor(
          of: find.text('Label'),
          matching: find.byType(CheckboxListTile),
        );
        await tester.tap(tristateFinder);
        await tester.pumpAndSettle();

        expect(controller.selected, <WeekDay>{});
      });
    });
  });
}
