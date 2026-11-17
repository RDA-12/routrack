import 'package:flutter/widgets.dart';
import 'package:routrack/routine/domain/domain.dart';
import 'package:routrack/routine/presentation/widgets/routine_form.dart';

/// Shows detail data of [routine]
class RoutineDetail extends StatelessWidget {
  /// Creates new [RoutineDetail]
  const new({
    required this.routine,
    this.onRoutineSaved,
    super.key,
  });

  /// [Routine] data that will be showed
  final Routine routine;

  /// Invoked when save button is pressed to update the [routine]
  final OnRoutineSaved? onRoutineSaved;

  @override
  Widget build(BuildContext context) {
    return RoutineForm(
      initialRoutine: routine,
      onRoutineSaved: onRoutineSaved,
    );
  }
}
