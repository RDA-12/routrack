import 'package:drift/drift.dart';
import 'package:routrack/common/database/converters/converters.dart';
import 'package:routrack/common/database/tables/routine_table.dart';
import 'package:routrack/common/database/tables/table_mixin.dart';
import 'package:routrack/schedule/schedule.dart';

/// Drift table definition for [Schedule]
class ScheduleTable extends Table with IDMixin, TimestampMixin {
  @override
  String? get tableName => 'schedules';

  /// ID of the routine of this schedule
  TextColumn get routineId =>
      text().references(RoutineTable, #id, onDelete: .cascade)();

  /// List of RRULE of this schedule
  TextColumn get recurrence => text().map(const StringListConverter())();
}
