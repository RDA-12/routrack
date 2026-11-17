import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/routine/routine.dart';

import '../../../common/di_mock.dart';
import '../entities/routine_mocks.dart';

void main() {
  const id = 'id';
  late RoutineRepository routineRepository;
  late WatchRoutineByIdUseCase watchRoutineByIdUseCase;

  setUpAll(initializeMockDependencies);

  setUp(() {
    routineRepository = di<RoutineRepository>();
    when(
      () => routineRepository.watchById(id),
    ).thenAnswer((_) => Stream.value(AppResult.success(mockRoutine)));

    watchRoutineByIdUseCase = WatchRoutineByIdUseCase(
      routineRepository: routineRepository,
    );
  });

  tearDown(() {
    reset(routineRepository);
  });

  group('WatchRoutineByIdUseCase', () {
    test('calls RoutineRepository.watchById once', () async {
      final stream = watchRoutineByIdUseCase(id);
      await stream.first;

      verify(() => routineRepository.watchById(id)).called(1);
    });

    test('emits stream of success '
        'when RoutineRepository.watchById emits success', () {
      final stream = watchRoutineByIdUseCase(id);

      expect(
        stream,
        emitsInOrder([
          AppResult.success(mockRoutine),
        ]),
      );
    });

    test('emits stream of failed '
        'when RoutineRepository.watchById emits failed', () {
      when(
        () => routineRepository.watchById(id),
      ).thenAnswer((_) => Stream.value(AppResult.failed(AppException.test())));
      final stream = watchRoutineByIdUseCase(id);

      expect(
        stream,
        emitsInOrder([
          AppResult<Routine>.failed(AppException.test()),
        ]),
      );
    });
  });
}
