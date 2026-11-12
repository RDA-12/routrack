import 'package:equatable/equatable.dart';
import 'package:routrack/common/common.dart';
import 'package:rrule/rrule.dart';

/// Representing single schedule of a routine
class RoutineSchedule extends Equatable {
  /// Creates new [RoutineSchedule]
  new({
    required this.id,
    required this.routineId,
    required this.recurrence,
    required this.status,
  });

  /// ID of this schedule
  final String id;

  /// ID of routine of this schedule
  final String routineId;

  /// Status of this schedule
  final ScheduleStatus status;

  /// List of recurrence rules based on RFC 5545
  final List<String> recurrence;

  /// [RecurrenceRule] instance based on [recurrence]
  late final RecurrenceRule rrule = RecurrenceRule.fromString(
    recurrence.join('\n'),
  );

  /// Whether this schedules includes [date] or not
  bool includes(DateTime date) {
    final target = date.copyWith(isUtc: true);
    return rrule
        .getInstances(
          start: target,
          after: target,
          includeAfter: true,
          before: target,
          includeBefore: true,
        )
        .isNotEmpty;
  }

  @override
  List<Object?> get props => [id, routineId, recurrence, status];
}
