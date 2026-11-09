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
  Future<AppResult<Routine>> save(CreateRoutineParams params) async {
    try {
      maybeThrowException(this, Invocation.method(#save, [params]));
      final newRoutineDB = await _db
          .into(_db.routineTable)
          .insertReturning(
            params.toDatabase(
              id: _uidGenerator.generateUid(),
              createdAt: _clock.getCurrentDateTime(),
            ),
          );
      return AppResult.success(newRoutineDB.toDomain());
    } on Exception catch (e) {
      return AppResult.failed(UnexpectedException(exception: e));
    }
  }
}
