import 'package:equatable/equatable.dart';

/// Representing single schedule of a routine
class RoutineSchedule extends Equatable {
  /// Creates new [RoutineSchedule]
  const new({
    required this.id,
    required this.routineId,
    required this.recurrence,
  });

  /// ID of this schedule
  final String id;

  /// ID of routine of this schedule
  final String routineId;

  /// List of recurrence rules based on RFC 5545
  final List<String> recurrence;

  @override
  List<Object?> get props => [id, routineId, recurrence];
}
