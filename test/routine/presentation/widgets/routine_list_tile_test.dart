import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/routine/presentation/widgets/routine_list_tile.dart';

import '../../../helper.dart';
import '../../domain/entities/routine_mocks.dart';

void main() {
  Future<void> pumpWidget(WidgetTester tester, {VoidCallback? onPressed}) {
    return tester.pumpWidgetForTest(
      (context) => RoutineListTile(
        routine: mockRoutine,
        onPressed: onPressed,
      ),
    );
  }

  group('RoutineListTile', () {
    group('Render', () {
      testWidgets('shows routine name', (tester) async {
        await pumpWidget(tester);

        final finder = find.descendant(
          of: find.byType(ListTile),
          matching: find.text(mockRoutine.name),
        );

        expect(finder, findsOneWidget);
      });
    });

    group('Interactions', () {
      testWidgets(
        'calls onPressed when the tile is pressed',
        (tester) async {
          var pressed = false;
          await pumpWidget(
            tester,
            onPressed: () {
              pressed = true;
            },
          );

          final finder = find.ancestor(
            of: find.text(mockRoutine.name),
            matching: find.byType(ListTile),
          );
          expect(finder, findsOneWidget);

          await tester.tap(finder);

          expect(pressed, isTrue);
        },
      );
    });
  });
}
