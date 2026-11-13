import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/tracker/tracker.dart';

@LazySingleton(env: [Environment.test], as: TrackerRepository)
class MockTrackerRepository extends Mock implements TrackerRepository;
