import 'package:equatable/equatable.dart';
import 'package:routrack/routine/routine.dart';

/// Represent single user's routine
class Routine extends Equatable {
  /// Creates new [Routine]
  const new({
    required this.id,
    required this.name,
    required this.activeSchedule,
  });

  /// ID of the routine
  final String id;

  /// Name of the routin
  final String name;

  /// Current active schedule of this routine
  final RoutineSchedule activeSchedule;

  @override
  List<Object?> get props => [id, name, activeSchedule];
}
