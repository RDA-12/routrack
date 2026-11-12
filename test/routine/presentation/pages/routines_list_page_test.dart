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
  late RoutinesBloc routinesBloc;

  setUpAll(initializeMockDependencies);

  setUp(() {
    routinesBloc = di<RoutinesBloc>();
    whenListen(
      routinesBloc,
      Stream.value(RoutinesLoadSuccess(routines: mockRoutines)),
      initialState: RoutinesLoadSuccess(routines: mockRoutines),
    );
    when(routinesBloc.close).thenAnswer((_) async {});
  });

  tearDown(() {
    reset(routinesBloc);
  });

  Future<void> pumpWidget(WidgetTester tester) {
    return tester.pumpPageForTest(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const RoutinesListPage(),
        ),
      ],
    );
  }

  group('RoutinesListPage', () {
    group('Init', () {
      testWidgets(
        'add RoutinesSubscriptionRequested event once',
        (tester) async {
          await pumpWidget(tester);

          verify(() => routinesBloc.add(const RoutinesSubscriptionRequested()))
              .called(1);
        },
      );
    });

    group('Render', () {
      testWidgets(
        'shows LoadingIndicator when state is initial',
        (tester) async {
          whenListen(
            routinesBloc,
            Stream.value(const RoutinesInitial()),
            initialState: const RoutinesInitial(),
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
            routinesBloc,
            Stream.value(const RoutinesLoadingData()),
            initialState: const RoutinesLoadingData(),
          );
          await pumpWidget(tester);

          final finder = find.byType(LoadingIndicator);

          expect(finder, findsOneWidget);
        },
      );

      testWidgets(
        'shows RoutinesList when state is loaded',
        (tester) async {
          await pumpWidget(tester);

          final finder = find.byType(RoutinesList);
          final widget = tester.widget<RoutinesList>(finder);

          expect(finder, findsOneWidget);
          expect(widget.routines, mockRoutines);
        },
      );

      testWidgets(
        'shows AppExceptionBox when state is failed',
        (tester) async {
          whenListen(
            routinesBloc,
            Stream.value(RoutinesLoadFailed(exception: AppException.test())),
            initialState: RoutinesLoadFailed(exception: AppException.test()),
          );
          await pumpWidget(tester);

          final finder = find.byType(AppExceptionBox);
          final widget = tester.widget<AppExceptionBox>(finder);

          expect(finder, findsOneWidget);
          expect(widget.title, 'Failed to load routines');
          expect(widget.exception, AppException.test());
        },
      );
    });
  });
}
