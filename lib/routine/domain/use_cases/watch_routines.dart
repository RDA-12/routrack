import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/app_result.dart';
import 'package:routrack/routine/domain/domain.dart';

/// Params for [WatchRoutines]
final class WatchRoutinesParams extends Equatable {
  /// Creates new [WatchRoutinesParams]
  const new({this.date});

  /// Filter routines which need to be done on this [date]
  final DateTime? date;

  @override
  List<Object?> get props => [date];
}

/// Use case to watch for list of [Routine] changes
@LazySingleton(env: [Environment.prod])
class WatchRoutines
    implements StreamUseCase<WatchRoutinesParams, List<Routine>> {
  /// Creates new [WatchRoutines]
  const new({required this._routineRepository});

  final RoutineRepository _routineRepository;

  @override
  Stream<AppResult<List<Routine>>> call([WatchRoutinesParams? params]) {
    return _routineRepository.watch().map((result) {
      switch (result) {
        case AppResultFailed<List<Routine>>():
          return result;
        case AppResultSuccess<List<Routine>>(:final data):
          if (params?.date == null) return result;
          final routines = <Routine>[];
          for (final routine in data) {
            if (!routine.includes(params!.date!)) continue;
            routines.add(routine);
          }
          return AppResult.success(routines);
      }
    });
  }
}
