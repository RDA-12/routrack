import 'package:equatable/equatable.dart';
import 'package:routrack/common/common.dart';
import 'package:routrack/routine/domain/entities/entities.dart';

/// Params for DB to create Routine
final class CreateRoutineDBParams extends Equatable {
  /// Creates new [CreateRoutineDBParams]
  const new({required this.name, required this.recurrence});

  /// Name of the new routine
  final String name;

  /// List of RRULE for the new routine schedule
  final List<String> recurrence;

  @override
  List<Object?> get props => [name, recurrence];
}

/// Repository to manage [Routine] data
abstract interface class RoutineRepository extends Repository<Routine>
    with
        SaveMixin<CreateRoutineDBParams, Routine>,
        WatchMixin<Routine>,
        GetByIdMixin<Routine>,
        WatchByIdMixin<Routine>;
