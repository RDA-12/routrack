part of 'single_routine_bloc.dart';

/// Events for [SingleRoutineBloc]
sealed class SingleRoutineEvent extends Equatable {
  const new();

  @override
  List<Object> get props => [];
}

/// Event to subscribe single [Routine] by its id
class SingleRoutineSubscribeByIdRequested extends SingleRoutineEvent {
  /// Creates new [SingleRoutineSubscribeByIdRequested]
  const new(this.id);

  /// ID of [Routine] that will be loaded
  final String id;

  @override
  List<Object> get props => [id];
}
