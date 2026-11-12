part of 'home_bloc.dart';

/// Events for [HomeBloc]
sealed class HomeEvent extends Equatable {
  const new();

  @override
  List<Object> get props => [];
}

/// Event to subscribe to data on home page
class HomeSubscriptionRequested extends HomeEvent {
  /// Creates new [HomeSubscriptionRequested]
  const new();

  @override
  List<Object> get props => [];
}
