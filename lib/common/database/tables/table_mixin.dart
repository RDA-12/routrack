import 'package:drift/drift.dart';

/// Add [id] column and set it to primaryKey
mixin IDMixin on Table {
  /// ID of this data
  TextColumn get id => text()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

/// Add [createdAt] and [updatedAt] column
mixin TimestampMixin on Table {
  /// When this routine created
  DateTimeColumn get createdAt => dateTime()();

  /// When the last time this routine updated
  DateTimeColumn get updatedAt => dateTime()();
}
