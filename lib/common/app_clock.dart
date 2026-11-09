import 'package:clock/clock.dart';
import 'package:injectable/injectable.dart';

/// Provides methods to get date time
@LazySingleton(env: [Environment.prod])
class AppClock {
  /// Creates new [AppClock]
  const new(this._clock);

  final Clock _clock;

  /// Returns current [DateTime] in UTC
  DateTime getCurrentDateTime() {
    return _clock.now().toUtc();
  }
}
