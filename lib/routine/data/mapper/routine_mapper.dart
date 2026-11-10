import 'package:routrack/common/common.dart';
import 'package:routrack/routine/domain/domain.dart';

/// Mapper to map [CreateRoutineParams] to data specific object
extension CreateRoutineMapper on CreateRoutineDBParams {
  /// Returns database object of this for routine table
  RoutineTableCompanion toRoutineDatabase({
    required String id,
    required DateTime createdAt,
  }) => RoutineTableCompanion.insert(
    id: id,
    name: name,
    createdAt: createdAt,
    updatedAt: createdAt,
  );

  /// Returns database object of this for schedule table
  ScheduleTableCompanion toScheduleDatabase({
    required String id,
    required String routineId,
    required DateTime createdAt,
  }) => ScheduleTableCompanion.insert(
    id: id,
    routineId: routineId,
    recurrence: recurrence,
    createdAt: createdAt,
    updatedAt: createdAt,
  );
}

/// Mapper to map [RoutineTableData] to [Routine]
extension RoutineMapper on RoutineTableData {
  /// Return [Routine] object for this
  Routine toDomain() {
    return Routine(id: id, name: name);
  }
}
