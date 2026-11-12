import 'package:flutter_test/flutter_test.dart';
import 'package:routrack/common/common.dart';

import '../../helper.dart';

void main() {
  Future<void> pumpWidget(
    WidgetTester tester, {
    String? title,
    String? content,
  }) {
    return tester.pumpWidgetForTest((context) {
      return AppEmptyBox(
        title: title,
        content: content ?? '',
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
    });
  });
}
