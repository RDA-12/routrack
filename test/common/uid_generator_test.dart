import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/common.dart';
import 'package:uuid/uuid.dart';

class MockUuid extends Mock implements Uuid;

void main() {
  const uid = 'uid';
  late Uuid uuid;
  late UidGenerator uidGenerator;

  setUp(() {
    uuid = MockUuid();
    when(() => uuid.v4()).thenReturn('uid');

    uidGenerator = UidGenerator(uuid);
  });

  tearDown(() {
    reset(uuid);
  });

  group('UidGenerator', () {
    group('generateUid', () {
      test('returns uuid v4 String', () {
        final result = uidGenerator.generateUid();

        expect(result, uid);
        verify(() => uuid.v4()).called(1);
      });
    });
  });
}
