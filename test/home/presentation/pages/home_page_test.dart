import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/app_exception.dart';
import 'package:routrack/home/home.dart';
import 'package:routrack/routine/routine.dart';

import '../../../common/di_mock.dart';
import '../../../helper.dart';
import '../../../routine/domain/entities/routine_mocks.dart';

void main() {
  late HomeBloc homeBloc;

  setUpAll(initializeMockDependencies);

  setUp(() {
    homeBloc = di<HomeBloc>();
    whenListen(
      homeBloc,
      Stream.value(HomeLoadingSuccess(todayRoutines: mockRoutines)),
      initialState: HomeLoadingSuccess(todayRoutines: mockRoutines),
    );
    when(homeBloc.close).thenAnswer((_) async {});
  });

  tearDown(() {
    reset(homeBloc);
  });

  Future<void> pumpWidget(WidgetTester tester) {
    return tester.pumpPageForTest(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const HomePage(),
        ),
      ],
    );
  }

  group('HomePage', () {
    group('Init', () {
      testWidgets(
        'add HomeSubscriptionRequested event once',
        (tester) async {
          await pumpWidget(tester);

          verify(() => homeBloc.add(const HomeSubscriptionRequested()))
              .called(1);
        },
      );
    });

    group('Render', () {
      testWidgets(
        'shows LoadingIndicator when state is initial',
        (tester) async {
          whenListen(
            homeBloc,
            Stream.value(const HomeInitial()),
            initialState: const HomeInitial(),
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
            homeBloc,
            Stream.value(const HomeLoadingData()),
            initialState: const HomeLoadingData(),
          );
          await pumpWidget(tester);

          final finder = find.byType(LoadingIndicator);

          expect(finder, findsOneWidget);
        },
      );

      testWidgets(
        'shows AppEmptyBox when state is loaded and todayRoutines is empty',
        (tester) async {
          whenListen(
            homeBloc,
            Stream.value(const HomeLoadingSuccess(todayRoutines: [])),
            initialState: const HomeLoadingSuccess(todayRoutines: []),
          );
          await pumpWidget(tester);

          final finder = find.byType(AppEmptyBox);
          final widget = tester.widget<AppEmptyBox>(finder);

          expect(finder, findsOneWidget);
          expect(widget.title, 'You are free today!');
          expect(
            widget.content,
            'There is nothing to do today. '
            'You can enjoy your time '
            'or create new routine this day.',
          );
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
            homeBloc,
            Stream.value(HomeLoadingFailed(exception: AppException.test())),
            initialState: HomeLoadingFailed(exception: AppException.test()),
          );
          await pumpWidget(tester);

          final finder = find.byType(AppExceptionBox);
          final widget = tester.widget<AppExceptionBox>(finder);

          expect(finder, findsOneWidget);
          expect(widget.title, 'Failed to load home data');
          expect(widget.exception, AppException.test());
        },
      );
    });
  });
}
