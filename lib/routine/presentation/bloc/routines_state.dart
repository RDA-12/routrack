part of 'routines_bloc.dart';

/// State for [RoutinesBloc]
sealed class RoutinesState extends Equatable {
  const new();

  @override
  List<Object> get props => [];
}

/// Initial state
final class RoutinesInitial extends RoutinesState {
  /// Creates new [RoutinesInitial]
  const new();
}

/// Loading state
final class RoutinesLoadingData extends RoutinesState {
  /// Creates new [RoutinesLoadingData]
  const new();

  @override
  List<Object> get props => [];
}

/// List of [Routine] is loaded
final class RoutinesLoadSuccess extends RoutinesState {
  /// Creates new [RoutinesLoadSuccess]
  const new({required this.routines});

  /// Loaded routines
  final List<Routine> routines;

  @override
  List<Object> get props => [routines];
}

/// Failed to load routines state
class RoutinesLoadFailed extends RoutinesState {
  /// Creates new [RoutinesLoadFailed]
  const new({required this.exception});

  /// [AppException] thrown
  final AppException exception;

  @override
  List<Object> get props => [exception];
}
