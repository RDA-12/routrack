import 'package:equatable/equatable.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/schedule/domain/entities/entities.dart';

/// Params for repository to create new [Schedule]
final class CreateScheduleDBParams extends Equatable {
  /// Creates new [CreateScheduleDBParams]
  const new({required this.routineId, required this.recurrence});

  /// ID of the routine the new schedule for
  final String routineId;

  /// List of RRULE for the new schedule
  final List<String> recurrence;

  @override
  List<Object?> get props => [routineId, recurrence];
}

/// Repository to manage [Schedule]
abstract interface class ScheduleRepository extends Repository<Schedule>
    with SaveMixin<CreateScheduleDBParams, Schedule>;
