import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/tracker/data/mapper/mapper.dart';
import 'package:routrack/tracker/domain/domain.dart';
import 'package:rxdart/rxdart.dart';

/// Drift implementation of [TrackerRepository]
@LazySingleton(env: [Environment.prod], as: TrackerRepository)
final class DriftTrackerRepository with Loggable implements TrackerRepository {
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
      logInfo('starts creating new Tracker');
      final trackerDB = await query;
      logInfo('Tracker created');
      return AppResult.success(trackerDB.toDomain());
    } on SqliteException catch (e, stackTrace) {
      final code = e.resultCode;
      if (code == 19) {
        logInfo('Routine not found for requested Tracker');
        return AppResult.failed(
          NotFoundException(entity: .routine, id: params.routineId),
        );
      }
      logError('failed to create Tracker', error: e, stackTrace: stackTrace);
      return AppResult.failed(UnexpectedException(exception: e));
    } on Exception catch (e, stackTrace) {
      logError('failed to create Tracker', error: e, stackTrace: stackTrace);
      return AppResult.failed(UnexpectedException(exception: e));
    }
  }

  @override
  Stream<AppResult<List<Tracker>>> watchLatestPerRoutine() {
    final maxDate = _db.trackerTable.date.max();
    final newestTracker = Subquery(
      _db.selectOnly(_db.trackerTable)
        ..addColumns([
          _db.trackerTable.id,
          _db.trackerTable.routineId,
          maxDate,
        ])
        ..groupBy([_db.trackerTable.routineId]),
      'nt',
    );
    final query = _db.select(_db.trackerTable).join([
      innerJoin(
        newestTracker,
        newestTracker
                .ref(_db.trackerTable.routineId)
                .equalsExp(
                  _db.trackerTable.routineId,
                ) &
            newestTracker
                .ref(_db.trackerTable.id)
                .equalsExp(_db.trackerTable.id),
      ),
    ]);

    logInfo('start watching latest Tracker per Routine');
    return query
        .watch()
        .map((rows) {
          maybeThrowException(
            this,
            Invocation.method(#watchLatestPerRoutine, []),
          );
          final trackers = <Tracker>[];
          for (final row in rows) {
            trackers.add(
              row.readTable(_db.trackerTable).toDomain(),
            );
          }
          logInfo('new trackers received. Emits new trackers');
          return AppResult.success(trackers);
        })
        .onErrorReturnWith((exception, st) {
          logError(
            'failed received. Emits failed result',
            error: exception,
            stackTrace: st,
          );
          if (exception is Exception) {
            return AppResult.failed(UnexpectedException(exception: exception));
          }
          return AppResult.failed(
            UnexpectedException(exception: Exception('$exception')),
          );
        });
  }
}
