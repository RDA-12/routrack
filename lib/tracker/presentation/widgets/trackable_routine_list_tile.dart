import 'package:material_ui/material_ui.dart';
import 'package:routrack/routine/routine.dart';

/// Signature callback for tracked routine changes
typedef OnRoutineTrackChanged = void Function(
  BuildContext context, {
  required bool isTracked,
});

/// Creates [CheckboxListTile] for the [routine]
class TrackableRoutineListTile extends StatelessWidget {
  /// Creates new [TrackableRoutineListTile]
  const new({
    required this.isTracked,
    required this.routine,
    this.onChanged,
    super.key,
  });

  /// Whether this routine already tracked or not
  final bool isTracked;

  /// [Routine] that will be showed
  final Routine routine;

  /// Invoked when this tile is pressed
  final OnRoutineTrackChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(routine.name),
      controlAffinity: .leading,
      value: isTracked,
      onChanged: onChanged == null
          ? null
          : (value) {
              if (value == true) {
                onChanged!(context, isTracked: value!);
              } else {
                onChanged!(context, isTracked: false);
              }
            },
    );
  }
}
