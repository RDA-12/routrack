import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/home/presentation/bloc/bloc.dart';
import 'package:routrack/tracker/tracker.dart';

/// Page to be showed on home
class HomePage extends StatelessWidget {
  /// Creates new [HomePage]
  const new({super.key});

  void _onTrackableRoutineChanged(
    BuildContext context,
    TrackableRoutine trackable, {
    required bool isTracked,
  }) {
    if (!isTracked) {
      // TODO(RDA12): implement untracked routine
    } else {
      context.read<RoutineTrackerBloc>().add(
        RoutineTrackerTrackRequested(
          routine: trackable.routine,
          date: di<AppClock>().getCurrentDateTime(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              di<HomeBloc>()..add(const HomeSubscriptionRequested()),
        ),
        BlocProvider(
          create: (context) => di<RoutineTrackerBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Routrack'),
          centerTitle: true,
        ),
        body: Builder(
          builder: (context) {
            return BlocListener<RoutineTrackerBloc, RoutineTrackerState>(
              listenWhen: (p, c) => p.notice != c.notice,
              listener: (context, state) {
                late final String? content;
                switch (state.notice) {
                  case CreatedNoticeUI<TrackableRoutine>(:final data):
                    content =
                        'Congratulations, '
                        '${data.routine.name} has been logged as finish';
                  case FailedNoticeUI<TrackableRoutine>(:final data):
                    content =
                        'Unfortunately, '
                        '${data.routine.name} failed to be logged. '
                        'Please try again later';
                  case null:
                  case UpdatedNoticeUI<TrackableRoutine>():
                  case DeletedNoticeUI<TrackableRoutine>():
                    content = null;
                }
                if (content == null) return;
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(content)));
              },
              child: Padding(
                padding: AppSpacing.pagePadding,
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    switch (state) {
                      case HomeInitial():
                      case HomeLoadingData():
                        return const Center(
                          child: LoadingIndicator(),
                        );
                      case HomeLoadingSuccess(:final todayRoutines):
                        if (todayRoutines.isEmpty) {
                          return AppEmptyBox(
                            title: 'You are free today!',
                            content:
                                'There is nothing to do today. '
                                'You can enjoy your time '
                                'or create new routine for this day.',
                            action: FilledButton(
                              onPressed: () {
                                unawaited(
                                  const CreateRoutineRoute().push<void>(
                                    context,
                                  ),
                                );
                              },
                              child: const Text('Create now'),
                            ),
                          );
                        }
                        return Column(
                          spacing: 8,
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              "Today's routines",
                              style: context.text.titleMedium,
                            ),
                            Expanded(
                              child: TrackableRoutineList(
                                routines: todayRoutines,
                                isTracked: (trackable) =>
                                    trackable.lastTracked?.date ==
                                    DateTime.now(),
                                onChanged: _onTrackableRoutineChanged,
                              ),
                            ),
                          ],
                        );
                      case HomeLoadingFailed(:final exception):
                        return Center(
                          child: AppExceptionBox(
                            title: 'Failed to load home data',
                            exception: exception,
                          ),
                        );
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
