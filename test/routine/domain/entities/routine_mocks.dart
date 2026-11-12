import 'package:routrack/routine/routine.dart';

const mockRoutine = Routine(
  id: 'routine-id',
  name: 'routine-name',
);

final mockSchedule = RoutineSchedule(
  id: 'schedule-id',
  routineId: mockRoutine.id,
  recurrence: const ['RRULE:FREQ=DAILY;BYDAY=MO,TU'],
);

final List<Routine> mockRoutines = List.generate(5, (index) {
  return Routine(id: '$index', name: 'routine-$index');
});
