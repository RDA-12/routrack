import 'package:routrack/routine/routine.dart';

const mockRoutine = Routine(
  id: 'routine-id',
  name: 'routine-name',
  schedules: [
    RoutineSchedule(
      id: 'schedule-id',
      routineId: 'routine-id',
      recurrence: ['RRULE:FREQ=DAILY;BYDAY=MO,TU'],
    ),
  ],
);

final mockSchedule = RoutineSchedule(
  id: 'schedule-id',
  routineId: mockRoutine.id,
  recurrence: const ['RRULE:FREQ=DAILY;BYDAY=MO,TU'],
);
