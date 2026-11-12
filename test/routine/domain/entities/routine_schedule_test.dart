import 'package:flutter_test/flutter_test.dart';
import 'package:routrack/routine/routine.dart';

void main() {
  group('RoutineSchedule', () {
    test('equals on id, routineId, recurrence, status', () {
      final test = RoutineSchedule(
        id: 'id',
        routineId: 'routineId',
        recurrence: const [],
        status: .active,
      );
      final i1 = RoutineSchedule(
        id: 'id',
        routineId: 'routineId',
        recurrence: const [],
        status: .active,
      );
      final i2 = RoutineSchedule(
        id: 'id-2',
        routineId: 'routineId',
        recurrence: const [],
        status: .active,
      );
      final i3 = RoutineSchedule(
        id: 'id',
        routineId: 'routineId-2',
        recurrence: const [],
        status: .active,
      );
      final i4 = RoutineSchedule(
        id: 'id',
        routineId: 'routineId',
        recurrence: const ['RRULE:FREQ=DAILY'],
        status: .active,
      );
      final i5 = RoutineSchedule(
        id: 'id',
        routineId: 'routineId',
        recurrence: const [],
        status: .inactive,
      );

      expect(test, equals(i1));
      expect(test, isNot(equals(i2)));
      expect(test, isNot(equals(i3)));
      expect(test, isNot(equals(i4)));
      expect(test, isNot(equals(i5)));
    });

    group('includes', () {
      final schedule = RoutineSchedule(
        id: 'id',
        routineId: 'routineId',
        recurrence: const ['RRULE:FREQ=DAILY;BYDAY=MO'],
        status: .active,
      );
      test('returns false when provided date is within recurrence rules', () {
        var date = DateTime(2026, 11, 9);
        for (var i = 0; i < 6; i++) {
          date = date.add(const Duration(days: 1));
          final included = schedule.includes(date);
          expect(included, isFalse, reason: '$date');
        }
      });

      test('returns true when provided date is outside recurrence rules', () {
        var date = DateTime(2026, 11, 9);
        for (var i = 0; i < 6; i++) {
          date = date.add(const Duration(days: 7));
          final included = schedule.includes(date);
          expect(included, isTrue, reason: '$date');
        }
      });
    });
  });
}
