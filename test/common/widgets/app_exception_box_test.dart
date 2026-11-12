import 'package:flutter_test/flutter_test.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';

import '../../helper.dart';

void main() {
  Future<void> pumpWidget(
    WidgetTester tester, {
    String? title,
    AppException? exception,
  }) {
    return tester.pumpWidgetForTest(
      (context) => AppExceptionBox(
        title: title,
        exception: exception ?? AppException.test(),
      ),
    );
  }

  group('AppExceptionBox', () {
    group('Render', () {
      testWidgets('shows title when provided', (tester) async {
        await pumpWidget(tester, title: 'title');

        final finder = find.text('title');

        expect(finder, findsOneWidget);
      });

      testWidgets('shows correct message based on exception', (tester) async {
        await pumpWidget(
          tester,
          exception: UnexpectedException(exception: Exception()),
        );

        final finder = find.text(
          'There is unexpected failure happened. '
          'We will take a look into that shortly. '
          'Please, try again later',
        );

        expect(finder, findsOneWidget);
      });
    });
  });
}
