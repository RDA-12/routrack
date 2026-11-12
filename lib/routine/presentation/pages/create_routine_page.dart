import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/routine/domain/entities/routine.dart';
import 'package:routrack/routine/presentation/bloc/bloc.dart';
import 'package:routrack/routine/presentation/widgets/widgets.dart';

/// Page to create new routine
class CreateRoutinePage extends StatefulWidget {
  /// Creates new [CreateRoutinePage]
  const new({super.key});

  @override
  State<CreateRoutinePage> createState() => _CreateRoutinePageState();
}

class _CreateRoutinePageState extends State<CreateRoutinePage> {
  final controller = LoadingOverlayController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<RoutineMutationBloc>(),
      child: LoadingOverlay(
        controller: controller,
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Create new routine'),
          ),
          body: Padding(
            padding: AppSpacing.pagePadding,
            child: Builder(
              builder: (context) {
                return BlocListener<RoutineMutationBloc, RoutineMutationState>(
                  listener: (context, state) {
                    if (state.isCreating) {
                      controller.show();
                    } else {
                      switch (state.notice) {
                        case FailedNoticeUI<Routine>(
                          :final exception,
                          :final operation,
                        ):
                          late final String title;
                          final content = exception.getUserMessage();
                          switch (operation) {
                            case OperationType.create:
                              title = 'Create routine failed';
                            case OperationType.update:
                              title = 'Update routine failed';
                            case OperationType.delete:
                              title = 'Delete routine failed';
                          }
                          controller.transitionToResult(
                            LoadingOverlayResult(
                              title: title,
                              content: content,
                            ),
                          );
                        case CreatedNoticeUI<Routine>(:final data):
                          controller.transitionToResult(
                            LoadingOverlayResult(
                              title: 'New routine created',
                              content:
                                  'Your "${data.name}" routine '
                                  'has been created. '
                                  'Now, you can start track the routine and '
                                  'reach your ultimate goals',
                            ),
                          );
                        case UpdatedNoticeUI<Routine>():
                          // TODO(RDA12): Handle this case.
                          throw UnimplementedError();
                        case DeletedNoticeUI<Routine>():
                          // TODO(RDA12): Handle this case.
                          throw UnimplementedError();
                        case null:
                      }
                    }
                  },
                  child: RoutineForm(
                    onRoutineSaved: (params) {
                      context.read<RoutineMutationBloc>().add(
                        RoutineMutationCreationRequested(params: params),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
