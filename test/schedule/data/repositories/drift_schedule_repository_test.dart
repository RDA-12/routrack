import 'package:flutter_test/flutter_test.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/schedule/schedule.dart';

import '../../../common/di_mock.dart';
import '../../../helper.dart';
import '../../../routine/domain/entities/routine_mocks.dart';
import '../../domain/entities/schedule_mock.dart';

void main() {
  final now = DateTime.now().toUtc();
  final params = CreateScheduleDBParams(
    routineId: mockSchedule.routineId,
    recurrence: mockSchedule.recurrence,
  );
  late AppDatabase database;
  late UidGenerator uidGenerator;
  late AppClock appClock;
  late ScheduleRepository repository;

  setUpAll(initializeMockDependencies);

  setUp(() async {
    database = di<AppDatabase>();
    await database
        .into(database.routineTable)
        .insert(
          RoutineTableCompanion.insert(
            id: mockRoutine.id,
            name: mockRoutine.name,
            createdAt: now,
            updatedAt: now,
          ),
        );
    uidGenerator = di<UidGenerator>();
    when(() => uidGenerator.generateUid()).thenReturn(mockSchedule.id);
    appClock = di<AppClock>();
    when(() => appClock.getCurrentDateTime()).thenReturn(now);

    repository = DriftScheduleRepository(
      db: database,
      uidGenerator: uidGenerator,
      clock: appClock,
    );
  });

  tearDown(() async {
    await database.delete(database.routineTable).go();
    await database.delete(database.scheduleTable).go();
    reset(uidGenerator);
    reset(appClock);
  });

  group('DriftScheduleDatabase', () {
    group('Save', () {
      test('returns success and saves correct schedule when success', () async {
        final result = await repository.save(params);

        expect(result, isA<AppResultSuccess<Schedule>>());

        final data = (result as AppResultSuccess<Schedule>).data;
        expect(data, mockSchedule);

        final query = database.select(database.scheduleTable)
          ..where((tbl) => tbl.id.equals(data.id));
        final row = await query.getSingleOrNull();

        expect(row, isNotNull);
        expect(row!.routineId, params.routineId);
        expect(row.recurrence, params.recurrence);
        expect(row.createdAt, now);
        expect(row.updatedAt, now);
      });

      test('returns failed with NotFoundException '
          'when routine is not found', () async {
        const invalidParams = CreateScheduleDBParams(
          routineId: 'not-found',
          recurrence: [],
        );
        final result = await repository.save(invalidParams);

        result.expectFailedWith(
          NotFoundException(entity: .routine, id: 'not-found'),
        );
      });

      test('returns failed with correct exception '
          'when unexpected Exception occurred', () async {
        final exception = Exception();
        whenCalling(Invocation.method(#save, [params]))
            .on(repository)
            .thenThrow(exception);
        final result = await repository.save(params);

        result.expectFailedWith(UnexpectedException(exception: exception));
      });
    });
  });
}
