import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:routrack/common/database/tables/tables.dart';

part 'app_database.g.dart';

@LazySingleton(env: [Environment.prod])
/// Main database for the app
@DriftDatabase(tables: [RoutineTable])
class AppDatabase extends _$AppDatabase {
  /// Creates new [AppDatabase]
  factory() => AppDatabase._internal(_openConnection());

  /// Creates new [AppDatabase] for testing
  @visibleForTesting
  factory forTesting(QueryExecutor e) => AppDatabase._internal(e);

  new _internal(super.e);

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'routrack_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
