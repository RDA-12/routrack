import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/home/presentation/bloc/home_bloc.dart';
import 'package:routrack/routine/routine.dart';

/// Page to be showed on home
class HomePage extends StatelessWidget {
  /// Creates new [HomePage]
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di<HomeBloc>()..add(const HomeSubscriptionRequested()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Routrack'),
          centerTitle: true,
        ),
        body: Builder(
          builder: (context) {
            return Padding(
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
                                const CreateRoutineRoute().push<void>(context),
                              );
                            },
                            child: const Text('Create now'),
                          ),
                        );
                      }
                      return RoutinesList(routines: todayRoutines);
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
            );
          },
        ),
      ),
    );
  }
}
