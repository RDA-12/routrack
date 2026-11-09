import 'package:clock/clock.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

/// List of external modules that needed to be registered
@module
abstract class ExternalModule {
  /// [Uuid] object
  @LazySingleton(env: [Environment.prod])
  Uuid get uuid => const Uuid();

  /// [Clock] object
  @LazySingleton(env: [Environment.prod])
  Clock get appClock => const Clock(DateTime.now);
}
