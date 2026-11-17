import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/routine/routine.dart';

part 'single_routine_event.dart';
part 'single_routine_state.dart';

/// Bloc to load single [Routine] data
@Injectable(env: [Environment.prod])
class SingleRoutineBloc extends Bloc<SingleRoutineEvent, SingleRoutineState>
    with Loggable {
  /// Creates new [SingleRoutineBloc]
  new({
    required this._watchRoutineByIdUseCase,
  }) : super(const SingleRoutineInitial()) {
    on<SingleRoutineSubscribeByIdRequested>(
      _onSingleRoutineSubscribeByIdRequested,
      transformer: restartable(),
    );
  }

  final WatchRoutineByIdUseCase _watchRoutineByIdUseCase;

  Future<void> _onSingleRoutineSubscribeByIdRequested(
    SingleRoutineSubscribeByIdRequested event,
    Emitter<SingleRoutineState> emit,
  ) async {
    logInfo(
      'SingleRoutineSubscribeByIdRequested event received. Emits loading state',
    );
    emit(const SingleRoutineLoadData());

    logInfo('delegate watching single Routine to WatchRoutineByIdUseCase');
    await emit.forEach(
      _watchRoutineByIdUseCase(event.id),
      onData: (result) {
        switch (result) {
          case AppResultSuccess<Routine>(:final data):
            logInfo('new routine received. Emit loaded state');
            return SingleRoutineLoadSuccess(routine: data);
          case AppResultFailed<Routine>(:final exception):
            logInfo('failed result received. Emit failed state');
            return SingleRoutineLoadFailed(exception: exception);
        }
      },
    );
  }
}
