import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/schedule/schedule.dart';

import '../../../common/di_mock.dart';
import '../../../helper.dart';
import '../entities/schedule_mock.dart';

void main() {
  final params = CreateScheduleParams(
    routineId: mockSchedule.routineId,
    days: const {.mon, .thu},
  );
  final dbParams = CreateScheduleDBParams(
    routineId: params.routineId,
    recurrence: const [
      'RRULE:FREQ=DAILY;BYDAY=MO,TH',
    ],
  );
  late ScheduleRepository scheduleRepository;
  late CreateScheduleUseCase createScheduleUseCase;

  setUpAll(() {
    registerFallbackValue(params);
    registerFallbackValue(dbParams);
    initializeMockDependencies();
  });

  setUp(() {
    scheduleRepository = di<ScheduleRepository>();
    when(() => scheduleRepository.save(any()))
        .thenAnswer((_) async => AppResult.success(mockSchedule));

    createScheduleUseCase = CreateScheduleUseCase(
      scheduleRepository: scheduleRepository,
    );
  });

  tearDown(() {
    reset(scheduleRepository);
  });

  group('CreateScheduleUseCase', () {
    test('calls ScheduleRepository.save once with correct params', () async {
      await createScheduleUseCase(params);

      verify(() => scheduleRepository.save(dbParams)).called(1);
    });

    test('returns success with correct Schedule '
        'when ScheduleRepository.save success', () async {
      final result = await createScheduleUseCase(params);

      expect(result, AppResult.success(mockSchedule));
    });

    test('returns failed with correct AppException '
        'when ScheduleRepository.save failed', () async {
      when(() => scheduleRepository.save(dbParams))
          .thenAnswer((_) async => AppResult.failed(AppException.test()));

      final result = await createScheduleUseCase(params);

      result.expectFailedWith(AppException.test());
    });
  });
}
