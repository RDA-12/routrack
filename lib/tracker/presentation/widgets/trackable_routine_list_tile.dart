import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';
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

  Future<bool?> _showConfirmationDialog(BuildContext context) async {
    if (isTracked) return null;
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Did you finish "${routine.name}"?'),
          content: const Text(
            "Lets get it logged so you can see how far you've come",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Log it'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        routine.name,
        style: TextStyle(
          color: isTracked ? context.color.onPrimaryContainer : null,
        ),
      ),
      controlAffinity: .leading,
      value: isTracked,
      selected: isTracked,
      selectedTileColor: context.color.primaryContainer,
      onChanged: onChanged == null
          ? null
          : (value) async {
              if (value == null || !value) return;
              final confirmToTrack =
                  await _showConfirmationDialog(context) ?? false;
              if (!context.mounted) return;
              if (!confirmToTrack) return;
              onChanged!(context, isTracked: true);
            },
    );
  }
}
