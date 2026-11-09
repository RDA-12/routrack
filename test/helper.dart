import 'package:flutter_test/flutter_test.dart';
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
