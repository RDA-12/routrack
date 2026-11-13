part of 'routine_tracker_bloc.dart';

/// Events for [RoutineTrackerBloc]
sealed class RoutineTrackerEvent extends Equatable {
  const new();

  @override
  List<Object> get props => [];
}

/// Event to track [routine] routine occurred in [date]
class RoutineTrackerTrackRequested extends RoutineTrackerEvent {
  /// Creates new [RoutineTrackerTrackRequested]
  const new({
    required this.routine,
    required this.date,
  });

  /// The routine that will be tracked
  final Routine routine;

  /// When the routine happened
  final DateTime date;

  @override
  List<Object> get props => [routine, date];
}
