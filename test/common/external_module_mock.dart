import 'package:clock/clock.dart';
import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

class MockUuid extends Mock implements Uuid;
class MockClock extends Mock implements Clock;

/// List of external modules that needed to be registered
@module
abstract class ExternalModule {
  /// [Uuid] object
  @LazySingleton(env: [Environment.test])
  Uuid get uuid => MockUuid();

  /// [Clock] object
  @LazySingleton(env: [Environment.test])
  Clock get appClock => MockClock();
}
