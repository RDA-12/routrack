import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/routine/routine.dart';

import '../../../common/di_mock.dart';
import '../../domain/entities/routine_mocks.dart';

void main() {
  final params = CreateRoutineParams(
    name: mockRoutine.name,
    days: const {.mon, .thu},
  );
  late CreateRoutineUseCase createRoutineUseCase;

  setUpAll(() {
    initializeMockDependencies();
    registerFallbackValue(params);
  });

  setUp(() {
    createRoutineUseCase = di<CreateRoutineUseCase>();
    when(() => createRoutineUseCase(any()))
        .thenAnswer((_) async => AppResult.success(mockRoutine));
  });

  tearDown(() {
    reset(createRoutineUseCase);
  });

  RoutineMutationBloc buildBloc() {
    return RoutineMutationBloc(
      createRoutineUseCase: createRoutineUseCase,
    );
  }

  group('RoutineMutationBloc', () {
    test('has correct initial state', () {
      final bloc = buildBloc();

      expect(bloc.state, const RoutineMutationState());
    });

    group('RoutineMutationCreationRequested', () {
      blocTest<RoutineMutationBloc, RoutineMutationState>(
        'calls CreateRoutineUseCase once with correct params',
        build: buildBloc,
        act: (bloc) =>
            bloc.add(RoutineMutationCreationRequested(params: params)),
        verify: (_) {
          verify(() => createRoutineUseCase(params)).called(1);
        },
      );

      blocTest<RoutineMutationBloc, RoutineMutationState>(
        'emits [isCreating: true, isCreating: false, created notice] '
        'when RoutineMutationCreationRequested is added and success',
        build: buildBloc,
        act: (bloc) =>
            bloc.add(RoutineMutationCreationRequested(params: params)),
        expect: () => const <RoutineMutationState>[
          RoutineMutationState(isCreating: true),
          RoutineMutationState(notice: CreatedNoticeUI(data: mockRoutine)),
        ],
      );

      blocTest<RoutineMutationBloc, RoutineMutationState>(
        'emits [isCreating: true, isCreating: false, failed notice] '
        'when RoutineMutationCreationRequested is added and failed',
        setUp: () {
          when(() => createRoutineUseCase(params))
              .thenAnswer((_) async => AppResult.failed(AppException.test()));
        },
        build: buildBloc,
        act: (bloc) =>
            bloc.add(RoutineMutationCreationRequested(params: params)),
        expect: () => <RoutineMutationState>[
          const RoutineMutationState(isCreating: true),
          RoutineMutationState(
            notice: FailedNoticeUI(
              data: Routine(id: 'failed', name: params.name),
              operation: .create,
              exception: AppException.test(),
            ),
          ),
        ],
      );
    });
  });
}
