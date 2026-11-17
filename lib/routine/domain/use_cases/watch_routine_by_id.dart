import 'package:injectable/injectable.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/app_result.dart';
import 'package:routrack/routine/domain/entities/entities.dart';
import 'package:routrack/routine/domain/repositories/repositories.dart';

/// Use case to watch single [Routine] based on its ID
@LazySingleton(env: [Environment.prod])
class WatchRoutineByIdUseCase
    with Loggable
    implements StreamUseCase<String, Routine> {
  /// Creates new [WatchRoutineByIdUseCase]
  const new({required this._routineRepository});

  final RoutineRepository _routineRepository;

  @override
  Stream<AppResult<Routine>> call(String params) {
    logInfo('delegating watching for Routine based on ID to RoutineRepository');
    return _routineRepository.watchById(params);
  }
}
