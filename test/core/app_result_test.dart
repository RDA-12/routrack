import 'package:flutter_test/flutter_test.dart';
import 'package:routrack/core/app_exception.dart';
import 'package:routrack/core/app_result.dart';

void main() {
  group('AppResultSuccess', () {
    test('equals on data', () {
      const i1 = AppResultSuccess('data');
      const i2 = AppResultSuccess('data');
      const i3 = AppResultSuccess('data2');

      expect(i1, equals(i2));
      expect(i1, isNot(equals(i3)));
    });
  });

  group('AppResultFailed', () {
    test('equals on exception', () {
      final exception = Exception();
      final i1 = AppResultFailed<int>(
        UnexpectedException(exception: exception),
      );
      final i2 = AppResultFailed<int>(
        UnexpectedException(exception: exception),
      );
      final i3 = AppResultFailed<int>(
        UnexpectedException(exception: Exception('lol')),
      );

      expect(i1, equals(i2));
      expect(i1, isNot(equals(i3)));
    });
  });

  group('AppResult', () {
    test('returns correct result for .success factory', () {
      const expected = AppResultSuccess('data');
      final actual = AppResult.success('data');

      expect(actual, equals(expected));
    });

    test('returns correct result for .failed factory', () {
      final exception = Exception();

      final expected = AppResultFailed<int>(
        UnexpectedException(exception: exception),
      );
      final actual = AppResult<int>.failed(
        UnexpectedException(exception: exception),
      );

      expect(actual, equals(expected));
    });
  });
}
