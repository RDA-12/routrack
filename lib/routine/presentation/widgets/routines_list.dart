import 'package:material_ui/material_ui.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/routine/routine.dart';

/// Shows [routines] in [ListView] when routines is not empty.
/// Otherwise, shows [AppEmptyBox]
class RoutinesList extends StatelessWidget {
  /// Creates new [RoutinesList]
  const new({
    required this.routines,
    this.onPressed,
    super.key,
  });

  /// List of [Routine] that will be showed
  final List<Routine> routines;

  /// Invoked when a [Routine] is pressed
  final void Function(BuildContext context, Routine routine)? onPressed;

  @override
  Widget build(BuildContext context) {
    if (routines.isEmpty) {
      return const AppEmptyBox(
        title: 'Routines empty',
        content:
            'You never create your routine data. '
            'Start create now and reach your ultimate goals ',
      );
    }
    return ListView.separated(
      itemCount: routines.length,
      separatorBuilder: (_, _) => const Divider(),
      itemBuilder: (context, index) {
        final routine = routines[index];
        return RoutineListTile(
          routine: routine,
          onPressed: onPressed == null
              ? null
              : () {
                  onPressed!(context, routine);
                },
        );
      },
    );
  }
}
