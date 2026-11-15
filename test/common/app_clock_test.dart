import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';

import 'di_mock.dart';

void main() {
  final now = DateTime.timestamp();
  late Clock mockClock;
  late AppClock appClock;

  setUpAll(initializeMockDependencies);

  setUp(() {
    mockClock = di<Clock>();
    when(() => mockClock.now()).thenReturn(now);

    appClock = AppClock(mockClock);
  });

  tearDown(() {
    reset(mockClock);
  });

  group('AppClock', () {
    group('getCurrentDateTime', () {
      test('returns correct UTC DateTime from Clock', () {
        final result = appClock.getCurrentDateTime();

        expect(result, now);
        verify(mockClock.now).called(1);
      });
    });
  });
}
