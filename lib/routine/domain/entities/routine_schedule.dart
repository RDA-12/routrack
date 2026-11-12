import 'package:equatable/equatable.dart';
import 'package:routrack/common/common.dart';

/// Representing single schedule of a routine
class RoutineSchedule extends Equatable {
  /// Creates new [RoutineSchedule]
  const new({
    required this.id,
    required this.routineId,
    required this.recurrence,
    required this.status,
  });

  /// ID of this schedule
  final String id;

  /// ID of routine of this schedule
  final String routineId;

  /// Status of this schedule
  final ScheduleStatus status;

  /// List of recurrence rules based on RFC 5545
  final List<String> recurrence;

  @override
  List<Object?> get props => [id, routineId, recurrence];
}
