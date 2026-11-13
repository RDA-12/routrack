import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/routine/routine.dart';
import 'package:routrack/tracker/tracker.dart';

import '../../../common/di_mock.dart';
import '../../../helper.dart';
import '../../../routine/domain/entities/routine_mocks.dart';
import '../entities/tracker_mock.dart';

void main() {
  final params = TrackRoutineParams(
    routineId: mockRoutine.id,
    date: DateTime.now(),
  );
  late TrackerRepository trackerRepository;
  late GetRoutineByIdUseCase getRoutineByIdUseCase;
  late TrackRoutineUseCase trackRoutineUseCase;

  setUpAll(() {
    registerFallbackValue(params);
    initializeMockDependencies();
  });

  setUp(() {
    trackerRepository = di<TrackerRepository>();
    when(() => trackerRepository.save(any()))
        .thenAnswer((_) async => AppResult.success(mockTracker));

    getRoutineByIdUseCase = di<GetRoutineByIdUseCase>();
    when(() => getRoutineByIdUseCase(any()))
        .thenAnswer((_) async => AppResult.success(mockRoutine));

    trackRoutineUseCase = TrackRoutineUseCase(
      trackerRepository: trackerRepository,
      getRoutineByIdUseCase: getRoutineByIdUseCase,
    );
  });

  tearDown(() {
    reset(trackerRepository);
    reset(getRoutineByIdUseCase);
  });

  group('TrackRoutineUseCase', () {
    test('calls GetRoutineByIdUseCase once', () async {
      await trackRoutineUseCase(params);

      verify(() => getRoutineByIdUseCase(params.routineId)).called(1);
    });

    test('calls TrackerRepository.save once', () async {
      await trackRoutineUseCase(params);

      verify(() => trackerRepository.save(params)).called(1);
    });

    test('returns success with correct Tracker when all ops success', () async {
      final result = await trackRoutineUseCase(params);

      expect(result, AppResult.success(mockTracker));
    });

    test('returns failed with correct exception '
        'when GetRoutineByIdUseCase failed', () async {
      when(() => getRoutineByIdUseCase(any()))
          .thenAnswer((_) async => AppResult.failed(AppException.test()));
      final result = await trackRoutineUseCase(params);

      result.expectFailedWith(AppException.test());
      verifyZeroInteractions(trackerRepository);
    });

    test('returns failed with correct exception '
        'when TrackerRepository.save failed', () async {
      when(() => trackerRepository.save(any()))
          .thenAnswer((_) async => AppResult.failed(AppException.test()));
      final result = await trackRoutineUseCase(params);

      result.expectFailedWith(AppException.test());
    });
  });
}
