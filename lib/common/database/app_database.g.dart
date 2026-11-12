// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RoutineTableTable extends RoutineTable
    with TableInfo<$RoutineTableTable, RoutineTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 6,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, updatedAt, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routines';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $RoutineTableTable createAlias(String alias) {
    return $RoutineTableTable(attachedDatabase, alias);
  }
}

class RoutineTableData extends DataClass
    implements Insertable<RoutineTableData> {
  /// ID of this data
  final String id;

  /// When this routine created
  final DateTime createdAt;

  /// When the last time this routine updated
  final DateTime updatedAt;

  /// Name of this routine
  final String name;
  const RoutineTableData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['name'] = Variable<String>(name);
    return map;
  }

  RoutineTableCompanion toCompanion(bool nullToAbsent) {
    return RoutineTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: Value(name),
    );
  }

  factory RoutineTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineTableData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'name': serializer.toJson<String>(name),
    };
  }

  RoutineTableData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
  }) => RoutineTableData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    name: name ?? this.name,
  );
  RoutineTableData copyWithCompanion(RoutineTableCompanion data) {
    return RoutineTableData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineTableData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineTableData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.name == this.name);
}

class RoutineTableCompanion extends UpdateCompanion<RoutineTableData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> name;
  final Value<int> rowid;
  const RoutineTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutineTableCompanion.insert({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String name,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       name = Value(name);
  static Insertable<RoutineTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutineTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? name,
    Value<int>? rowid,
  }) {
    return RoutineTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineTableCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScheduleTableTable extends ScheduleTable
    with TableInfo<$ScheduleTableTable, ScheduleTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
    'routine_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES routines (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> recurrence =
      GeneratedColumn<String>(
        'recurrence',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<String>>($ScheduleTableTable.$converterrecurrence);
  @override
  late final GeneratedColumnWithTypeConverter<ScheduleStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ScheduleStatus>($ScheduleTableTable.$converterstatus);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    routineId,
    recurrence,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScheduleTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduleTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine_id'],
      )!,
      recurrence: $ScheduleTableTable.$converterrecurrence.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}recurrence'],
        )!,
      ),
      status: $ScheduleTableTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
    );
  }

  @override
  $ScheduleTableTable createAlias(String alias) {
    return $ScheduleTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<List<String>, String, Map<String, Object?>>
  $converterrecurrence = const StringListConverter();
  static JsonTypeConverter2<ScheduleStatus, String, String> $converterstatus =
      const EnumNameConverter<ScheduleStatus>(ScheduleStatus.values);
}

class ScheduleTableData extends DataClass
    implements Insertable<ScheduleTableData> {
  /// ID of this data
  final String id;

  /// When this routine created
  final DateTime createdAt;

  /// When the last time this routine updated
  final DateTime updatedAt;

  /// ID of the routine of this schedule
  final String routineId;

  /// List of RRULE of this schedule
  final List<String> recurrence;

  /// Status of this routine
  final ScheduleStatus status;
  const ScheduleTableData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.routineId,
    required this.recurrence,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['routine_id'] = Variable<String>(routineId);
    {
      map['recurrence'] = Variable<String>(
        $ScheduleTableTable.$converterrecurrence.toSql(recurrence),
      );
    }
    {
      map['status'] = Variable<String>(
        $ScheduleTableTable.$converterstatus.toSql(status),
      );
    }
    return map;
  }

  ScheduleTableCompanion toCompanion(bool nullToAbsent) {
    return ScheduleTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      routineId: Value(routineId),
      recurrence: Value(recurrence),
      status: Value(status),
    );
  }

  factory ScheduleTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleTableData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      routineId: serializer.fromJson<String>(json['routineId']),
      recurrence: $ScheduleTableTable.$converterrecurrence.fromJson(
        serializer.fromJson<Map<String, Object?>>(json['recurrence']),
      ),
      status: $ScheduleTableTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'routineId': serializer.toJson<String>(routineId),
      'recurrence': serializer.toJson<Map<String, Object?>>(
        $ScheduleTableTable.$converterrecurrence.toJson(recurrence),
      ),
      'status': serializer.toJson<String>(
        $ScheduleTableTable.$converterstatus.toJson(status),
      ),
    };
  }

  ScheduleTableData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? routineId,
    List<String>? recurrence,
    ScheduleStatus? status,
  }) => ScheduleTableData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    routineId: routineId ?? this.routineId,
    recurrence: recurrence ?? this.recurrence,
    status: status ?? this.status,
  );
  ScheduleTableData copyWithCompanion(ScheduleTableCompanion data) {
    return ScheduleTableData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      recurrence: data.recurrence.present
          ? data.recurrence.value
          : this.recurrence,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleTableData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('routineId: $routineId, ')
          ..write('recurrence: $recurrence, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, routineId, recurrence, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleTableData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.routineId == this.routineId &&
          other.recurrence == this.recurrence &&
          other.status == this.status);
}

class ScheduleTableCompanion extends UpdateCompanion<ScheduleTableData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> routineId;
  final Value<List<String>> recurrence;
  final Value<ScheduleStatus> status;
  final Value<int> rowid;
  const ScheduleTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.routineId = const Value.absent(),
    this.recurrence = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScheduleTableCompanion.insert({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String routineId,
    required List<String> recurrence,
    required ScheduleStatus status,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       routineId = Value(routineId),
       recurrence = Value(recurrence),
       status = Value(status);
  static Insertable<ScheduleTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? routineId,
    Expression<String>? recurrence,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (routineId != null) 'routine_id': routineId,
      if (recurrence != null) 'recurrence': recurrence,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScheduleTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? routineId,
    Value<List<String>>? recurrence,
    Value<ScheduleStatus>? status,
    Value<int>? rowid,
  }) {
    return ScheduleTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      routineId: routineId ?? this.routineId,
      recurrence: recurrence ?? this.recurrence,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<String>(routineId.value);
    }
    if (recurrence.present) {
      map['recurrence'] = Variable<String>(
        $ScheduleTableTable.$converterrecurrence.toSql(recurrence.value),
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $ScheduleTableTable.$converterstatus.toSql(status.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleTableCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('routineId: $routineId, ')
          ..write('recurrence: $recurrence, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RoutineTableTable routineTable = $RoutineTableTable(this);
  late final $ScheduleTableTable scheduleTable = $ScheduleTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    routineTable,
    scheduleTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'routines',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('schedules', kind: UpdateKind.delete)],
    ),
  ]);
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$RoutineTableTableCreateCompanionBuilder =
    RoutineTableCompanion Function({
      required String id,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String name,
      Value<int> rowid,
    });
typedef $$RoutineTableTableUpdateCompanionBuilder =
    RoutineTableCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> name,
      Value<int> rowid,
    });

final class $$RoutineTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $RoutineTableTable, RoutineTableData> {
  $$RoutineTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ScheduleTableTable, List<ScheduleTableData>>
  _scheduleTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.scheduleTable,
    aliasName: 'routines__id__schedules__routine_id',
  );

  $$ScheduleTableTableProcessedTableManager get scheduleTableRefs {
    final manager = $$ScheduleTableTableTableManager(
      $_db,
      $_db.scheduleTable,
    ).filter((f) => f.routineId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_scheduleTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoutineTableTableFilterComposer
    extends Composer<_$AppDatabase, $RoutineTableTable> {
  $$RoutineTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> scheduleTableRefs(
    Expression<bool> Function($$ScheduleTableTableFilterComposer f) f,
  ) {
    final $$ScheduleTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduleTable,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleTableTableFilterComposer(
            $db: $db,
            $table: $db.scheduleTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutineTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutineTableTable> {
  $$RoutineTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutineTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutineTableTable> {
  $$RoutineTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> scheduleTableRefs<T extends Object>(
    Expression<T> Function($$ScheduleTableTableAnnotationComposer a) f,
  ) {
    final $$ScheduleTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduleTable,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleTableTableAnnotationComposer(
            $db: $db,
            $table: $db.scheduleTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutineTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutineTableTable,
          RoutineTableData,
          $$RoutineTableTableFilterComposer,
          $$RoutineTableTableOrderingComposer,
          $$RoutineTableTableAnnotationComposer,
          $$RoutineTableTableCreateCompanionBuilder,
          $$RoutineTableTableUpdateCompanionBuilder,
          (RoutineTableData, $$RoutineTableTableReferences),
          RoutineTableData,
          PrefetchHooks Function({bool scheduleTableRefs})
        > {
  $$RoutineTableTableTableManager(_$AppDatabase db, $RoutineTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutineTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutineTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutineTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutineTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required DateTime updatedAt,
                required String name,
                Value<int> rowid = const Value.absent(),
              }) => RoutineTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                name: name,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoutineTableTable, RoutineTableData>(table),
                  $$RoutineTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({scheduleTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (scheduleTableRefs) db.scheduleTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (scheduleTableRefs)
                    await $_getPrefetchedDataByColumns<
                      RoutineTableData,
                      $RoutineTableTable,
                      ScheduleTableData,
                      $ScheduleTableTable
                    >(
                      currentTable: table,
                      referencedTable: $$RoutineTableTableReferences
                          ._scheduleTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RoutineTableTableReferences(
                            db,
                            table,
                            p0,
                          ).scheduleTableRefs,
                      currentColumn: 'id',
                      referencedColumn: 'routine_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RoutineTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutineTableTable,
      RoutineTableData,
      $$RoutineTableTableFilterComposer,
      $$RoutineTableTableOrderingComposer,
      $$RoutineTableTableAnnotationComposer,
      $$RoutineTableTableCreateCompanionBuilder,
      $$RoutineTableTableUpdateCompanionBuilder,
      (RoutineTableData, $$RoutineTableTableReferences),
      RoutineTableData,
      PrefetchHooks Function({bool scheduleTableRefs})
    >;
typedef $$ScheduleTableTableCreateCompanionBuilder =
    ScheduleTableCompanion Function({
      required String id,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String routineId,
      required List<String> recurrence,
      required ScheduleStatus status,
      Value<int> rowid,
    });
typedef $$ScheduleTableTableUpdateCompanionBuilder =
    ScheduleTableCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> routineId,
      Value<List<String>> recurrence,
      Value<ScheduleStatus> status,
      Value<int> rowid,
    });

final class $$ScheduleTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $ScheduleTableTable, ScheduleTableData> {
  $$ScheduleTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RoutineTableTable _routineIdTable(_$AppDatabase db) =>
      db.routineTable.createAlias('schedules__routine_id__routines__id');

  $$RoutineTableTableProcessedTableManager get routineId {
    final $_column = $_itemColumn<String>('routine_id')!;

    final manager = $$RoutineTableTableTableManager(
      $_db,
      $_db.routineTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_routineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ScheduleTableTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduleTableTable> {
  $$ScheduleTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get recurrence => $composableBuilder(
    column: $table.recurrence,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<ScheduleStatus, ScheduleStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$RoutineTableTableFilterComposer get routineId {
    final $$RoutineTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routineTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineTableTableFilterComposer(
            $db: $db,
            $table: $db.routineTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScheduleTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduleTableTable> {
  $$ScheduleTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrence => $composableBuilder(
    column: $table.recurrence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$RoutineTableTableOrderingComposer get routineId {
    final $$RoutineTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routineTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineTableTableOrderingComposer(
            $db: $db,
            $table: $db.routineTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScheduleTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduleTableTable> {
  $$ScheduleTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get recurrence =>
      $composableBuilder(
        column: $table.recurrence,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<ScheduleStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$RoutineTableTableAnnotationComposer get routineId {
    final $$RoutineTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routineTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineTableTableAnnotationComposer(
            $db: $db,
            $table: $db.routineTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScheduleTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScheduleTableTable,
          ScheduleTableData,
          $$ScheduleTableTableFilterComposer,
          $$ScheduleTableTableOrderingComposer,
          $$ScheduleTableTableAnnotationComposer,
          $$ScheduleTableTableCreateCompanionBuilder,
          $$ScheduleTableTableUpdateCompanionBuilder,
          (ScheduleTableData, $$ScheduleTableTableReferences),
          ScheduleTableData,
          PrefetchHooks Function({bool routineId})
        > {
  $$ScheduleTableTableTableManager(_$AppDatabase db, $ScheduleTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduleTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScheduleTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScheduleTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> routineId = const Value.absent(),
                Value<List<String>> recurrence = const Value.absent(),
                Value<ScheduleStatus> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScheduleTableCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                routineId: routineId,
                recurrence: recurrence,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required DateTime updatedAt,
                required String routineId,
                required List<String> recurrence,
                required ScheduleStatus status,
                Value<int> rowid = const Value.absent(),
              }) => ScheduleTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                routineId: routineId,
                recurrence: recurrence,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ScheduleTableTable, ScheduleTableData>(table),
                  $$ScheduleTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({routineId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (routineId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.routineId,
                        referencedTable: $$ScheduleTableTableReferences
                            ._routineIdTable(db),
                        referencedColumn: $$ScheduleTableTableReferences
                            ._routineIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ScheduleTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScheduleTableTable,
      ScheduleTableData,
      $$ScheduleTableTableFilterComposer,
      $$ScheduleTableTableOrderingComposer,
      $$ScheduleTableTableAnnotationComposer,
      $$ScheduleTableTableCreateCompanionBuilder,
      $$ScheduleTableTableUpdateCompanionBuilder,
      (ScheduleTableData, $$ScheduleTableTableReferences),
      ScheduleTableData,
      PrefetchHooks Function({bool routineId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RoutineTableTableTableManager get routineTable =>
      $$RoutineTableTableTableManager(_db, _db.routineTable);
  $$ScheduleTableTableTableManager get scheduleTable =>
      $$ScheduleTableTableTableManager(_db, _db.scheduleTable);
}
