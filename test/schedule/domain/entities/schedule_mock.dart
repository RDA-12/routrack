import 'package:routrack/schedule/schedule.dart';

import '../../../routine/domain/entities/routine_mocks.dart';

final mockSchedule = Schedule(
  id: 'schedule-id',
  routineId: mockRoutine.id,
  recurrence: const [],
);
