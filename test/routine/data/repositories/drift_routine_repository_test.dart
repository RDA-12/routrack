import 'package:flutter_test/flutter_test.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/routine/routine.dart';

import '../../../common/di_mock.dart';
import '../../../helper.dart';
import '../../domain/entities/routine_mocks.dart';

void main() {
  const uid = 'uid';
  final now = DateTime.now().toUtc();
  final params = CreateRoutineDBParams(
    name: mockRoutine.name,
    recurrence: const ['RRULE:FREQ=DAILY;BYDAY=MO,TU'],
  );
  late AppDatabase database;
  late UidGenerator uidGenerator;
  late AppClock appClock;
  late RoutineRepository repository;

  setUpAll(initializeMockDependencies);

  setUp(() {
    database = di<AppDatabase>();
    uidGenerator = di<UidGenerator>();
    when(() => uidGenerator.generateUid()).thenReturn(uid);
    appClock = di<AppClock>();
    when(() => appClock.getCurrentDateTime()).thenReturn(now);

    repository = DriftRoutineRepository(
      db: database,
      uidGenerator: uidGenerator,
      clock: appClock,
    );
  });

  tearDown(() async {
    await database.delete(database.routineTable).go();
    reset(uidGenerator);
    reset(appClock);
  });

  group('DriftRoutineDatabase', () {
    group('Save', () {
      test('returns success and saves correct routine '
          'and schedule when success', () async {
        final result = await repository.save(params);

        expect(result, isA<AppResultSuccess<Routine>>());

        final data = (result as AppResultSuccess<Routine>).data;
        expect(
          data,
          Routine(
            id: uid,
            name: params.name,
            activeSchedule: const RoutineSchedule(
              id: uid,
              routineId: uid,
              recurrence: ['RRULE:FREQ=DAILY;BYDAY=MO,TU'],
              status: .active,
            ),
          ),
        );

        final query = database.select(database.routineTable)
          ..where((tbl) => tbl.id.equals(data.id));
        final row = await query.getSingleOrNull();

        expect(row, isNotNull);
        expect(row!.name, params.name);
        expect(row.createdAt, now);
        expect(row.updatedAt, now);

        final scheduleQuery = database.select(database.scheduleTable)
          ..where((tbl) => tbl.routineId.equals(data.id));
        final scheduleRow = await scheduleQuery.getSingleOrNull();

        expect(scheduleRow, isNotNull);
        expect(scheduleRow!.routineId, row.id);
        expect(scheduleRow.recurrence, params.recurrence);
        expect(scheduleRow.status, ScheduleStatus.active);
        expect(scheduleRow.createdAt, now);
        expect(scheduleRow.updatedAt, now);
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

    group('watch', () {
      test('emits correct routines when stream emits normally', () async {
        await repository.save(params);

        final stream = repository.watch();

        expect(
          stream,
          emitsInOrder([
            AppResult.success([
              Routine(
                id: uid,
                name: params.name,
                activeSchedule: const RoutineSchedule(
                  id: uid,
                  routineId: uid,
                  recurrence: ['RRULE:FREQ=DAILY;BYDAY=MO,TU'],
                  status: .active,
                ),
              ),
            ]),
          ]),
        );
      });

      test(
        'emits correct failed when stream emits unexpected exception',
        () async {
          final exception = Exception();
          whenCalling(Invocation.method(#watch, []))
              .on(repository)
              .thenThrow(exception);

          final stream = repository.watch();

          expect(
            stream,
            emitsInOrder([
              AppResult<List<Routine>>.failed(
                UnexpectedException(exception: exception),
              ),
            ]),
          );
        },
      );
    });
  });
}
