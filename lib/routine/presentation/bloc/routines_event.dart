part of 'routines_bloc.dart';

/// Events for [RoutinesBloc]
sealed class RoutinesEvent extends Equatable {
  const new();

  @override
  List<Object> get props => [];
}

/// Event to start subscription to schedules changes
class RoutinesSubscriptionRequested extends RoutinesEvent {
  /// Creates new [RoutinesSubscriptionRequested]
  const new();

  @override
  List<Object> get props => [];
}
