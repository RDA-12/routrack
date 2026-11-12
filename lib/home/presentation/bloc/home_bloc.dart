import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/routine/routine.dart';

part 'home_event.dart';
part 'home_state.dart';

/// Bloc to read data needed by Home page
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// Creates new [HomeBloc]
  new({
    required this._watchRoutines,
    required this._clock,
  }) : super(const HomeInitial()) {
    on<HomeSubscriptionRequested>(
      _onHomeSubscriptionRequested,
      transformer: restartable(),
    );
  }

  final AppClock _clock;
  final WatchRoutines _watchRoutines;

  Future<void> _onHomeSubscriptionRequested(
    HomeSubscriptionRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoadingData());

    await emit.forEach(
      _watchRoutines(WatchRoutinesParams(date: _clock.getCurrentDateTime())),
      onData: (result) {
        switch (result) {
          case AppResultSuccess<List<Routine>>(:final data):
            return HomeLoadingSuccess(todayRoutines: data);
          case AppResultFailed<List<Routine>>(:final exception):
            return HomeLoadingFailed(exception: exception);
        }
      },
    );
  }
}
