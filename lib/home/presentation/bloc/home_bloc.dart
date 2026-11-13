import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/routine/routine.dart';
import 'package:routrack/tracker/tracker.dart';
import 'package:rxdart/rxdart.dart';

part 'home_event.dart';
part 'home_state.dart';

/// Bloc to read data needed by Home page
@Injectable(env: [Environment.prod])
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// Creates new [HomeBloc]
  new({
    required this._watchRoutines,
    required this._watchLatestRoutineTrackerUseCase,
    required this._clock,
  }) : super(const HomeInitial()) {
    on<HomeSubscriptionRequested>(
      _onHomeSubscriptionRequested,
      transformer: restartable(),
    );
  }

  final AppClock _clock;
  final WatchRoutines _watchRoutines;
  final WatchLatestRoutineTrackerUseCase _watchLatestRoutineTrackerUseCase;

  Future<void> _onHomeSubscriptionRequested(
    HomeSubscriptionRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoadingData());

    final routinesStream = _watchRoutines(
      WatchRoutinesParams(date: _clock.getCurrentDateTime()),
    );
    final trackersStream = _watchLatestRoutineTrackerUseCase();
    final stream = CombineLatestStream.combine2(
      routinesStream,
      trackersStream,
      (routinesResult, trackersResult) {
        // routine id -> Tracker
        final trackers = <String, Tracker>{};
        switch (trackersResult) {
          case AppResultSuccess<List<Tracker>>(:final data):
            for (final tracker in data) {
              trackers[tracker.routineId] = tracker;
            }
          case AppResultFailed<List<Tracker>>(:final exception):
            return HomeLoadingFailed(exception: exception);
        }
        switch (routinesResult) {
          case AppResultSuccess<List<Routine>>(:final data):
            final routines = <TrackableRoutine>[];
            for (final routine in data) {
              routines.add(
                TrackableRoutine(
                  routine: routine,
                  lastTracked: trackers[routine.id],
                ),
              );
            }
            return HomeLoadingSuccess(todayRoutines: routines);
          case AppResultFailed<List<Routine>>(:final exception):
            return HomeLoadingFailed(exception: exception);
        }
      },
    );

    await emit.forEach(
      stream,
      onData: (result) => result,
    );
  }
}
