import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/app_result.dart';
import 'package:routrack/schedule/domain/entities/entities.dart';
import 'package:routrack/schedule/domain/repositories/repositories.dart';

/// Weekday
enum WeekDay(final String rrule) {
  /// Monday
  mon('MO'),

  /// Tuesday
  tue('TU'),

  /// Wednesday
  wed('WE'),

  /// Thursday
  thu('TH'),

  /// Friday
  fri('FR'),

  /// Saturday
  sat('SA'),

  /// Sunday
  sun('SU'),
}

/// Params for [CreateScheduleUseCase]
final class CreateScheduleParams extends Equatable {
  /// Creates new [CreateScheduleParams]
  const new({required this.routineId, required this.days});

  /// ID of routine this schedule for
  final String routineId;

  /// List of days the routine occurred
  final Set<WeekDay> days;

  @override
  List<Object?> get props => [routineId, days];
}

extension _RRULEExt on CreateScheduleParams {
  String get rrule {
    return 'RRULE:FREQ=DAILY;BYDAY=${days.map((it) => it.rrule).join(',')}';
  }
}

/// Use case to create a schedule for a routine
@LazySingleton(env: [Environment.prod])
class CreateScheduleUseCase
    implements FutureUseCase<CreateScheduleParams, Schedule> {
  /// Creates new [CreateScheduleUseCase]
  const new({required this._scheduleRepository});

  final ScheduleRepository _scheduleRepository;

  /// Starts creating new [Schedule]
  @override
  Future<AppResult<Schedule>> call(CreateScheduleParams params) {
    return _scheduleRepository.save(
      CreateScheduleDBParams(
        routineId: params.routineId,
        recurrence: [params.rrule],
      ),
    );
  }
}
