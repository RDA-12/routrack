import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/tracker/tracker.dart';

import '../../../common/di_mock.dart';
import '../../../routine/domain/entities/routine_mocks.dart';
import '../../domain/entities/tracker_mock.dart';

void main() {
  final params = TrackRoutineParams(
    routineId: mockRoutine.id,
    date: DateTime.now(),
  );
  late TrackRoutineUseCase trackRoutineUseCase;

  setUpAll(() {
    registerFallbackValue(params);
    initializeMockDependencies();
  });

  setUp(() {
    trackRoutineUseCase = di<TrackRoutineUseCase>();
    when(() => trackRoutineUseCase(any()))
        .thenAnswer((_) async => AppResult.success(mockTracker));
  });

  tearDown(() {
    reset(trackRoutineUseCase);
  });

  RoutineTrackerBloc buildBloc() {
    return RoutineTrackerBloc(trackRoutineUseCase: trackRoutineUseCase);
  }

  group('RoutineTrackerBloc', () {
    test('has correct initial state', () {
      final bloc = buildBloc();

      expect(bloc.state, const RoutineTrackerState());
    });

    group('RoutineTrackerTrackRequested', () {
      blocTest<RoutineTrackerBloc, RoutineTrackerState>(
        'calls TrackRoutineUseCase once with correct params',
        build: buildBloc,
        act: (bloc) => bloc.add(
          RoutineTrackerTrackRequested(routine: mockRoutine, date: params.date),
        ),
        verify: (_) {
          verify(() => trackRoutineUseCase(params)).called(1);
        },
      );

      blocTest<RoutineTrackerBloc, RoutineTrackerState>(
        'emits [added loadingIds, removed loadingIds with created notice ] '
        'when RoutineTrackerTrackRequested is added and success',
        seed: () => const RoutineTrackerState(loadingIds: {'uid'}),
        build: buildBloc,
        act: (bloc) => bloc.add(
          RoutineTrackerTrackRequested(routine: mockRoutine, date: params.date),
        ),
        expect: () => <RoutineTrackerState>[
          RoutineTrackerState(
            loadingIds: {'uid', mockRoutine.id},
          ),
          RoutineTrackerState(
            loadingIds: const {'uid'},
            notice: CreatedNoticeUI(data: mockRoutine),
          ),
        ],
      );

      blocTest<RoutineTrackerBloc, RoutineTrackerState>(
        'emits [added loadingIds, removed loadingIds with failed notice ] '
        'when RoutineTrackerTrackRequested is added and failed',
        setUp: () {
          when(() => trackRoutineUseCase(params))
              .thenAnswer((_) async => AppResult.failed(AppException.test()));
        },
        build: buildBloc,
        act: (bloc) => bloc.add(
          RoutineTrackerTrackRequested(routine: mockRoutine, date: params.date),
        ),
        expect: () => <RoutineTrackerState>[
          RoutineTrackerState(
            loadingIds: {mockRoutine.id},
          ),
          RoutineTrackerState(
            notice: FailedNoticeUI(
              data: mockRoutine,
              operation: .create,
              exception: AppException.test(),
            ),
          ),
        ],
      );
    });
  });
}
