import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/tracker/domain/domain.dart';
import 'package:routrack/tracker/presentation/widgets/trackable_routine_list_tile.dart';

/// Signature callback when a routine's tracked state is changed
typedef OnTracktableRoutineChanged = void Function(
  BuildContext context,
  TrackableRoutine routine, {
  required bool isTracked,
});

/// Creates [ListView] to shows [routines] with [TrackableRoutineListTile]
class TrackableRoutineList extends StatelessWidget {
  /// Creates new [TrackableRoutineList]
  const new({
    required this.routines,
    required this.isTracked,
    this.onChanged,
    super.key,
  });

  /// Creates new [TrackableRoutineList]
  final List<TrackableRoutine> routines;

  /// Invoked when a routine is pressed
  final OnTracktableRoutineChanged? onChanged;

  /// Returns true when provided trackable is already tracked
  final bool Function(TrackableRoutine trackable) isTracked;

  @override
  Widget build(BuildContext context) {
    if (routines.isEmpty) {
      return const AppEmptyBox(
        title: 'Routines empty',
        content: 'There is no routines that can be tracked this time',
      );
    }

    return ListView.separated(
      itemCount: routines.length,
      separatorBuilder: (_, _) => const Divider(),
      itemBuilder: (context, index) {
        final trackable = routines[index];
        return TrackableRoutineListTile(
          isTracked: isTracked(trackable),
          routine: trackable.routine,
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
