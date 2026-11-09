import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/common/app_clock.dart';

@LazySingleton(env: [Environment.test], as: AppClock)
class MockAppClock extends Mock implements AppClock;
