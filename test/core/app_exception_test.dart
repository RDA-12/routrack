import 'package:flutter_test/flutter_test.dart';
import 'package:routrack/core/app_exception.dart';

void main() {
  group('UnexpectedException', () {
    test('equals on exception', () {
      final exception = Exception();
      final i1 = UnexpectedException(exception: exception);
      final i2 = UnexpectedException(exception: exception);
      final i3 = UnexpectedException(exception: Exception('message'));

      expect(i1, equals(i2));
      expect(i1, isNot(equals(i3)));
    });
  });
}
