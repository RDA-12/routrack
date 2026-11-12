import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routrack/home/home.dart';

@LazySingleton(env: [Environment.test], as: HomeBloc)
class MockHomeBloc extends Mock implements HomeBloc;
