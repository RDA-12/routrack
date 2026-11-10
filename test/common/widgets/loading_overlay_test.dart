import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';

import '../../helper.dart';

class _ChildWidget extends StatelessWidget {
  const new({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: const Text('shows'),
    );
  }
}

void main() {
  Future<void> pumpWidget(
    WidgetTester tester, {
    LoadingOverlayController? controller,
  }) {
    final effectiveController = controller ?? LoadingOverlayController();

    return tester.pumpWidgetForTest((context) {
      return LoadingOverlay(
        controller: effectiveController,
        builder: (context) {
          return _ChildWidget(
            onPressed: effectiveController.show,
          );
        },
      );
    });
  }

  group('LoadingOverlayController', () {
    test('initially set state to idle and result to null', () {
      final controller = LoadingOverlayController();

      expect(controller.state, LoadingOverlayState.idle);
      expect(controller.result, isNull);
    });

    test('set state to loading when show is called', () {
      final controller = LoadingOverlayController()..show();

      expect(controller.state, LoadingOverlayState.loading);
    });

    test(
      'do nothing when transitionToResult is called '
      'but the state is not loading',
      () {
        final streams = <bool>[];
        final controller = LoadingOverlayController()
          ..addListener(() {
            streams.add(true);
          });

        expect(controller.state, LoadingOverlayState.idle);
        expect(streams.isEmpty, isTrue);
      },
    );

    test('set state to result when transitionToResult called '
        'with valid state', () {
      final controller = LoadingOverlayController()
        ..show()
        ..transitionToResult(
          const LoadingOverlayResult(title: 'title', content: 'content'),
        );

      expect(controller.state, LoadingOverlayState.result);
      expect(
        controller.result,
        const LoadingOverlayResult(title: 'title', content: 'content'),
      );
    });

    test('set state to loading when close is called', () {
      final controller = LoadingOverlayController()..show();
      expect(controller.state, LoadingOverlayState.loading);

      controller.close();
      expect(controller.state, LoadingOverlayState.idle);
    });

    test('do nothing when close is called with state is idle', () {
      final streams = <bool>[];
      final controller = LoadingOverlayController()
        ..addListener(() {
          streams.add(true);
        });
      expect(controller.state, LoadingOverlayState.idle);

      controller.close();
      expect(streams.isEmpty, isTrue);
    });
  });

  group('LoadingOverlay', () {
    late LoadingOverlayController controller;

    setUp(() {
      controller = LoadingOverlayController();
    });

    Future<void> tapToShowLoading(WidgetTester tester) async {
      final finder = find.byType(FilledButton);
      await tester.tap(finder);
    }

    group('Render', () {
      testWidgets('shows only child initially', (tester) async {
        await pumpWidget(tester, controller: controller);

        final finder = find.byType(_ChildWidget);
        expect(finder, findsOneWidget);

        final loadingFinder = find.byType(LoadingIndicator);
        expect(loadingFinder, findsNothing);
      });

      testWidgets(
        'shows LoadingIndicator when show on LoadingOverlayController called',
        (tester) async {
          await pumpWidget(tester, controller: controller);
          final finder = find.byType(LoadingIndicator);
          expect(finder, findsNothing);

          await tapToShowLoading(tester);
          await tester.pump();

          expect(finder, findsOneWidget);
        },
      );

      testWidgets(
        'shows LoadingOverlayResultWidget when transition to result',
        (tester) async {
          controller.show();
          await pumpWidget(tester, controller: controller);

          const result = LoadingOverlayResult(
            title: 'title',
            content: 'content',
          );
          controller.transitionToResult(result);
          await tester.pump();

          final finder = find.byType(LoadingOverlayResultWidget);
          expect(finder, findsOneWidget);
          final widget = tester.widget<LoadingOverlayResultWidget>(finder);
          expect(widget.result, result);
        },
      );
    });
  });

  group('LoadingOverlayResultWidget', () {
    const result = LoadingOverlayResult(title: 'title', content: 'content');
    Future<void> pumpWidget(
      WidgetTester tester, {
      required LoadingOverlayResult result,
      VoidCallback? onClosePressed,
    }) {
      return tester.pumpWidgetForTest((context) {
        return LoadingOverlayResultWidget(
          result: result,
          onClosePressed: onClosePressed ?? () {},
        );
      });
    }

    group('Render', () {
      testWidgets('shows title when provided', (tester) async {
        await pumpWidget(tester, result: result);

        final finder = find.descendant(
          of: find.byType(LoadingOverlayResultWidget),
          matching: find.text(result.title!),
        );
        expect(finder, findsOneWidget);
      });

      testWidgets('shows content', (tester) async {
        await pumpWidget(tester, result: result);

        final finder = find.descendant(
          of: find.byType(LoadingOverlayResultWidget),
          matching: find.text(result.content),
        );
        expect(finder, findsOneWidget);
      });

      testWidgets('shows close button', (tester) async {
        await pumpWidget(tester, result: result);

        final finder = find.descendant(
          of: find.byType(LoadingOverlayResultWidget),
          matching: find.descendant(
            of: find.byType(TextButton),
            matching: find.text('Close'),
          ),
        );
        expect(finder, findsOneWidget);
      });
    });

    group('Interactions', () {
      testWidgets(
        'calls onClosePressed when close button is pressed',
        (tester) async {
          var pressed = false;
          await pumpWidget(
            tester,
            result: result,
            onClosePressed: () {
              pressed = true;
            },
          );

          final finder = find.descendant(
            of: find.byType(LoadingOverlayResultWidget),
            matching: find.byType(TextButton),
          );
          await tester.tap(finder);

          expect(pressed, isTrue);
        },
      );
    });
  });
}
