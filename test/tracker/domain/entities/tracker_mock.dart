import 'package:routrack/tracker/tracker.dart';

import '../../../routine/domain/entities/routine_mocks.dart';

final mockTracker = Tracker(
  id: 'tracker-id',
  routineId: mockRoutine.id,
  date: DateTime.now(),
);

final mockTrackableRoutine = TrackableRoutine(
  routine: mockRoutine,
  lastTracked: mockTracker,
);
