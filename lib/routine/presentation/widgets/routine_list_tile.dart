import 'package:material_ui/material_ui.dart';
import 'package:routrack/routine/routine.dart';

/// Creates [ListTile] to shows [routine] data
class RoutineListTile extends StatelessWidget {
  /// Creates new [RoutineListTile]
  const new({
    required this.routine,
    this.onPressed,
    super.key,
  });

  /// [Routine] that will be showed
  final Routine routine;

  /// Invoked when this tile is pressed
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(routine.name),
      onTap: onPressed,
    );
  }
}
