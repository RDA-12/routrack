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
                routineId: newRoutineDB.id,
                createdAt: now,
              ),
            );
        return (newRoutineDB, schedule);
      });
      return AppResult.success(
        newRoutineDB.toDomain(),
      );
    } on Exception catch (e) {
      return AppResult.failed(UnexpectedException(exception: e));
    }
  }

  @override
  Stream<AppResult<List<Routine>>> watch() {
    final routineQuery = _db.select(_db.routineTable);
    return routineQuery
        .watch()
        .map((rows) {
          maybeThrowException(this, Invocation.method(#watch, []));
          final routines = <Routine>[];
          for (final row in rows) {
            routines.add(row.toDomain());
          }
          return AppResult.success(routines);
        })
        .onErrorReturnWith((exception, st) {
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
}
