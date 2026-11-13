import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/tracker/tracker.dart';

@LazySingleton(env: [Environment.test], as: TrackRoutineUseCase)
class MockTrackRoutineUseCase extends Mock implements TrackRoutineUseCase;

@LazySingleton(env: [Environment.test], as: WatchLatestRoutineTrackerUseCase)
class MockWatchLatestRoutineTrackerUseCase extends Mock
    implements WatchLatestRoutineTrackerUseCase;
