import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:routrack/common/common.dart';

void main() {
  late AppClock appClock;

  setUp(() {
    appClock = AppClock(clock);
  });

  group('AppClock', () {
    group('getCurrentDateTime', () {
      test('returns correct UTC DateTime', () {
        final now = DateTime.now();
        withClock(Clock.fixed(now), () {
          final result = appClock.getCurrentDateTime();

          expect(result, now.toUtc());
        });
      });
    });
  });
}
