import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/widgets/loading_indicator.dart';

import '../../helper.dart';

void main() {
  Future<void> pumpWidget(
    WidgetTester tester, {
    double? size,
  }) {
    return tester.pumpWidgetForTest((context) {
      return LoadingIndicator(
        size: size ?? 32,
      );
    });
  }

  group('LoadingIndicator', () {
    group('Render', () {
      testWidgets(
        'shows CircularProgressIndicator with correct size',
        (tester) async {
          await pumpWidget(tester, size: 128);

          final indicatorFinder = find.byType(CircularProgressIndicator);
          expect(indicatorFinder, findsOneWidget);

          final sizeWidget = tester.widget<SizedBox>(
            find.ancestor(of: indicatorFinder, matching: find.byType(SizedBox)),
          );
          expect(sizeWidget.width, 128);
          expect(sizeWidget.height, 128);
        },
      );
    });
  });
}
