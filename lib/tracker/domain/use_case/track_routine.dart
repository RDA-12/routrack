import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/app_result.dart';
import 'package:routrack/routine/routine.dart';
import 'package:routrack/tracker/domain/entities/entities.dart';
import 'package:routrack/tracker/domain/repositories/repositories.dart';

/// Params for [TrackRoutineUseCase]
final class TrackRoutineParams extends Equatable {
  /// Creates new [TrackRoutineParams]
  const new({required this.routineId, required this.date});

  /// ID of routine for this tracker
  final String routineId;

  /// When the routine is done
  final DateTime date;

  @override
  List<Object?> get props => [routineId, date];
}

/// Use case to track a routine
@LazySingleton(env: [Environment.prod])
class TrackRoutineUseCase
    implements FutureUseCase<TrackRoutineParams, Tracker> {
  /// Creates new [TrackRoutineUseCase]
  const new({
    required this._trackerRepository,
    required this._getRoutineByIdUseCase,
  });

  final TrackerRepository _trackerRepository;
  final GetRoutineByIdUseCase _getRoutineByIdUseCase;

  /// Starts creating new tracker
  @override
  Future<AppResult<Tracker>> call(TrackRoutineParams params) async {
    final routineResult = await _getRoutineByIdUseCase(params.routineId);
    if (routineResult is AppResultFailed<Routine>) {
      return AppResult.failed(routineResult.exception);
    }
    return await _trackerRepository.save(params);
  }
}
