import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:routrack/common/base_use_case.dart';
import 'package:routrack/core/app_result.dart';
import 'package:routrack/routine/domain/entities/entities.dart';
import 'package:routrack/routine/domain/repositories/repositories.dart';

/// Params for [CreateRoutineUseCase]
final class CreateRoutineParams extends Equatable {
  /// Creates new [CreateRoutineParams]
  const new({required this.name});

  /// Name for the new Routine
  final String name;

  @override
  List<Object?> get props => [name];
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
    return _routineRepository.save(params);
  }
}
