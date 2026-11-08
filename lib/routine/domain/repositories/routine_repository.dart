import 'package:routrack/common/common.dart';
import 'package:routrack/routine/domain/entities/entities.dart';
import 'package:routrack/routine/domain/use_cases/use_cases.dart';

/// Repository to manage [Routine] data
abstract interface class RoutineRepository extends Repository<Routine>
    with SaveMixin<CreateRoutineParams, Routine>;
