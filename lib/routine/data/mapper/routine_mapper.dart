import 'package:routrack/common/common.dart';
import 'package:routrack/routine/domain/domain.dart';

/// Mapper to map [CreateRoutineParams] to data specific object
extension CreateRoutineMapper on CreateRoutineParams {
  /// Returns database object for this
  RoutineTableCompanion toDatabase({
    required String id,
    required DateTime createdAt,
  }) => RoutineTableCompanion.insert(
    id: id,
    name: name,
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
