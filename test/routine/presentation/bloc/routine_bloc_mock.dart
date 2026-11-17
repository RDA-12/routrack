import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/routine/routine.dart';

@LazySingleton(env: [Environment.test], as: RoutineMutationBloc)
class MockRoutineMutationBloc extends Mock implements RoutineMutationBloc;

@LazySingleton(env: [Environment.test], as: RoutinesBloc)
class MockRoutinesBloc extends Mock implements RoutinesBloc;

@LazySingleton(env: [Environment.test], as: SingleRoutineBloc)
class MockSingleRoutineBloc extends Mock implements SingleRoutineBloc;
