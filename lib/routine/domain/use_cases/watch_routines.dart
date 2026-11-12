import 'package:injectable/injectable.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/app_result.dart';
import 'package:routrack/routine/domain/domain.dart';

/// Use case to watch for list of [Routine] changes
@LazySingleton(env: [Environment.prod])
class WatchRoutines implements StreamUseCase<List<Routine>> {
  /// Creates new [WatchRoutines]
  const new({required this._routineRepository});

  final RoutineRepository _routineRepository;

  @override
  Stream<AppResult<List<Routine>>> call() {
    return _routineRepository.watch();
  }
}
