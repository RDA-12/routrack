part of 'routine_mutation_bloc.dart';

/// Events for [RoutineMutationBloc]
sealed class RoutineMutationEvent extends Equatable {
  /// Creates new [RoutineMutationEvent]
  const new();

  @override
  List<Object> get props => [];
}

/// Event to queue new routine creation
class RoutineMutationCreationRequested extends RoutineMutationEvent {
  /// Creates new [RoutineMutationCreationRequested]
  const new({
    required this.params,
  });

  /// params that will be used to create new routine
  final CreateRoutineParams params;

  @override
  List<Object> get props => [params];
}
