part of 'home_bloc.dart';

/// States for [HomeBloc]
sealed class HomeState extends Equatable {
  const new();

  @override
  List<Object> get props => [];
}

/// Initial home state
final class HomeInitial extends HomeState {
  /// Creates new [HomeInitial]
  const new();
}

/// Loading data state
final class HomeLoadingData extends HomeState {
  /// Creates new [HomeLoadingData]
  const new();

  @override
  List<Object> get props => [];
}

/// Data loaded state
final class HomeLoadingSuccess extends HomeState {
  /// Creates new [HomeLoadingSuccess]
  const new({
    required this.todayRoutines,
  });

  /// List of [TrackableRoutineUI] that need to be done to day
  final List<TrackableRoutineUI> todayRoutines;

  @override
  List<Object> get props => [todayRoutines];
}

/// Data failed to be loaded
final class HomeLoadingFailed extends HomeState {
  /// Creates new [HomeLoadingFailed]
  const new({
    required this.exception,
  });

  /// [AppException] returned
  final AppException exception;

  @override
  List<Object> get props => [exception];
}
