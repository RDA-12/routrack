import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/tracker/presentation/models/models.dart';
import 'package:routrack/tracker/presentation/widgets/trackable_routine_list_tile.dart';

/// Signature callback when a routine's tracked state is changed
typedef OnTracktableRoutineChanged = void Function(
  BuildContext context,
  TrackableRoutineUI trackable, {
  required bool isTracked,
});

/// Creates [ListView] to shows [trackables] with [TrackableRoutineListTile]
class TrackableRoutineList extends StatelessWidget {
  /// Creates new [TrackableRoutineList]
  const new({
    required this.trackables,
    this.onChanged,
    super.key,
  });

  /// Creates new [TrackableRoutineList]
  final List<TrackableRoutineUI> trackables;

  /// Invoked when a routine is pressed
  final OnTracktableRoutineChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    if (trackables.isEmpty) {
      return const AppEmptyBox(
        title: 'Routines empty',
        content: 'There is no routines that can be tracked this time',
      );
    }

    return ListView.separated(
      itemCount: trackables.length,
      separatorBuilder: (_, _) => const Divider(),
      itemBuilder: (context, index) {
        final trackable = trackables[index];
        return TrackableRoutineListTile(
          isTracked: trackable.isTracked,
          routine: trackable.trackable.routine,
          onChanged: onChanged == null
              ? null
              : (context, {required isTracked}) {
                  onChanged!(context, trackable, isTracked: isTracked);
                },
        );
      },
    );
  }
}
