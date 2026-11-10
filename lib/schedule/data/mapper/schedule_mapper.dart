import 'package:routrack/common/common.dart';
import 'package:routrack/schedule/domain/domain.dart';

/// Mapper to map [CreateScheduleDBParams] to data specific object
extension CreateScheduleMapper on CreateScheduleDBParams {
  /// Returns database object for this
  ScheduleTableCompanion toDatabase({
    required String id,
    required DateTime createdAt,
  }) => ScheduleTableCompanion.insert(
    id: id,
    routineId: routineId,
    recurrence: recurrence,
    createdAt: createdAt,
    updatedAt: createdAt,
  );
}

/// Mapper to map [ScheduleTableData] to [Schedule]
extension ScheduleMapper on ScheduleTableData {
  /// Return [Schedule] object for this
  Schedule toDomain() {
    return Schedule(id: id, routineId: routineId, recurrence: recurrence);
  }
}
