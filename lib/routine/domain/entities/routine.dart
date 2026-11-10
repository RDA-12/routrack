import 'package:equatable/equatable.dart';
import 'package:routrack/routine/domain/entities/routine_schedule.dart';

/// Represent single user's routine
class Routine extends Equatable {
  /// Creates new [Routine]
  const new({
    required this.id,
    required this.name,
    required this.schedules,
  });

  /// ID of the routine
  final String id;

  /// Name of the routin
  final String name;

  /// List of schedule this routine have
  final List<RoutineSchedule> schedules;

  @override
  List<Object?> get props => [id, name, schedules];
}
