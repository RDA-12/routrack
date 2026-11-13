import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/routine/data/mapper/routine_mapper.dart';
import 'package:routrack/routine/domain/domain.dart';
import 'package:rxdart/rxdart.dart';

/// Drift implementation of [RoutineRepository]
@LazySingleton(env: [Environment.prod], as: RoutineRepository)
final class DriftRoutineRepository implements RoutineRepository {
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
      return AppResult.success(
        newRoutineDB.toDomain(
          activeSchedule: schedule.toDomain(),
        ),
      );
    } on Exception catch (e) {
      return AppResult.failed(UnexpectedException(exception: e));
    }
  }

  @override
  Stream<AppResult<List<Routine>>> watch() {
    final routineQuery = _db.select(_db.routineTable);
    final routineStream = routineQuery.watch();
    final scheduleQuery = _db.select(_db.scheduleTable)
      ..where((tbl) => tbl.status.equals(ScheduleStatus.active.name));
    final scheduleStream = scheduleQuery.watch();
    return CombineLatestStream.combine2(
      routineStream,
      scheduleStream,
      (routines, schedules) {
        maybeThrowException(this, Invocation.method(#watch, []));
        final effectiveRoutines = <Routine>[];
        for (final routine in routines) {
          final schedule = schedules.firstWhereOrNull(
            (it) => it.routineId == routine.id,
          );
          if (schedule == null) continue;
          effectiveRoutines.add(
            routine.toDomain(activeSchedule: schedule.toDomain()),
          );
        }
        return AppResult.success(effectiveRoutines);
      },
    ).onErrorReturnWith((exception, st) {
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
    // TODO(RDA12): implement getById
    throw UnimplementedError();
  }
}
