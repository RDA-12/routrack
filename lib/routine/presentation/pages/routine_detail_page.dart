import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/routine/presentation/bloc/bloc.dart';
import 'package:routrack/routine/presentation/widgets/widgets.dart';

/// Page to shows routine detail
class RoutineDetailPage extends StatelessWidget {
  /// Creates new [RoutineDetailPage]
  const new({required this.id, super.key});

  /// ID of the routine
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<SingleRoutineBloc>()
        ..add(
          SingleRoutineSubscribeByIdRequested(id),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Routine detail'),
        ),
        body: Padding(
          padding: AppSpacing.pagePadding,
          child: Builder(
            builder: (context) {
              return BlocBuilder<SingleRoutineBloc, SingleRoutineState>(
                builder: (context, state) {
                  switch (state) {
                    case SingleRoutineInitial():
                    case SingleRoutineLoadData():
                      return const Center(
                        child: LoadingIndicator(),
                      );
                    case SingleRoutineLoadSuccess(:final routine):
                      return RoutineDetail(
                        routine: routine,
                        onRoutineSaved: (params) {
                          // TODO(RDA12): implement update routine
                        },
                      );
                    case SingleRoutineLoadFailed(:final exception):
                      return Center(
                        child: AppExceptionBox(
                          title: 'Failed to load routine data',
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
