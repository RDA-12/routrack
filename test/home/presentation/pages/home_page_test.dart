import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final now = DateTime(2026, 11, 14);
  late HomeBloc homeBloc;
  late RoutineTrackerBloc routineTrackerBloc;

  setUpAll(initializeMockDependencies);

  setUp(() {
    homeBloc = di<HomeBloc>();
    whenListen(
      homeBloc,
      Stream.value(
        HomeLoadingSuccess(todayRoutines: mockTrackableRoutinesUI),
      ),
      initialState: HomeLoadingSuccess(todayRoutines: mockTrackableRoutinesUI),
    );
    when(homeBloc.close).thenAnswer((_) async {});

    routineTrackerBloc = di<RoutineTrackerBloc>();
    whenListen(
      routineTrackerBloc,
      Stream.value(const RoutineTrackerState()),
      initialState: const RoutineTrackerState(),
    );
    when(routineTrackerBloc.close).thenAnswer((_) async {});

    when(() => di<AppClock>().getCurrentDateTime()).thenReturn(now);
  });

  tearDown(() {
    reset(homeBloc);
    reset(routineTrackerBloc);
    reset(di<AppClock>());
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
        'provides HomeBloc',
        (tester) async {
          await pumpWidget(tester);

          final finder = find.byType(BlocProvider<HomeBloc>);

          expect(finder, findsOneWidget);
        },
      );

      testWidgets(
        'provides RoutineTrackerBloc',
        (tester) async {
          await pumpWidget(tester);

          final finder = find.byType(BlocProvider<RoutineTrackerBloc>);

          expect(finder, findsOneWidget);
        },
      );

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
          expect(widget.trackables, mockTrackableRoutinesUI);

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

      testWidgets(
        'shows correct tracked routine when state is loaded',
        (tester) async {
          await pumpWidget(tester);

          for (final trackable in mockTrackableRoutinesUI) {
            final finder = find.ancestor(
              of: find.text(trackable.trackable.routine.name),
              matching: find.byType(TrackableRoutineListTile),
            );
            expect(finder, findsOneWidget);
            await tester.ensureVisible(finder);

            final widget = tester.widget<TrackableRoutineListTile>(finder);
            expect(widget.isTracked, trackable.isTracked);
          }
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

    group('Side Effects', () {
      testWidgets(
        'add RoutineTrackerTrackRequested to RoutineTrackerBloc '
        'with correct params when TrackableRoutineList onChanged fired',
        (tester) async {
          await pumpWidget(tester);

          final listFinder = find.byType(TrackableRoutineList);
          expect(listFinder, findsOneWidget);

          final tileFinder = find.descendant(
            of: listFinder,
            matching: find.ancestor(
              of: find.text(
                mockTrackableRoutinesUI.first.trackable.routine.name,
              ),
              matching: find.byType(TrackableRoutineListTile),
            ),
          );
          expect(tileFinder, findsOneWidget);
          await tester.tap(tileFinder);
          await tester.pumpAndSettle();

          final confirmButtonFinder = find.ancestor(
            of: find.text('Log it'),
            matching: find.byType(TextButton),
          );
          expect(confirmButtonFinder, findsOneWidget);
          await tester.tap(confirmButtonFinder);
          await tester.pumpAndSettle();

          verify(
            () => routineTrackerBloc.add(
              RoutineTrackerTrackRequested(
                routine: mockTrackableRoutinesUI.first.trackable.routine,
                date: now,
              ),
            ),
          );
        },
      );

      testWidgets(
        'shows correct snackbar when RoutineTrackerBloc emits notice',
        (tester) async {
          final controller = StreamController<RoutineTrackerState>.broadcast();
          whenListen(routineTrackerBloc, controller.stream);
          await pumpWidget(tester);

          controller.add(
            RoutineTrackerState(
              notice: CreatedNoticeUI(data: mockTrackableRoutine),
            ),
          );
          await tester.pump(const Duration(milliseconds: 100));

          final snackBarFinder = find.byType(SnackBar);
          expect(snackBarFinder, findsOneWidget);

          final successMessageFinder = find.descendant(
            of: snackBarFinder,
            matching: find.text(
              'Congratulations, '
              '${mockTrackableRoutine.routine.name} has been logged as finish',
            ),
          );
          expect(successMessageFinder, findsOneWidget);

          controller.add(
            RoutineTrackerState(
              notice: FailedNoticeUI(
                data: mockTrackableRoutine,
                operation: .create,
                exception: AppException.test(),
              ),
            ),
          );
          await tester.pump(const Duration(milliseconds: 100));

          final failedMessageFinder = find.descendant(
            of: snackBarFinder,
            matching: find.text(
              'Unfortunately, '
              '${mockTrackableRoutine.routine.name} failed to be logged. '
              'Please try again later',
            ),
          );
          expect(failedMessageFinder, findsOneWidget);
        },
      );
    });
  });
}
