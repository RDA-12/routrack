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
  final now = DateTime.now().toUtc();
  final params = CreateRoutineParams(name: mockRoutine.name);
  late AppDatabase database;
  late UidGenerator uidGenerator;
  late AppClock appClock;
  late RoutineRepository repository;

  setUpAll(initializeMockDependencies);

  setUp(() {
    database = di<AppDatabase>();
    uidGenerator = di<UidGenerator>();
    when(() => uidGenerator.generateUid()).thenReturn(mockRoutine.id);
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
      test('returns success and saves correct routine when success', () async {
        final result = await repository.save(params);

        expect(result, isA<AppResultSuccess<Routine>>());

        final data = (result as AppResultSuccess<Routine>).data;
        expect(data, mockRoutine);

        final query = database.select(database.routineTable)
          ..where((tbl) => tbl.id.equals(data.id));
        final row = await query.getSingleOrNull();

        expect(row, isNotNull);
        expect(row!.name, params.name);
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

        result.expectHas(UnexpectedException(exception: exception));
      });
    });
  });
}
