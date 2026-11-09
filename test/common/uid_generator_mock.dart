import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/uid_generator.dart';

@LazySingleton(env: [Environment.test], as: UidGenerator)
class MockUidGenerator extends Mock implements UidGenerator;
