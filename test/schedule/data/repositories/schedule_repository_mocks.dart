import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/schedule/schedule.dart';

@LazySingleton(env: [Environment.test], as: ScheduleRepository)
class MockScheduleRepository extends Mock implements ScheduleRepository;
