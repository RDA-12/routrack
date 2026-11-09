import 'package:drift/drift.dart';
import 'package:routrack/common/database/tables/table_mixin.dart';
import 'package:routrack/routine/routine.dart';

/// Drift table definition for [Routine]
class RoutineTable extends Table with IDMixin, TimestampMixin {
  @override
  String? get tableName => 'routines';

  /// Name of this routine
  TextColumn get name => text().withLength(min: 6, max: 32)();
}
