part of 'routine_tracker_bloc.dart';

/// State for [RoutineTrackerBloc]
final class RoutineTrackerState extends Equatable {
  /// Creates new [RoutineTrackerState]
  const new({
    this.loadingIds = const {},
    this.notice,
  });

  /// Set of routine ID
  final Set<String> loadingIds;

  /// Notice that need to be showed to user
  final NoticeUI<Routine>? notice;

  @override
  List<Object?> get props => [loadingIds, notice];
}
