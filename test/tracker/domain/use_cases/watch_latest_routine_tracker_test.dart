import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/tracker/tracker.dart';

import '../../../common/di_mock.dart';
import '../entities/tracker_mock.dart';

void main() {
  late TrackerRepository trackerRepository;
  late WatchLatestRoutineTrackerUseCase watchLatestRoutineTrackerUseCase;

  setUpAll(initializeMockDependencies);

  setUp(() {
    trackerRepository = di<TrackerRepository>();
    when(
      () => trackerRepository.watchLatestPerRoutine(),
    ).thenAnswer((_) => Stream.value(AppResult.success([mockTracker])));

    watchLatestRoutineTrackerUseCase = WatchLatestRoutineTrackerUseCase(
      trackerRepository: trackerRepository,
    );
  });

  tearDown(() {
    reset(trackerRepository);
  });

  group('WatchLatestRoutineTrackerUseCase', () {
    test('calls TrackerRepository.watchLatestPerRoutine once', () async {
      final stream = watchLatestRoutineTrackerUseCase();
      await stream.first;

      verify(() => trackerRepository.watchLatestPerRoutine()).called(1);
    });

    test('emits stream of success '
        'when TrackerRepository.watchLatestPerRoutine emits success', () {
      final stream = watchLatestRoutineTrackerUseCase();

      expect(
        stream,
        emitsInOrder([
          AppResult.success([mockTracker]),
        ]),
      );
    });

    test('emits stream of failed '
        'when TrackerRepository.watchLatestPerRoutine emits failed', () {
      when(
        () => trackerRepository.watchLatestPerRoutine(),
      ).thenAnswer((_) => Stream.value(AppResult.failed(AppException.test())));
      final stream = watchLatestRoutineTrackerUseCase();

      expect(
        stream,
        emitsInOrder([
          AppResult<List<Tracker>>.failed(AppException.test()),
        ]),
      );
    });
  });
}
