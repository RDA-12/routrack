import 'package:flutter_test/flutter_test.dart';
import 'package:routrack/routine/routine.dart';

import 'routine_mocks.dart';

void main() {
  group('Routine', () {
    test('equals on id, name, activeSchedule', () {
      final test = Routine(
        id: 'id',
        name: 'name',
        activeSchedule: mockSchedule,
      );
      final i1 = Routine(
        id: 'id',
        name: 'name',
        activeSchedule: mockSchedule,
      );
      final i2 = Routine(
        id: 'id-2',
        name: 'name',
        activeSchedule: mockSchedule,
      );
      final i3 = Routine(
        id: 'id',
        name: 'name-3',
        activeSchedule: mockSchedule,
      );
      final i4 = Routine(
        id: 'id',
        name: 'name',
        activeSchedule: RoutineSchedule(
          id: '0012',
          routineId: 'id',
          recurrence: const [],
          status: .active,
        ),
      );

      expect(test, equals(i1));
      expect(test, isNot(equals(i2)));
      expect(test, isNot(equals(i3)));
      expect(test, isNot(equals(i4)));
    });

    group('includes', () {
      final schedule = RoutineSchedule(
        id: 'id',
        routineId: 'routineId',
        recurrence: const ['RRULE:FREQ=DAILY;BYDAY=MO'],
        status: .active,
      );
      final routine = Routine(
        id: 'routineId',
        name: 'routine',
        activeSchedule: schedule,
      );
      test('returns false when routine is not scheduled in provided date', () {
        var date = DateTime(2026, 11, 9);
        for (var i = 0; i < 6; i++) {
          date = date.add(const Duration(days: 1));
          final included = routine.includes(date);
          expect(included, isFalse, reason: '$date');
        }
      });

      test('returns true when routine is scheduled in provided date', () {
        var date = DateTime(2026, 11, 9);
        for (var i = 0; i < 6; i++) {
          date = date.add(const Duration(days: 7));
          final included = routine.includes(date);
          expect(included, isTrue, reason: '$date');
        }
      });
    });
  });
}
