import 'package:flutter_test/flutter_test.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/tracker/data/repositories/drift_tracker_repository.dart';
import 'package:routrack/tracker/tracker.dart';

import '../../../common/di_mock.dart';
import '../../../helper.dart';
import '../../../routine/domain/entities/routine_mocks.dart';

void main() {
  const uid = 'uid';
  final now = DateTime.timestamp();
  final params = TrackRoutineParams(
    routineId: mockRoutine.id,
    date: now,
  );
  late AppDatabase database;
  late UidGenerator uidGenerator;
  late AppClock clock;
  late TrackerRepository repository;

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
    when(uidGenerator.generateUid).thenReturn(uid);

    clock = di<AppClock>();
    when(clock.getCurrentDateTime).thenReturn(now);

    repository = DriftTrackerRepository(
      db: database,
      uidGenerator: uidGenerator,
      clock: clock,
    );
  });

  tearDown(() async {
    await database.delete(database.routineTable).go();
    await database.delete(database.trackerTable).go();
    reset(uidGenerator);
    reset(clock);
  });

  group('DriftTrackerRepository', () {
    group('Save', () {
      test('returns success and saves correct tracker when success', () async {
        final result = await repository.save(params);

        expect(result, isA<AppResultSuccess<Tracker>>());

        final data = (result as AppResultSuccess<Tracker>).data;
        expect(
          data,
          Tracker(
            id: uid,
            routineId: mockRoutine.id,
            date: now,
          ),
        );

        final query = database.select(database.trackerTable)
          ..where((tbl) => tbl.id.equals(data.id));
        final row = await query.getSingleOrNull();

        expect(row, isNotNull);
        expect(row!.routineId, params.routineId);
        expect(row.date, params.date);
        expect(row.createdAt, now);
        expect(row.updatedAt, now);
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

    group('WatchLatestPerRoutine', () {
      final expectedDate = DateTime(2026, 11, 10);

      setUp(() async {
        for (var i = 0; i < 5; i++) {
          await database
              .into(database.trackerTable)
              .insert(
                TrackerTableCompanion.insert(
                  id: '$i',
                  createdAt: expectedDate,
                  updatedAt: expectedDate,
                  routineId: mockRoutine.id,
                  date: expectedDate.add(Duration(days: -i)),
                ),
              );
        }
      });

      test('returns success with correct trackers', () async {
        final stream = repository.watchLatestPerRoutine();

        expect(
          stream,
          emitsInOrder([
            AppResult.success([
              Tracker(id: '0', routineId: mockRoutine.id, date: expectedDate),
            ]),
          ]),
        );
      });

      test('returns failed with correct exception '
          'when unexpected exception occurred', () async {
        final e = Exception();
        whenCalling(Invocation.method(#watchLatestPerRoutine, []))
            .on(repository)
            .thenThrow(e);
        final stream = repository.watchLatestPerRoutine();

        expect(
          stream,
          emitsInOrder([
            AppResult<List<Tracker>>.failed(UnexpectedException(exception: e)),
          ]),
        );
      });
    });
  });
}
