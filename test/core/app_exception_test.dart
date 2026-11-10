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

  group('NotFoundException', () {
    test('equals on id, entity', () {
      final i1 = NotFoundException(entity: .routine, id: 'id');
      final i2 = NotFoundException(entity: .routine, id: 'id');
      final i3 = NotFoundException(entity: .routine, id: 'id-2');
      final i4 = NotFoundException(entity: .schedule, id: 'id');

      expect(i1, equals(i2));
      expect(i1, isNot(equals(i3)));
      expect(i1, isNot(equals(i4)));
    });
  });
}
