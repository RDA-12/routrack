import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/routine/routine.dart';

@LazySingleton(env: [Environment.test], as: RoutineRepository)
class MockRoutineRepository extends Mock implements RoutineRepository;
