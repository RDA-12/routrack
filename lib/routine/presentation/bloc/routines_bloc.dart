import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/routine/domain/domain.dart';

part 'routines_event.dart';
part 'routines_state.dart';

/// Bloc to read routines data
@Injectable(env: [Environment.prod])
class RoutinesBloc extends Bloc<RoutinesEvent, RoutinesState> with Loggable {
  /// Creates new [RoutinesBloc]
  new({required this._watchRoutines}) : super(const RoutinesInitial()) {
    on<RoutinesSubscriptionRequested>(
      _onRoutinesSubscriptionRequested,
      transformer: restartable(),
    );
  }

  final WatchRoutines _watchRoutines;

  Future<void> _onRoutinesSubscriptionRequested(
    RoutinesSubscriptionRequested event,
    Emitter<RoutinesState> emit,
  ) async {
    logInfo(
      'RoutinesSubscriptionRequested event received. Emits loading state',
    );
    emit(const RoutinesLoadingData());

    logInfo('delegating watching for routines change to WatchRoutines');
    await emit.forEach(
      _watchRoutines(),
      onData: (result) {
        switch (result) {
          case AppResultSuccess<List<Routine>>(:final data):
            logInfo('new routines received. Emits loaded state');
            return RoutinesLoadSuccess(routines: data);
          case AppResultFailed<List<Routine>>(:final exception):
            logInfo('failed result received. Emits failed state');
            return RoutinesLoadFailed(exception: exception);
        }
      },
    );
  }
}
