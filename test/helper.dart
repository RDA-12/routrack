import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/core/core.dart';

extension ThrowExpectation<T> on AppResult<T> {
  /// run [expect] to verify this [AppResult] is a [AppResultFailed] with
  /// [exception]
  void expectFailedWith(AppException exception) {
    expect(
      this,
      isA<AppResultFailed<T>>().having(
        (r) => r.exception,
        'exception',
        exception,
      ),
    );
  }
}

extension PumpExtension on WidgetTester {
  /// Pump [Widget] returned by [builder] for testing
  ///
  /// It includes [MaterialApp] and [Scaffold]
  Future<void> pumpWidgetForTest(
    Widget Function(BuildContext context) builder,
  ) {
    return pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(builder: builder),
        ),
      ),
    );
  }

  /// Pump [MaterialApp.router] with [GoRouter] initialized with
  /// [initialLocation] and [routes]
  Future<void> pumpPageForTest({
    required List<GoRoute> routes,
    String initialLocation = '/',
  }) {
    return pumpWidget(
      MaterialApp.router(
        routerConfig: GoRouter(
          initialLocation: initialLocation,
          routes: routes,
        ),
      ),
    );
  }
}
