import 'package:routrack/common/common.dart';
import 'package:routrack/tracker/domain/domain.dart';

/// Mapper to map [TrackRoutineParams] to data specific object
extension CreateTrackerMapper on TrackRoutineParams {
  /// Returns database object of this for routine table
  TrackerTableCompanion toTrackerDatabase({
    required String id,
    required DateTime createdAt,
  }) => TrackerTableCompanion.insert(
    id: id,
    routineId: routineId,
    date: date,
    createdAt: createdAt,
    updatedAt: createdAt,
  );
}

/// Mapper to map [TrackerTableData] to [Tracker]
extension TrackerMapper on TrackerTableData {
  /// Return [Tracker] object of this
  Tracker toDomain() {
    return Tracker(
      id: id,
      routineId: routineId,
      date: date,
    );
  }
}
