import 'package:equatable/equatable.dart';
import 'package:routrack/tracker/tracker.dart';

/// UI model for [TrackableRoutine]
final class TrackableRoutineUI extends Equatable {
  /// Creates new [TrackableRoutineUI]
  const new({
    required this.trackable,
    required this.isTracked,
  });

  /// [TrackableRoutine] data
  final TrackableRoutine trackable;

  /// Whether the [trackable] is tracked
  final bool isTracked;

  @override
  List<Object?> get props => [trackable, isTracked];
}
