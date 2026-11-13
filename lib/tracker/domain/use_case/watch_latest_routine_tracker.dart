import 'package:injectable/injectable.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/app_result.dart';
import 'package:routrack/tracker/domain/entities/entities.dart';
import 'package:routrack/tracker/domain/repositories/repositories.dart';

/// Use case to watch for latest each routine trackers
@LazySingleton(env: [Environment.prod])
class WatchLatestRoutineTrackerUseCase
    implements NoParamsStreamUseCase<List<Tracker>> {
  /// Creates new [WatchLatestRoutineTrackerUseCase]
  const new({required this._trackerRepository});

  final TrackerRepository _trackerRepository;

  @override
  Stream<AppResult<List<Tracker>>> call() {
    return _trackerRepository.watchLatestPerRoutine();
  }
}
