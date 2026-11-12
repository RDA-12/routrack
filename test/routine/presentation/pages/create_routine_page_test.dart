import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/core.dart';
import 'package:routrack/routine/routine.dart';

import '../../../common/di_mock.dart';
import '../../../helper.dart';
import '../../domain/entities/routine_mocks.dart';

void main() {
  const params = CreateRoutineParams(
    name: 'name',
    days: {.mon, .tue},
  );
  late RoutineMutationBloc routineMutationBloc;

  setUpAll(() {
    registerFallbackValue(params);
    registerFallbackValue(
      const RoutineMutationCreationRequested(params: params),
    );
    initializeMockDependencies();
  });

  setUp(() {
    routineMutationBloc = di<RoutineMutationBloc>();
    whenListen(
      routineMutationBloc,
      Stream.value(const RoutineMutationState()),
      initialState: const RoutineMutationState(),
    );
    when(routineMutationBloc.close).thenAnswer((_) async {});
  });

  tearDown(() {
    reset(routineMutationBloc);
  });

  Future<void> pumpWidget(WidgetTester tester) {
    return tester.pumpPageForTest(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const CreateRoutinePage(),
        ),
      ],
    );
  }

  group('CreateRoutinePage', () {
    group('Render', () {
      testWidgets('provides RoutineMutationBloc', (tester) async {
        await pumpWidget(tester);

        final finder = find.byType(BlocProvider<RoutineMutationBloc>);

        expect(finder, findsOneWidget);
      });

      testWidgets('shows correct RoutineForm', (tester) async {
        await pumpWidget(tester);

        final finder = find.byType(RoutineForm);

        expect(finder, findsOneWidget);
      });

      testWidgets('use LoadingOverlay', (tester) async {
        await pumpWidget(tester);

        final finder = find.byType(LoadingOverlay);

        expect(finder, findsOneWidget);
      });

      testWidgets(
        'shows LoadingIndicator when isCreating state is true',
        (tester) async {
          final controller = StreamController<RoutineMutationState>.broadcast();
          when(() => routineMutationBloc.stream)
              .thenAnswer((_) => controller.stream);

          await pumpWidget(tester);
          final finder = find.descendant(
            of: find.byType(LoadingOverlay),
            matching: find.byType(LoadingIndicator),
          );
          expect(finder, findsNothing);

          controller.add(const RoutineMutationState(isCreating: true));
          await tester.pump();

          expect(finder, findsOneWidget);
        },
      );

      testWidgets(
        'shows correct result on LoadingOverlay when created notice emitted',
        (tester) async {
          final controller = StreamController<RoutineMutationState>.broadcast();
          when(() => routineMutationBloc.stream)
              .thenAnswer((_) => controller.stream);

          await pumpWidget(tester);
          controller.add(const RoutineMutationState(isCreating: true));
          await tester.pump();
          controller.add(
            RoutineMutationState(
              notice: CreatedNoticeUI(data: mockRoutine),
            ),
          );
          await tester.pump();

          final loadingOverlayResultFinder = find.descendant(
            of: find.byType(LoadingOverlay),
            matching: find.byType(LoadingOverlayResultWidget),
          );
          expect(loadingOverlayResultFinder, findsOneWidget);
          final widget = tester.widget<LoadingOverlayResultWidget>(
            loadingOverlayResultFinder,
          );
          expect(
            widget.result,
            LoadingOverlayResult(
              title: 'New routine created',
              content:
                  'Your "${mockRoutine.name}" routine has been created. '
                  'Now, you can start track the routine and '
                  'reach your ultimate goals',
            ),
          );
        },
      );

      testWidgets(
        'shows correct result on LoadingOverlay '
        'when failed notice emitted after creation failed',
        (tester) async {
          final controller = StreamController<RoutineMutationState>.broadcast();
          when(() => routineMutationBloc.stream)
              .thenAnswer((_) => controller.stream);

          await pumpWidget(tester);
          controller.add(const RoutineMutationState(isCreating: true));
          await tester.pump();
          controller.add(
            RoutineMutationState(
              notice: FailedNoticeUI(
                data: mockRoutine,
                operation: .create,
                exception: AppException.test(),
              ),
            ),
          );
          await tester.pump();

          final loadingOverlayResultFinder = find.descendant(
            of: find.byType(LoadingOverlay),
            matching: find.byType(LoadingOverlayResultWidget),
          );
          expect(loadingOverlayResultFinder, findsOneWidget);
          final widget = tester.widget<LoadingOverlayResultWidget>(
            loadingOverlayResultFinder,
          );
          expect(
            widget.result,
            const LoadingOverlayResult(
              title: 'Create routine failed',
              content:
                  'There is unexpected failure happened. '
                  'We will take a look into that shortly. '
                  'Please, try again later',
            ),
          );
        },
      );
    });

    group('Side Effects', () {
      testWidgets(
        'add RoutineMutationCreationRequested event with correct params '
        'when onRoutineSaved called',
        (tester) async {
          await pumpWidget(tester);

          final finder = find.byType(RoutineForm);
          expect(finder, findsOneWidget);
          final widget = tester.widget<RoutineForm>(finder);
          widget.onRoutineSaved!(params);

          verify(
            () => routineMutationBloc.add(
              const RoutineMutationCreationRequested(params: params),
            ),
          ).called(1);
        },
      );
    });
  });
}
