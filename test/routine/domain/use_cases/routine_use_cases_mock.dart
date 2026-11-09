import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/routine/routine.dart';

@LazySingleton(env: [Environment.test], as: CreateRoutineUseCase)
class MockCreateRoutineUseCase extends Mock implements CreateRoutineUseCase;
