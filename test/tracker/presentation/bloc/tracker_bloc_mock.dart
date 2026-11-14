import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/tracker/tracker.dart';

@LazySingleton(env: [Environment.test], as: RoutineTrackerBloc)
class MockRoutineTrackerBloc extends Mock implements RoutineTrackerBloc;
