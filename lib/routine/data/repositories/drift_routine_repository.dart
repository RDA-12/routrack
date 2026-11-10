import 'package:injectable/injectable.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/routine/data/mapper/routine_mapper.dart';
import 'package:routrack/routine/domain/domain.dart';

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
      final newRoutineDB = await _db.transaction(() async {
        final newRoutineDB = await _db
            .into(_db.routineTable)
            .insertReturning(
              params.toRoutineDatabase(
                id: _uidGenerator.generateUid(),
                createdAt: now,
              ),
            );
        await _db
            .into(_db.scheduleTable)
            .insert(
              params.toScheduleDatabase(
                id: _uidGenerator.generateUid(),
                routineId: newRoutineDB.id,
                createdAt: now,
              ),
            );
        return newRoutineDB;
      });
      return AppResult.success(newRoutineDB.toDomain());
    } on Exception catch (e) {
      return AppResult.failed(UnexpectedException(exception: e));
    }
  }
}
