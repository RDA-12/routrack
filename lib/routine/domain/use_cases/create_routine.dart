import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/core/app_result.dart';
import 'package:routrack/routine/domain/entities/entities.dart';
import 'package:routrack/routine/domain/repositories/repositories.dart';

/// Params for [CreateRoutineUseCase]
final class CreateRoutineParams extends Equatable {
  /// Creates new [CreateRoutineParams]
  const new({required this.name, required this.days});

  /// Name for the new Routine
  final String name;

  /// List of days the routine occurred
  final Set<WeekDay> days;

  @override
  List<Object?> get props => [name, days];
}

extension _RRULEExt on CreateRoutineParams {
  String get rrule {
    return 'RRULE:FREQ=DAILY;BYDAY=${days.map((it) => it.rrule).join(',')}';
  }
}

/// Use case to create new [Routine]
@LazySingleton(env: [Environment.prod])
class CreateRoutineUseCase
    implements FutureUseCase<CreateRoutineParams, Routine> {
  /// Creates new [CreateRoutineUseCase]
  const new({required this._routineRepository});

  final RoutineRepository _routineRepository;

  /// Starts creating new [Routine] based on [params]
  @override
  Future<AppResult<Routine>> call(CreateRoutineParams params) {
    return _routineRepository.save(
      CreateRoutineDBParams(name: params.name, recurrence: [params.rrule]),
    );
  }
}
