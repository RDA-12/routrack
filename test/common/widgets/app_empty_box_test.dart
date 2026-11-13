import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';

import '../../helper.dart';

void main() {
  Future<void> pumpWidget(
    WidgetTester tester, {
    String? title,
    String? content,
    Widget? action,
  }) {
    return tester.pumpWidgetForTest((context) {
      return AppEmptyBox(
        title: title,
        content: content ?? '',
        action: action,
      );
    });
  }

  group('AppEmptyBox', () {
    group('Render', () {
      testWidgets('shows title when provided', (tester) async {
        await pumpWidget(tester, title: 'title');

        final finder = find.text('title');

        expect(finder, findsOneWidget);
      });

      testWidgets('shows content', (tester) async {
        await pumpWidget(tester, content: 'content');

        final finder = find.text('content');

        expect(finder, findsOneWidget);
      });

      testWidgets('shows action when provided', (tester) async {
        await pumpWidget(
          tester,
          action: FilledButton(onPressed: () {}, child: const Text('action')),
        );

        final finder = find.ancestor(
          of: find.text('action'),
          matching: find.byType(FilledButton),
        );

        expect(finder, findsOneWidget);
      });
    });
  });
}
