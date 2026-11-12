import 'package:routrack/routine/routine.dart';

final mockRoutine = Routine(
  id: 'routine-id',
  name: 'routine-name',
  activeSchedule: RoutineSchedule(
    id: 'schedule-id',
    routineId: 'routine-id',
    status: .active,
    recurrence: const ['RRULE:FREQ=DAILY;BYDAY=MO,TU'],
  ),
);

final mockSchedule = RoutineSchedule(
  id: 'schedule-id',
  routineId: mockRoutine.id,
  status: .active,
  recurrence: const ['RRULE:FREQ=DAILY;BYDAY=MO,TU'],
);

final List<Routine> mockRoutines = List.generate(5, (index) {
  return Routine(
    id: '$index',
    name: 'routine-$index',
    activeSchedule: RoutineSchedule(
      id: '$index',
      routineId: '$index',
      recurrence: mockSchedule.recurrence,
      status: .active,
    ),
  );
});
