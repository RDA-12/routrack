import 'package:injectable/injectable.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/app_result.dart';
import 'package:routrack/routine/domain/entities/entities.dart';
import 'package:routrack/routine/domain/repositories/repositories.dart';

/// Use case to get single [Routine] data by its id
@LazySingleton(env: [Environment.prod])
class GetRoutineByIdUseCase
    with Loggable
    implements FutureUseCase<String, Routine> {
  /// Creates new [GetRoutineByIdUseCase]
  const new({required this._routineRepository});

  final RoutineRepository _routineRepository;

  /// Starts getting the [Routine]
  @override
  Future<AppResult<Routine>> call(String params) {
    logInfo('delegate getting routine by its id to RoutineRepository');
    return _routineRepository.getById(params);
  }
}
