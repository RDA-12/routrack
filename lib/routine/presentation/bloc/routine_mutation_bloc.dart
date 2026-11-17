import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/app_result.dart';
import 'package:routrack/routine/domain/domain.dart';

part 'routine_mutation_event.dart';
part 'routine_mutation_state.dart';

/// Bloc to mutate Routine data
@Injectable(env: [Environment.prod])
class RoutineMutationBloc
    extends Bloc<RoutineMutationEvent, RoutineMutationState>
    with Loggable {
  /// Creates new [RoutineMutationBloc]
  new({required this._createRoutineUseCase})
    : super(const RoutineMutationState()) {
    on<RoutineMutationCreationRequested>(_onRoutineMutationCreationRequested);
  }

  final CreateRoutineUseCase _createRoutineUseCase;

  Future<void> _onRoutineMutationCreationRequested(
    RoutineMutationCreationRequested event,
    Emitter<RoutineMutationState> emit,
  ) async {
    logInfo(
      'RoutineMutationCreationRequested event received. Emits loading state',
    );
    emit(const RoutineMutationState(isCreating: true));

    logInfo('delegating routine creation to CreateRoutineUseCase');
    final result = await _createRoutineUseCase(event.params);
    switch (result) {
      case AppResultSuccess<Routine>(:final data):
        logInfo('routine created. Emits Created notice');
        emit(
          RoutineMutationState(
            notice: CreatedNoticeUI(data: data),
          ),
        );
      case AppResultFailed<Routine>(:final exception):
        logInfo('routine creation failed. Emits Failed notice');
        emit(
          RoutineMutationState(
            notice: FailedNoticeUI(
              data: Routine(
                id: 'failed',
                name: event.params.name,
                activeSchedule: RoutineSchedule(
                  id: 'id',
                  routineId: 'routineId',
                  recurrence: const [],
                  status: .active,
                ),
              ),
              operation: .create,
              exception: exception,
            ),
          ),
        );
    }
  }
}
