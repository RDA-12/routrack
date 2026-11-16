import 'package:flutter_test/flutter_test.dart';
import 'package:routrack/tracker/tracker.dart';

void main() {
  group('Tracker', () {
    test('equals on id, routineId, date', () {
      final now = DateTime.timestamp();
      final test = Tracker(
        id: 'id',
        routineId: 'routineId',
        date: now,
      );
      final i1 = Tracker(
        id: 'id',
        routineId: 'routineId',
        date: now,
      );
      final i2 = Tracker(
        id: 'id-2',
        routineId: 'routineId',
        date: now,
      );
      final i3 = Tracker(
        id: 'id',
        routineId: 'routineId-3',
        date: now,
      );
      final i4 = Tracker(
        id: 'id',
        routineId: 'routineId',
        date: now.add(const Duration(days: 7)),
      );

      expect(test, equals(i1));
      expect(test, isNot(equals(i2)));
      expect(test, isNot(equals(i3)));
      expect(test, isNot(equals(i4)));
    });

    group('isSameDayAs', () {
      test('returns correct bool', () {
        final date = DateTime.utc(2026, 11, 10);
        final test = Tracker(
          id: 'id',
          routineId: 'routineId',
          date: date,
        );
        expect(test.isSameDayAs(date.add(const Duration(hours: 12))), isTrue);
        expect(test.isSameDayAs(DateTime.utc(2016, 11, 10)), isFalse);
        expect(test.isSameDayAs(DateTime.utc(2026, 9, 10)), isFalse);
        expect(test.isSameDayAs(DateTime.utc(2026, 9, 5)), isFalse);
      });
    });
  });
}
