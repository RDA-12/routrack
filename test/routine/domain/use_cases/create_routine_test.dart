import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/routine/routine.dart';

import '../../../common/di_mock.dart';
import '../../../helper.dart';
import '../entities/routine_mocks.dart';

void main() {
  const params = CreateRoutineParams(
    name: 'name',
  );
  late RoutineRepository mockRoutineRepository;
  late CreateRoutineUseCase createRoutineUseCase;

  setUpAll(() {
    registerFallbackValue(params);
    initializeMockDependencies();
  });

  setUp(() {
    mockRoutineRepository = di<RoutineRepository>();
    when(() => mockRoutineRepository.save(any()))
        .thenAnswer((_) async => AppResult.success(mockRoutine));

    createRoutineUseCase = CreateRoutineUseCase(
      routineRepository: mockRoutineRepository,
    );
  });

  tearDown(() {
    reset(mockRoutineRepository);
  });

  group('CreateRoutineUseCase', () {
    test('calls RoutineRepository.save once with correct params', () async {
      await mockRoutineRepository.save(params);

      verify(() => mockRoutineRepository.save(params)).called(1);
    });

    test('returns success with correct data '
        'when RoutineRepository.save success', () async {
      final result = await createRoutineUseCase(params);

      expect(result, AppResult.success(mockRoutine));
    });

    test('returns failed with correct exception '
        'when RoutineRepository.save failed', () async {
      when(() => mockRoutineRepository.save(params))
          .thenAnswer((_) async => AppResult.failed(AppException.test()));

      final result = await createRoutineUseCase(params);

      result.expectHas(AppException.test());
    });
  });
}
