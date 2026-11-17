import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/routine/data/mapper/routine_mapper.dart';
import 'package:routrack/routine/domain/domain.dart';
import 'package:rxdart/rxdart.dart';

/// Drift implementation of [RoutineRepository]
@LazySingleton(env: [Environment.prod], as: RoutineRepository)
final class DriftRoutineRepository with Loggable implements RoutineRepository {
  /// Creates new [DriftRoutineRepository]
  const new({
    required this._db,
    required this._uidGenerator,
    required this._clock,
  });

  final AppDatabase _db;
  final UidGenerator _uidGenerator;
  final AppClock _clock;

  @override
  Future<AppResult<Routine>> save(CreateRoutineDBParams params) async {
    try {
      maybeThrowException(this, Invocation.method(#save, [params]));
      final now = _clock.getCurrentDateTime();
      logInfo('starts tracksaction to save new Routine');
      final (newRoutineDB, schedule) = await _db.transaction(() async {
        final newRoutineDB = await _db
            .into(_db.routineTable)
            .insertReturning(
              params.toRoutineDatabase(
                id: _uidGenerator.generateUid(),
                createdAt: now,
              ),
            );
        final schedule = await _db
            .into(_db.scheduleTable)
            .insertReturning(
              params.toScheduleDatabase(
                id: _uidGenerator.generateUid(),
                status: .active,
                routineId: newRoutineDB.id,
                createdAt: now,
              ),
            );
        return (newRoutineDB, schedule);
      });
      logInfo('new Routine saved');
      return AppResult.success(
        newRoutineDB.toDomain(
          activeSchedule: schedule.toDomain(),
        ),
      );
    } on Exception catch (e, stackTrace) {
      logError('failed to save routine', error: e, stackTrace: stackTrace);
      return AppResult.failed(UnexpectedException(exception: e));
    }
  }

  @override
  Stream<AppResult<List<Routine>>> watch() {
    final query = _db.select(_db.routineTable).join([
      leftOuterJoin(
        _db.scheduleTable,
        _db.scheduleTable.routineId.equalsExp(_db.routineTable.id),
      ),
    ])..where(_db.scheduleTable.status.equalsValue(ScheduleStatus.active));
    logInfo('starts watching for routines changes');
    return query
        .watch()
        .map((rows) {
          maybeThrowException(this, Invocation.method(#watch, []));
          final routines = <Routine>[];
          for (final row in rows) {
            final routineDB = row.readTable(_db.routineTable);
            final scheduleDB = row.readTable(_db.scheduleTable);
            routines.add(
              routineDB.toDomain(activeSchedule: scheduleDB.toDomain()),
            );
          }
          logInfo('emits new routines');
          return AppResult.success(routines);
        })
        .onErrorReturnWith((exception, st) {
          logError(
            'failed to watch for routines changes',
            error: exception,
            stackTrace: st,
          );
          if (exception is Exception) {
            return AppResult.failed(
              UnexpectedException(exception: exception),
            );
          }
          return AppResult.failed(
            UnexpectedException(exception: Exception('$exception')),
          );
        });
  }

  @override
  Future<AppResult<Routine>> getById(String id) async {
    try {
      maybeThrowException(this, Invocation.method(#getById, [id]));
      final query = _db.select(_db.routineTable).join([
        leftOuterJoin(
          _db.scheduleTable,
          _db.routineTable.id.equalsExp(_db.scheduleTable.routineId),
        ),
      ])..where(_db.routineTable.id.equals(id));
      logInfo('starts get routine by its id');
      final result = await query.getSingleOrNull();
      if (result == null) {
        logInfo('routine not found');
        return AppResult.failed(NotFoundException(entity: .routine, id: id));
      }
      final routineDB = result.readTable(_db.routineTable);
      final scheduleDB = result.readTable(_db.scheduleTable);
      logInfo('routine found');
      return AppResult.success(
        routineDB.toDomain(
          activeSchedule: scheduleDB.toDomain(),
        ),
      );
    } on Exception catch (e, stackTrace) {
      logError('failed to get routine', error: e, stackTrace: stackTrace);
      return AppResult.failed(UnexpectedException(exception: e));
    }
  }

  @override
  Stream<AppResult<Routine>> watchById(String id) {
    final query =
        _db.select(_db.routineTable).join([
          leftOuterJoin(
            _db.scheduleTable,
            _db.routineTable.id.equalsExp(_db.scheduleTable.routineId),
          ),
        ])..where(
          _db.routineTable.id.equals(id) &
              _db.scheduleTable.status.equalsValue(.active),
        );
    logInfo('starts watching for single routine changes');
    return query
        .watchSingleOrNull()
        .map((result) {
          maybeThrowException(this, Invocation.method(#watchById, [id]));
          if (result == null) {
            logInfo('routine not found');
            return AppResult<Routine>.failed(
              NotFoundException(entity: .routine, id: id),
            );
          }
          final routineDB = result.readTable(_db.routineTable);
          final scheduleDB = result.readTable(_db.scheduleTable);
          logInfo('emit new routine');
          return AppResult.success(
            routineDB.toDomain(activeSchedule: scheduleDB.toDomain()),
          );
        })
        .onErrorReturnWith((
          error,
          stackTrace,
        ) {
          logError(
            'failed to watch single routine by id',
            error: error,
            stackTrace: stackTrace,
          );
          if (error is Exception) {
            return AppResult<Routine>.failed(
              UnexpectedException(exception: error),
            );
          }
          return AppResult<Routine>.failed(
            UnexpectedException(exception: Exception('$error')),
          );
        });
  }
}
