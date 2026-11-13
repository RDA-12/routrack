import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/app_result.dart';
import 'package:routrack/routine/routine.dart';
import 'package:routrack/tracker/domain/domain.dart';

part 'routine_tracker_event.dart';
part 'routine_tracker_state.dart';

/// Bloc to track routine occurence
@Injectable(env: [Environment.prod])
class RoutineTrackerBloc
    extends Bloc<RoutineTrackerEvent, RoutineTrackerState> {
  /// Creates new [RoutineTrackerBloc]
  new({required this._trackRoutineUseCase})
    : super(const RoutineTrackerState()) {
    on<RoutineTrackerTrackRequested>(
      _onRoutineTrackerTrackRequested,
      transformer: sequential(),
    );
  }

  final TrackRoutineUseCase _trackRoutineUseCase;

  Future<void> _onRoutineTrackerTrackRequested(
    RoutineTrackerTrackRequested event,
    Emitter<RoutineTrackerState> emit,
  ) async {
    emit(
      RoutineTrackerState(
        loadingIds: {...state.loadingIds, event.routine.id},
        notice: state.notice,
      ),
    );

    final result = await _trackRoutineUseCase(
      TrackRoutineParams(routineId: event.routine.id, date: event.date),
    );
    late final NoticeUI<Routine> notice;
    switch (result) {
      case AppResultSuccess<Tracker>():
        notice = CreatedNoticeUI(data: event.routine);
      case AppResultFailed<Tracker>(:final exception):
        notice = FailedNoticeUI(
          data: event.routine,
          operation: .create,
          exception: exception,
        );
    }
    emit(
      RoutineTrackerState(
        loadingIds: {...state.loadingIds}..remove(event.routine.id),
        notice: notice,
      ),
    );
  }
}
