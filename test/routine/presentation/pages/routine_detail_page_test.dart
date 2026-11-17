import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/app_exception.dart';
import 'package:routrack/routine/routine.dart';

import '../../../common/di_mock.dart';
import '../../../helper.dart';
import '../../domain/entities/routine_mocks.dart';

void main() {
  late SingleRoutineBloc singleRoutineBloc;

  setUpAll(initializeMockDependencies);

  setUp(() {
    singleRoutineBloc = di<SingleRoutineBloc>();
    whenListen(
      singleRoutineBloc,
      Stream.value(SingleRoutineLoadSuccess(routine: mockRoutine)),
      initialState: SingleRoutineLoadSuccess(routine: mockRoutine),
    );
    when(singleRoutineBloc.close).thenAnswer((_) async {});
  });

  tearDown(() {
    reset(singleRoutineBloc);
  });

  Future<void> pumpWidget(WidgetTester tester) {
    return tester.pumpPageForTest(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => RoutineDetailPage(
            id: mockRoutine.id,
          ),
        ),
      ],
    );
  }

  group('RoutineDetailPage', () {
    group('Init', () {
      testWidgets(
        'add SingleRoutineSubscribeByIdRequested event once',
        (tester) async {
          await pumpWidget(tester);

          verify(
            () => singleRoutineBloc.add(
              SingleRoutineSubscribeByIdRequested(mockRoutine.id),
            ),
          ).called(1);
        },
      );
    });

    group('Render', () {
      testWidgets(
        'shows LoadingIndicator when state is initial',
        (tester) async {
          whenListen(
            singleRoutineBloc,
            Stream.value(const SingleRoutineInitial()),
            initialState: const SingleRoutineInitial(),
          );
          await pumpWidget(tester);

          final finder = find.byType(LoadingIndicator);

          expect(finder, findsOneWidget);
        },
      );

      testWidgets(
        'shows LoadingIndicator when state is loading',
        (tester) async {
          whenListen(
            singleRoutineBloc,
            Stream.value(const SingleRoutineLoadData()),
            initialState: const SingleRoutineLoadData(),
          );
          await pumpWidget(tester);

          final finder = find.byType(LoadingIndicator);

          expect(finder, findsOneWidget);
        },
      );

      testWidgets(
        'shows RoutineForm when state is loaded',
        (tester) async {
          await pumpWidget(tester);

          final finder = find.byType(RoutineForm);
          final widget = tester.widget<RoutineForm>(finder);

          expect(finder, findsOneWidget);
          expect(widget.initialRoutine, mockRoutine);
        },
      );

      testWidgets(
        'shows AppExceptionBox when state is failed',
        (tester) async {
          whenListen(
            singleRoutineBloc,
            Stream.value(
              SingleRoutineLoadFailed(exception: AppException.test()),
            ),
            initialState: SingleRoutineLoadFailed(
              exception: AppException.test(),
            ),
          );
          await pumpWidget(tester);

          final finder = find.byType(AppExceptionBox);
          final widget = tester.widget<AppExceptionBox>(finder);

          expect(finder, findsOneWidget);
          expect(widget.title, 'Failed to load routine data');
          expect(widget.exception, AppException.test());
        },
      );
    });
  });
}
