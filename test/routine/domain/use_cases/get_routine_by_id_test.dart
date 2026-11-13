import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/routine/routine.dart';

import '../../../common/di_mock.dart';
import '../../../helper.dart';
import '../entities/routine_mocks.dart';

void main() {
  late RoutineRepository routineRepository;
  late GetRoutineByIdUseCase getRoutineByIdUseCase;

  setUpAll(initializeMockDependencies);

  setUp(() {
    routineRepository = di<RoutineRepository>();
    when(() => routineRepository.getById(any()))
        .thenAnswer((_) async => AppResult.success(mockRoutine));

    getRoutineByIdUseCase = GetRoutineByIdUseCase(
      routineRepository: routineRepository,
    );
  });

  tearDown(() {
    reset(routineRepository);
  });

  group('GetRoutineByIdUseCase', () {
    test(
      'calls RoutineRepository.getById once',
      () async {
        await getRoutineByIdUseCase(mockRoutine.id);

        verify(() => routineRepository.getById(mockRoutine.id)).called(1);
      },
    );

    test(
      'returns success with correct Routine '
      'when RoutineRepository.getById success',
      () async {
        final result = await getRoutineByIdUseCase(mockRoutine.id);

        expect(result, AppResult.success(mockRoutine));
      },
    );

    test(
      'returns success with correct Routine '
      'when RoutineRepository.getById success',
      () async {
        when(() => routineRepository.getById(mockRoutine.id))
            .thenAnswer((_) async => AppResult.failed(AppException.test()));
        final result = await getRoutineByIdUseCase(mockRoutine.id);

        result.expectFailedWith(AppException.test());
      },
    );
  });
}
