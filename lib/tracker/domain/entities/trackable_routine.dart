import 'package:equatable/equatable.dart';
import 'package:routrack/routine/routine.dart';
import 'package:routrack/tracker/domain/entities/tracker.dart';

/// Representing single [Routine] with it last [Tracker]
final class TrackableRoutine extends Equatable {
  /// Creates new [TrackableRoutine]
  const new({required this.routine, required this.lastTracked});

  /// The [Routine]
  final Routine routine;

  /// When the [routine] tracked last time
  final Tracker? lastTracked;

  @override
  List<Object?> get props => [routine, lastTracked];
}
