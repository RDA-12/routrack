import 'package:drift/drift.dart';
import 'package:routrack/common/database/tables/routine_table.dart';
import 'package:routrack/common/database/tables/table_mixin.dart';
import 'package:routrack/tracker/tracker.dart';

/// Drift table definition for [Tracker]
class TrackerTable extends Table with IDMixin, TimestampMixin {
  @override
  String? get tableName => 'trackers';

  /// ID of the routine this tracker track
  TextColumn get routineId =>
      text().references(RoutineTable, #id, onDelete: .cascade)();

  /// When the routine happened
  DateTimeColumn get date => dateTime()();
}
