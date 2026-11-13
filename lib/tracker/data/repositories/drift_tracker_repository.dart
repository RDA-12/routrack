import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/tracker/data/mapper/mapper.dart';
import 'package:routrack/tracker/domain/domain.dart';

/// Drift implementation of [TrackerRepository]
@LazySingleton(env: [Environment.prod], as: TrackerRepository)
final class DriftTrackerRepository implements TrackerRepository {
  /// Creates new [DriftTrackerRepository]
  const new({
    required this._db,
    required this._uidGenerator,
    required this._clock,
  });

  final AppDatabase _db;
  final UidGenerator _uidGenerator;
  final AppClock _clock;

  @override
  Future<AppResult<Tracker>> save(TrackRoutineParams params) async {
    try {
      maybeThrowException(this, Invocation.method(#save, [params]));
      final query = _db
          .into(_db.trackerTable)
          .insertReturning(
            params.toTrackerDatabase(
              id: _uidGenerator.generateUid(),
              createdAt: _clock.getCurrentDateTime(),
            ),
          );
      final trackerDB = await query;
      return AppResult.success(trackerDB.toDomain());
    } on SqliteException catch (e) {
      final code = e.resultCode;
      if (code == 19) {
        return AppResult.failed(
          NotFoundException(entity: .routine, id: params.routineId),
        );
      }
      return AppResult.failed(UnexpectedException(exception: e));
    } on Exception catch (e) {
      return AppResult.failed(UnexpectedException(exception: e));
    }
  }
}
