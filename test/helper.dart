import 'package:flutter_test/flutter_test.dart';
import 'package:routrack/core/core.dart';

extension ThrowExpectation<T> on AppResult<T> {
  void expectHas(AppException exception) {
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
