import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/routine/routine.dart';

/// Page to shows list of [Routine] saved by users
class RoutinesListPage extends StatelessWidget {
  /// Creates new [RoutinesListPage]
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di<RoutinesBloc>()..add(const RoutinesSubscriptionRequested()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Routines list'),
        ),
        body: Padding(
          padding: AppSpacing.pagePadding,
          child: Builder(
            builder: (context) {
              return BlocBuilder<RoutinesBloc, RoutinesState>(
                builder: (context, state) {
                  switch (state) {
                    case RoutinesInitial():
                    case RoutinesLoadingData():
                      return const Center(
                        child: LoadingIndicator(),
                      );
                    case RoutinesLoadSuccess(:final routines):
                      return RoutinesList(
                        routines: routines,
                        onPressed: (context, routine) {
                          unawaited(
                            RoutineDetailRoute(id: routine.id)
                                .push<void>(context),
                          );
                        },
                        onCreatePressed: () {
                          unawaited(
                            const CreateRoutineRoute().push<void>(context),
                          );
                        },
                      );
                    case RoutinesLoadFailed(:final exception):
                      return Center(
                        child: AppExceptionBox(
                          title: 'Failed to load routines',
                          exception: exception,
                        ),
                      );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
