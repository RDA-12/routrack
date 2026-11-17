import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/routine/routine.dart';

import '../../../common/di_mock.dart';
import '../../domain/entities/routine_mocks.dart';

void main() {
  late WatchRoutineByIdUseCase watchRoutineByIdUseCase;

  setUpAll(initializeMockDependencies);

  setUp(() {
    watchRoutineByIdUseCase = di<WatchRoutineByIdUseCase>();
    when(() => watchRoutineByIdUseCase(mockRoutine.id)).thenAnswer(
      (_) => Stream.value(AppResult.success(mockRoutine)),
    );
  });

  tearDown(() {
    reset(watchRoutineByIdUseCase);
  });

  SingleRoutineBloc buildBloc() {
    return SingleRoutineBloc(watchRoutineByIdUseCase: watchRoutineByIdUseCase);
  }

  group('SingleRoutineBloc', () {
    test('correct state initially', () {
      final bloc = buildBloc();

      expect(bloc.state, const SingleRoutineInitial());
    });

    group('SingleRoutineSubscribeByIdRequested', () {
      blocTest<SingleRoutineBloc, SingleRoutineState>(
        'calls WatchRoutineByIdUseCase once',
        build: buildBloc,
        act: (bloc) =>
            bloc.add(SingleRoutineSubscribeByIdRequested(mockRoutine.id)),
        verify: (_) {
          verify(() => watchRoutineByIdUseCase(mockRoutine.id)).called(1);
        },
      );

      blocTest<SingleRoutineBloc, SingleRoutineState>(
        'emits [SingleRoutineLoadData, SingleRoutineLoadSuccess] '
        'when SingleRoutineSubscribeByIdRequested is added and success.',
        build: buildBloc,
        act: (bloc) =>
            bloc.add(SingleRoutineSubscribeByIdRequested(mockRoutine.id)),
        expect: () => <SingleRoutineState>[
          const SingleRoutineLoadData(),
          SingleRoutineLoadSuccess(routine: mockRoutine),
        ],
      );

      blocTest<SingleRoutineBloc, SingleRoutineState>(
        'emits [SingleRoutineLoadData, SingleRoutineLoadFailed] '
        'when SingleRoutineSubscribeByIdRequested is added and failed.',
        setUp: () {
          when(() => watchRoutineByIdUseCase(mockRoutine.id)).thenAnswer(
            (_) => Stream.value(AppResult.failed(AppException.test())),
          );
        },
        build: buildBloc,
        act: (bloc) =>
            bloc.add(SingleRoutineSubscribeByIdRequested(mockRoutine.id)),
        expect: () => <SingleRoutineState>[
          const SingleRoutineLoadData(),
          SingleRoutineLoadFailed(exception: AppException.test()),
        ],
      );
    });
  });
}
