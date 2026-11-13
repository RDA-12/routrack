import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/app_exception.dart';
import 'package:routrack/home/home.dart';
import 'package:routrack/tracker/tracker.dart';

import '../../../common/di_mock.dart';
import '../../../helper.dart';
import '../../../tracker/domain/entities/tracker_mock.dart';

void main() {
  late HomeBloc homeBloc;

  setUpAll(initializeMockDependencies);

  setUp(() {
    homeBloc = di<HomeBloc>();
    whenListen(
      homeBloc,
      Stream.value(HomeLoadingSuccess(todayRoutines: [mockTrackableRoutine])),
      initialState: HomeLoadingSuccess(todayRoutines: [mockTrackableRoutine]),
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
        GoRoute(
          path: '/routines',
          builder: (context, state) => const Placeholder(),
          routes: [
            GoRoute(
              path: 'create',
              builder: (context, state) => const Placeholder(
                key: ValueKey('create-routine'),
              ),
            ),
          ],
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
            'or create new routine for this day.',
          );

          final createButtonFinder = find.ancestor(
            of: find.text('Create now'),
            matching: find.byType(FilledButton),
          );
          expect(createButtonFinder, findsOneWidget);
        },
      );

      testWidgets(
        'shows TrackableRoutineList when state is loaded',
        (tester) async {
          await pumpWidget(tester);

          final finder = find.byType(TrackableRoutineList);
          final widget = tester.widget<TrackableRoutineList>(finder);

          expect(finder, findsOneWidget);
          expect(widget.routines, [mockTrackableRoutine]);

          final titleFinder = find.text("Today's routines");
          expect(titleFinder, findsOneWidget);
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

    group('Interactions', () {
      testWidgets(
        'go to CreateRoutinePage when create routine button is pressed',
        (tester) async {
          whenListen(
            homeBloc,
            Stream.value(const HomeLoadingSuccess(todayRoutines: [])),
            initialState: const HomeLoadingSuccess(todayRoutines: []),
          );
          await pumpWidget(tester);

          final buttonFinder = find.ancestor(
            of: find.text('Create now'),
            matching: find.byType(FilledButton),
          );

          await tester.tap(buttonFinder);
          await tester.pumpAndSettle();

          expect(find.byKey(const ValueKey('create-routine')), findsOneWidget);
        },
      );
    });
  });
}
