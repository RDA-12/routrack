import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:routrack/common/database/database.dart';

@module
abstract class AppDatabaseMockModule {
  @LazySingleton(env: [Environment.test])
  AppDatabase get database => AppDatabase.forTesting(
    DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ),
  );
}
