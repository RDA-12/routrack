import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/routine/routine.dart';

import '../../../common/di_mock.dart';
import '../../domain/entities/routine_mocks.dart';

void main() {
  late WatchRoutines watchRoutines;

  setUpAll(initializeMockDependencies);

  setUp(() {
    watchRoutines = di<WatchRoutines>();
    when(() => watchRoutines()).thenAnswer(
      (_) => Stream.value(AppResult.success([mockRoutine])),
    );
  });

  tearDown(() {
    reset(watchRoutines);
  });

  RoutinesBloc buildBloc() {
    return RoutinesBloc(watchRoutines: watchRoutines);
  }

  group('RoutinesBloc', () {
    test('correct state initially', () {
      final bloc = buildBloc();

      expect(bloc.state, const RoutinesInitial());
    });

    group('RoutinesSubscriptionRequested', () {
      blocTest<RoutinesBloc, RoutinesState>(
        'calls WatchRoutines once',
        build: buildBloc,
        act: (bloc) => bloc.add(const RoutinesSubscriptionRequested()),
        verify: (_) {
          verify(() => watchRoutines()).called(1);
        },
      );

      blocTest<RoutinesBloc, RoutinesState>(
        'emits [RoutinesLoadingData, RoutinesLoadSuccess] '
        'when RoutinesSubscriptionRequested is added and success.',
        build: buildBloc,
        act: (bloc) => bloc.add(const RoutinesSubscriptionRequested()),
        expect: () => <RoutinesState>[
          const RoutinesLoadingData(),
          RoutinesLoadSuccess(routines: [mockRoutine]),
        ],
      );

      blocTest<RoutinesBloc, RoutinesState>(
        'emits [RoutinesLoadingData, RoutinesLoadFailed] '
        'when RoutinesSubscriptionRequested is added and failed.',
        setUp: () {
          when(() => watchRoutines()).thenAnswer(
            (_) => Stream.value(AppResult.failed(AppException.test())),
          );
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const RoutinesSubscriptionRequested()),
        expect: () => <RoutinesState>[
          const RoutinesLoadingData(),
          RoutinesLoadFailed(exception: AppException.test()),
        ],
      );
    });
  });
}
