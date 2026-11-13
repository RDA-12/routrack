import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/routine/routine.dart';

@LazySingleton(env: [Environment.test], as: CreateRoutineUseCase)
class MockCreateRoutineUseCase extends Mock implements CreateRoutineUseCase;

@LazySingleton(env: [Environment.test], as: WatchRoutines)
class MockWatchRoutines extends Mock implements WatchRoutines;

@LazySingleton(env: [Environment.test], as: GetRoutineByIdUseCase)
class MockGetRoutineByIdUseCase extends Mock implements GetRoutineByIdUseCase;
