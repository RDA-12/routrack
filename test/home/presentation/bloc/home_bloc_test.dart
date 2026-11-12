import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/home/presentation/bloc/home_bloc.dart';
import 'package:routrack/routine/routine.dart';

import '../../../common/di_mock.dart';
import '../../../routine/domain/entities/routine_mocks.dart';

void main() {
  final now = DateTime.utc(2026);
  final watchRoutinesParams = WatchRoutinesParams(date: now);
  late WatchRoutines watchRoutines;
  late AppClock clock;

  setUpAll(() {
    registerFallbackValue(const WatchRoutinesParams());
    initializeMockDependencies();
  });

  setUp(() {
    watchRoutines = di<WatchRoutines>();
    when(() => watchRoutines(any())).thenAnswer(
      (_) => Stream.value(AppResult.success([mockRoutine])),
    );

    clock = di<AppClock>();
    when(clock.getCurrentDateTime).thenReturn(now);
  });

  tearDown(() {
    reset(watchRoutines);
    reset(clock);
  });

  HomeBloc buildBloc() {
    return HomeBloc(
      watchRoutines: watchRoutines,
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
        'calls WatchRoutines once',
        build: buildBloc,
        act: (bloc) => bloc.add(const HomeSubscriptionRequested()),
        verify: (_) {
          verify(() => watchRoutines(watchRoutinesParams)).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits [HomeLoadingData, HomeLoadSuccess] '
        'when HomeSubscriptionRequested is added and success.',
        build: buildBloc,
        act: (bloc) => bloc.add(const HomeSubscriptionRequested()),
        expect: () => <HomeState>[
          const HomeLoadingData(),
          HomeLoadingSuccess(todayRoutines: [mockRoutine]),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'emits [HomeLoadingData, HomeLoadFailed] '
        'when HomeSubscriptionRequested is added and failed.',
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
