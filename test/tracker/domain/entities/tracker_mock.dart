import 'package:collection/collection.dart';
import 'package:routrack/routine/routine.dart';
import 'package:routrack/tracker/tracker.dart';

import '../../../routine/domain/entities/routine_mocks.dart';

final mockTracker = Tracker(
  id: 'tracker-id',
  routineId: mockRoutine.id,
  date: DateTime.timestamp(),
);

final List<Tracker> mockTrackers = mockRoutines.mapIndexed((index, it) {
  return Tracker(
    id: 'tracker-$index',
    routineId: it.id,
    date: DateTime.timestamp().add(Duration(days: -index)),
  );
}).toList();

final mockTrackableRoutine = TrackableRoutine(
  routine: mockRoutine,
  lastTracked: mockTracker,
);

final List<TrackableRoutineUI> mockTrackableRoutinesUI = List.generate(
  5,
  (index) {
    final routine = Routine(
      id: 'routine-$index',
      name: 'Routine $index',
      activeSchedule: RoutineSchedule(
        id: 'schedule-$index',
        routineId: 'routine-$index',
        recurrence: const ['RRULE:FREQ=DAILY;BYDAY=MO'],
        status: .active,
      ),
    );
    return TrackableRoutineUI(
      trackable: TrackableRoutine(
        routine: routine,
        lastTracked: index.isOdd
            ? null
            : Tracker(
                id: 'tracker-$index',
                routineId: routine.id,
                date: DateTime.timestamp(),
              ),
      ),
      isTracked: index.isOdd,
    );
  },
);
