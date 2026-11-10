import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/schedule/data/mapper/mapper.dart';
import 'package:routrack/schedule/domain/domain.dart';

/// Drift implementation of [ScheduleRepository]
@LazySingleton(env: [Environment.prod], as: ScheduleRepository)
final class DriftScheduleRepository implements ScheduleRepository {
  /// Creates new [DriftScheduleRepository]
  const new({
    required this._db,
    required this._uidGenerator,
    required this._clock,
  });

  final AppDatabase _db;
  final UidGenerator _uidGenerator;
  final AppClock _clock;

  @override
  Future<AppResult<Schedule>> save(CreateScheduleDBParams params) async {
    try {
      maybeThrowException(this, Invocation.method(#save, [params]));
      final newScheduleDB = await _db
          .into(_db.scheduleTable)
          .insertReturning(
            params.toDatabase(
              id: _uidGenerator.generateUid(),
              createdAt: _clock.getCurrentDateTime(),
            ),
          );
      return AppResult.success(newScheduleDB.toDomain());
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
