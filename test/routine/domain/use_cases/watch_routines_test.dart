import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/routine/routine.dart';

import '../../../common/di_mock.dart';
import '../entities/routine_mocks.dart';

void main() {
  late RoutineRepository routineRepository;
  late WatchRoutines watchRoutines;

  setUpAll(initializeMockDependencies);

  setUp(() {
    routineRepository = di<RoutineRepository>();
    when(
      () => routineRepository.watch(),
    ).thenAnswer((_) => Stream.value(AppResult.success([mockRoutine])));

    watchRoutines = WatchRoutines(routineRepository: routineRepository);
  });

  tearDown(() {
    reset(routineRepository);
  });

  group('WatchRoutines', () {
    test('calls RoutineRepository.watch once', () async {
      final stream = watchRoutines();
      await stream.first;

      verify(() => routineRepository.watch()).called(1);
    });

    test('emits stream of success '
        'when RoutineRepository.watch emits success', () {
      final stream = watchRoutines();

      expect(
        stream,
        emitsInOrder([
          AppResult.success([mockRoutine]),
        ]),
      );
    });

    test('emits stream of failed '
        'when RoutineRepository.watch emits failed', () {
      when(
        () => routineRepository.watch(),
      ).thenAnswer((_) => Stream.value(AppResult.failed(AppException.test())));
      final stream = watchRoutines();

      expect(
        stream,
        emitsInOrder([
          AppResult<List<Routine>>.failed(AppException.test()),
        ]),
      );
    });

    test('emits stream of success filtered by date', () {
      final schedule = RoutineSchedule(
        id: 'id',
        routineId: 'routineId',
        recurrence: const ['RRULE:FREQ=DAILY;BYDAY=FR'],
        status: .active,
      );
      final expected = Routine(
        id: 'id',
        name: 'name',
        activeSchedule: schedule,
      );
      when(() => routineRepository.watch()).thenAnswer(
        (_) => Stream.value(AppResult.success([expected, ...mockRoutines])),
      );

      final date = DateTime(2026, 11, 13);

      final stream = watchRoutines(WatchRoutinesParams(date: date));

      expect(
        stream,
        emitsInOrder([
          AppResult.success([expected]),
        ]),
      );
    });
  });
}
