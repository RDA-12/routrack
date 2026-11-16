import 'package:bloc_test/bloc_test.dart';
import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/home/presentation/bloc/home_bloc.dart';
import 'package:routrack/routine/routine.dart';
import 'package:routrack/tracker/tracker.dart';

import '../../../common/di_mock.dart';
import '../../../routine/domain/entities/routine_mocks.dart';
import '../../../tracker/domain/entities/tracker_mock.dart';

void main() {
  final now = DateTime.timestamp();
  final watchRoutinesParams = WatchRoutinesParams(date: now);
  late WatchRoutines watchRoutines;
  late WatchLatestRoutineTrackerUseCase watchLatestRoutineTrackerUseCase;
  late AppClock clock;

  setUpAll(() {
    registerFallbackValue(const WatchRoutinesParams());
    initializeMockDependencies();
  });

  setUp(() {
    watchRoutines = di<WatchRoutines>();
    when(() => watchRoutines(any())).thenAnswer(
      (_) => Stream.value(AppResult.success(mockRoutines)),
    );

    watchLatestRoutineTrackerUseCase = di<WatchLatestRoutineTrackerUseCase>();
    when(() => watchLatestRoutineTrackerUseCase())
        .thenAnswer((_) => Stream.value(AppResult.success(mockTrackers)));

    clock = di<AppClock>();
    when(clock.getCurrentDateTime).thenReturn(now);
  });

  tearDown(() {
    reset(watchRoutines);
    reset(watchLatestRoutineTrackerUseCase);
    reset(clock);
  });

  HomeBloc buildBloc() {
    return HomeBloc(
      watchRoutines: watchRoutines,
      watchLatestRoutineTrackerUseCase: watchLatestRoutineTrackerUseCase,
      clock: clock,
    );
  }

  group('HomeBloc', () {
    test('correct state initially', () {
      final bloc = buildBloc();

      expect(bloc.state, const HomeInitial());
    });

    group('HomeSubscriptionRequested', () {
      blocTest<HomeBloc, HomeState>(
        'calls WatchRoutines & WatchLatestRoutineTrackerUseCase once',
        build: buildBloc,
        act: (bloc) => bloc.add(const HomeSubscriptionRequested()),
        verify: (_) {
          verify(() => watchRoutines(watchRoutinesParams)).called(1);
          verify(() => watchLatestRoutineTrackerUseCase()).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits [HomeLoadingData, HomeLoadSuccess] '
        'when HomeSubscriptionRequested is added and success.',
        build: buildBloc,
        act: (bloc) => bloc.add(const HomeSubscriptionRequested()),
        expect: () => <HomeState>[
          const HomeLoadingData(),
          HomeLoadingSuccess(
            todayRoutines:
                mockRoutines.mapIndexed((index, it) {
                  final tracker = mockTrackers[index];
                  final trackable = TrackableRoutine(
                    routine: it,
                    lastTracked: tracker,
                  );
                  return TrackableRoutineUI(
                    trackable: trackable,
                    isTracked: index == 0,
                  );
                }).toList()..sort(
                  (a, b) => a.isTracked == b.isTracked
                      ? 0
                      : a.isTracked
                      ? 1
                      : -1,
                ),
          ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'emits [HomeLoadingData, HomeLoadFailed] '
        'when HomeSubscriptionRequested is added '
        'and WatchLatestRoutineTrackerUseCase failed.',
        setUp: () {
          when(() => watchLatestRoutineTrackerUseCase()).thenAnswer(
            (_) => Stream.value(AppResult.failed(AppException.test())),
          );
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const HomeSubscriptionRequested()),
        expect: () => <HomeState>[
          const HomeLoadingData(),
          HomeLoadingFailed(exception: AppException.test()),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'emits [HomeLoadingData, HomeLoadFailed] '
        'when HomeSubscriptionRequested is added '
        'and WatchRoutines failed.',
        setUp: () {
          when(() => watchRoutines(watchRoutinesParams)).thenAnswer(
            (_) => Stream.value(AppResult.failed(AppException.test())),
          );
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const HomeSubscriptionRequested()),
        expect: () => <HomeState>[
          const HomeLoadingData(),
          HomeLoadingFailed(exception: AppException.test()),
        ],
      );
    });
  });
}
