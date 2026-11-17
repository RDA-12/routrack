part of 'single_routine_bloc.dart';

/// States for [SingleRoutineBloc]
sealed class SingleRoutineState extends Equatable {
  const new();

  @override
  List<Object> get props => [];
}

/// Initial state
final class SingleRoutineInitial extends SingleRoutineState {
  /// Creates new [SingleRoutineInitial]
  const new();
}

/// Loading data state
final class SingleRoutineLoadData extends SingleRoutineState {
  /// Creates new [SingleRoutineLoadData]
  const new();
}

/// Data loaded state
final class SingleRoutineLoadSuccess extends SingleRoutineState {
  /// Creates new [SingleRoutineLoadSuccess]
  const new({
    required this.routine,
  });

  /// Loaded [Routine] data
  final Routine routine;

  @override
  List<Object> get props => [routine];
}

/// Failed state
final class SingleRoutineLoadFailed extends SingleRoutineState {
  /// Creates new [SingleRoutineLoadFailed]
  const new({
    required this.exception,
  });

  /// [AppException] returned
  final AppException exception;

  @override
  List<Object> get props => [exception];
}
