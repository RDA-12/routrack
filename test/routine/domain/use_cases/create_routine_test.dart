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
    days: {.mon, .tue},
  );
  final dbParams = CreateRoutineDBParams(
    name: params.name,
    recurrence: const ['RRULE:FREQ=DAILY;BYDAY=MO,TU'],
  );
  late RoutineRepository mockRoutineRepository;
  late CreateRoutineUseCase createRoutineUseCase;

  setUpAll(() {
    registerFallbackValue(params);
    registerFallbackValue(dbParams);
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
      await createRoutineUseCase(params);

      verify(() => mockRoutineRepository.save(dbParams)).called(1);
    });

    test('returns success with correct data '
        'when RoutineRepository.save success', () async {
      final result = await createRoutineUseCase(params);

      expect(result, AppResult.success(mockRoutine));
    });

    test('returns failed with correct exception '
        'when RoutineRepository.save failed', () async {
      when(() => mockRoutineRepository.save(dbParams))
          .thenAnswer((_) async => AppResult.failed(AppException.test()));

      final result = await createRoutineUseCase(params);

      result.expectFailedWith(AppException.test());
    });
  });
}
