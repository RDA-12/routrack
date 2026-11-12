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
    extends Bloc<RoutineMutationEvent, RoutineMutationState> {
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
    emit(const RoutineMutationState(isCreating: true));

    final result = await _createRoutineUseCase(event.params);
    switch (result) {
      case AppResultSuccess<Routine>(:final data):
        emit(
          RoutineMutationState(
            notice: CreatedNoticeUI(data: data),
          ),
        );
      case AppResultFailed<Routine>(:final exception):
        emit(
          RoutineMutationState(
            notice: FailedNoticeUI(
              data: Routine(
                id: 'failed',
                name: event.params.name,
                activeSchedule: const RoutineSchedule(
                  id: 'id',
                  routineId: 'routineId',
                  recurrence: [],
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
