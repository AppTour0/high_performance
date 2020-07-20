// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String name;
  final DateTime dateCreate;
  final DateTime dateModify;
  Task(
      {@required this.id,
      @required this.name,
      @required this.dateCreate,
      @required this.dateModify});
  factory Task.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Task(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      dateCreate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_create']),
      dateModify: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_modify']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || dateCreate != null) {
      map['date_create'] = Variable<DateTime>(dateCreate);
    }
    if (!nullToAbsent || dateModify != null) {
      map['date_modify'] = Variable<DateTime>(dateModify);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      dateCreate: dateCreate == null && nullToAbsent
          ? const Value.absent()
          : Value(dateCreate),
      dateModify: dateModify == null && nullToAbsent
          ? const Value.absent()
          : Value(dateModify),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      dateCreate: serializer.fromJson<DateTime>(json['dateCreate']),
      dateModify: serializer.fromJson<DateTime>(json['dateModify']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'dateCreate': serializer.toJson<DateTime>(dateCreate),
      'dateModify': serializer.toJson<DateTime>(dateModify),
    };
  }

  Task copyWith(
          {int id, String name, DateTime dateCreate, DateTime dateModify}) =>
      Task(
        id: id ?? this.id,
        name: name ?? this.name,
        dateCreate: dateCreate ?? this.dateCreate,
        dateModify: dateModify ?? this.dateModify,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dateCreate: $dateCreate, ')
          ..write('dateModify: $dateModify')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(dateCreate.hashCode, dateModify.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.name == this.name &&
          other.dateCreate == this.dateCreate &&
          other.dateModify == this.dateModify);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> dateCreate;
  final Value<DateTime> dateModify;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.dateCreate = const Value.absent(),
    this.dateModify = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required DateTime dateCreate,
    @required DateTime dateModify,
  })  : name = Value(name),
        dateCreate = Value(dateCreate),
        dateModify = Value(dateModify);
  static Insertable<Task> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<DateTime> dateCreate,
    Expression<DateTime> dateModify,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (dateCreate != null) 'date_create': dateCreate,
      if (dateModify != null) 'date_modify': dateModify,
    });
  }

  TasksCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<DateTime> dateCreate,
      Value<DateTime> dateModify}) {
    return TasksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      dateCreate: dateCreate ?? this.dateCreate,
      dateModify: dateModify ?? this.dateModify,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dateCreate.present) {
      map['date_create'] = Variable<DateTime>(dateCreate.value);
    }
    if (dateModify.present) {
      map['date_modify'] = Variable<DateTime>(dateModify.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dateCreate: $dateCreate, ')
          ..write('dateModify: $dateModify')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  final GeneratedDatabase _db;
  final String _alias;
  $TasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateCreateMeta = const VerificationMeta('dateCreate');
  GeneratedDateTimeColumn _dateCreate;
  @override
  GeneratedDateTimeColumn get dateCreate =>
      _dateCreate ??= _constructDateCreate();
  GeneratedDateTimeColumn _constructDateCreate() {
    return GeneratedDateTimeColumn(
      'date_create',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateModifyMeta = const VerificationMeta('dateModify');
  GeneratedDateTimeColumn _dateModify;
  @override
  GeneratedDateTimeColumn get dateModify =>
      _dateModify ??= _constructDateModify();
  GeneratedDateTimeColumn _constructDateModify() {
    return GeneratedDateTimeColumn(
      'date_modify',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, dateCreate, dateModify];
  @override
  $TasksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tasks';
  @override
  final String actualTableName = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('date_create')) {
      context.handle(
          _dateCreateMeta,
          dateCreate.isAcceptableOrUnknown(
              data['date_create'], _dateCreateMeta));
    } else if (isInserting) {
      context.missing(_dateCreateMeta);
    }
    if (data.containsKey('date_modify')) {
      context.handle(
          _dateModifyMeta,
          dateModify.isAcceptableOrUnknown(
              data['date_modify'], _dateModifyMeta));
    } else if (isInserting) {
      context.missing(_dateModifyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Task.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(_db, alias);
  }
}

class TasksListData extends DataClass implements Insertable<TasksListData> {
  final int id;
  final int idTask;
  final bool alarm;
  final bool mon;
  final bool tue;
  final bool wed;
  final bool thu;
  final bool fri;
  final bool sat;
  final bool sun;
  final DateTime dateCreate;
  final DateTime dateModify;
  TasksListData(
      {@required this.id,
      @required this.idTask,
      @required this.alarm,
      @required this.mon,
      @required this.tue,
      @required this.wed,
      @required this.thu,
      @required this.fri,
      @required this.sat,
      @required this.sun,
      @required this.dateCreate,
      @required this.dateModify});
  factory TasksListData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return TasksListData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      idTask:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_task']),
      alarm: boolType.mapFromDatabaseResponse(data['${effectivePrefix}alarm']),
      mon: boolType.mapFromDatabaseResponse(data['${effectivePrefix}mon']),
      tue: boolType.mapFromDatabaseResponse(data['${effectivePrefix}tue']),
      wed: boolType.mapFromDatabaseResponse(data['${effectivePrefix}wed']),
      thu: boolType.mapFromDatabaseResponse(data['${effectivePrefix}thu']),
      fri: boolType.mapFromDatabaseResponse(data['${effectivePrefix}fri']),
      sat: boolType.mapFromDatabaseResponse(data['${effectivePrefix}sat']),
      sun: boolType.mapFromDatabaseResponse(data['${effectivePrefix}sun']),
      dateCreate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_create']),
      dateModify: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_modify']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || idTask != null) {
      map['id_task'] = Variable<int>(idTask);
    }
    if (!nullToAbsent || alarm != null) {
      map['alarm'] = Variable<bool>(alarm);
    }
    if (!nullToAbsent || mon != null) {
      map['mon'] = Variable<bool>(mon);
    }
    if (!nullToAbsent || tue != null) {
      map['tue'] = Variable<bool>(tue);
    }
    if (!nullToAbsent || wed != null) {
      map['wed'] = Variable<bool>(wed);
    }
    if (!nullToAbsent || thu != null) {
      map['thu'] = Variable<bool>(thu);
    }
    if (!nullToAbsent || fri != null) {
      map['fri'] = Variable<bool>(fri);
    }
    if (!nullToAbsent || sat != null) {
      map['sat'] = Variable<bool>(sat);
    }
    if (!nullToAbsent || sun != null) {
      map['sun'] = Variable<bool>(sun);
    }
    if (!nullToAbsent || dateCreate != null) {
      map['date_create'] = Variable<DateTime>(dateCreate);
    }
    if (!nullToAbsent || dateModify != null) {
      map['date_modify'] = Variable<DateTime>(dateModify);
    }
    return map;
  }

  TasksListCompanion toCompanion(bool nullToAbsent) {
    return TasksListCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idTask:
          idTask == null && nullToAbsent ? const Value.absent() : Value(idTask),
      alarm:
          alarm == null && nullToAbsent ? const Value.absent() : Value(alarm),
      mon: mon == null && nullToAbsent ? const Value.absent() : Value(mon),
      tue: tue == null && nullToAbsent ? const Value.absent() : Value(tue),
      wed: wed == null && nullToAbsent ? const Value.absent() : Value(wed),
      thu: thu == null && nullToAbsent ? const Value.absent() : Value(thu),
      fri: fri == null && nullToAbsent ? const Value.absent() : Value(fri),
      sat: sat == null && nullToAbsent ? const Value.absent() : Value(sat),
      sun: sun == null && nullToAbsent ? const Value.absent() : Value(sun),
      dateCreate: dateCreate == null && nullToAbsent
          ? const Value.absent()
          : Value(dateCreate),
      dateModify: dateModify == null && nullToAbsent
          ? const Value.absent()
          : Value(dateModify),
    );
  }

  factory TasksListData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TasksListData(
      id: serializer.fromJson<int>(json['id']),
      idTask: serializer.fromJson<int>(json['idTask']),
      alarm: serializer.fromJson<bool>(json['alarm']),
      mon: serializer.fromJson<bool>(json['mon']),
      tue: serializer.fromJson<bool>(json['tue']),
      wed: serializer.fromJson<bool>(json['wed']),
      thu: serializer.fromJson<bool>(json['thu']),
      fri: serializer.fromJson<bool>(json['fri']),
      sat: serializer.fromJson<bool>(json['sat']),
      sun: serializer.fromJson<bool>(json['sun']),
      dateCreate: serializer.fromJson<DateTime>(json['dateCreate']),
      dateModify: serializer.fromJson<DateTime>(json['dateModify']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idTask': serializer.toJson<int>(idTask),
      'alarm': serializer.toJson<bool>(alarm),
      'mon': serializer.toJson<bool>(mon),
      'tue': serializer.toJson<bool>(tue),
      'wed': serializer.toJson<bool>(wed),
      'thu': serializer.toJson<bool>(thu),
      'fri': serializer.toJson<bool>(fri),
      'sat': serializer.toJson<bool>(sat),
      'sun': serializer.toJson<bool>(sun),
      'dateCreate': serializer.toJson<DateTime>(dateCreate),
      'dateModify': serializer.toJson<DateTime>(dateModify),
    };
  }

  TasksListData copyWith(
          {int id,
          int idTask,
          bool alarm,
          bool mon,
          bool tue,
          bool wed,
          bool thu,
          bool fri,
          bool sat,
          bool sun,
          DateTime dateCreate,
          DateTime dateModify}) =>
      TasksListData(
        id: id ?? this.id,
        idTask: idTask ?? this.idTask,
        alarm: alarm ?? this.alarm,
        mon: mon ?? this.mon,
        tue: tue ?? this.tue,
        wed: wed ?? this.wed,
        thu: thu ?? this.thu,
        fri: fri ?? this.fri,
        sat: sat ?? this.sat,
        sun: sun ?? this.sun,
        dateCreate: dateCreate ?? this.dateCreate,
        dateModify: dateModify ?? this.dateModify,
      );
  @override
  String toString() {
    return (StringBuffer('TasksListData(')
          ..write('id: $id, ')
          ..write('idTask: $idTask, ')
          ..write('alarm: $alarm, ')
          ..write('mon: $mon, ')
          ..write('tue: $tue, ')
          ..write('wed: $wed, ')
          ..write('thu: $thu, ')
          ..write('fri: $fri, ')
          ..write('sat: $sat, ')
          ..write('sun: $sun, ')
          ..write('dateCreate: $dateCreate, ')
          ..write('dateModify: $dateModify')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          idTask.hashCode,
          $mrjc(
              alarm.hashCode,
              $mrjc(
                  mon.hashCode,
                  $mrjc(
                      tue.hashCode,
                      $mrjc(
                          wed.hashCode,
                          $mrjc(
                              thu.hashCode,
                              $mrjc(
                                  fri.hashCode,
                                  $mrjc(
                                      sat.hashCode,
                                      $mrjc(
                                          sun.hashCode,
                                          $mrjc(dateCreate.hashCode,
                                              dateModify.hashCode))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TasksListData &&
          other.id == this.id &&
          other.idTask == this.idTask &&
          other.alarm == this.alarm &&
          other.mon == this.mon &&
          other.tue == this.tue &&
          other.wed == this.wed &&
          other.thu == this.thu &&
          other.fri == this.fri &&
          other.sat == this.sat &&
          other.sun == this.sun &&
          other.dateCreate == this.dateCreate &&
          other.dateModify == this.dateModify);
}

class TasksListCompanion extends UpdateCompanion<TasksListData> {
  final Value<int> id;
  final Value<int> idTask;
  final Value<bool> alarm;
  final Value<bool> mon;
  final Value<bool> tue;
  final Value<bool> wed;
  final Value<bool> thu;
  final Value<bool> fri;
  final Value<bool> sat;
  final Value<bool> sun;
  final Value<DateTime> dateCreate;
  final Value<DateTime> dateModify;
  const TasksListCompanion({
    this.id = const Value.absent(),
    this.idTask = const Value.absent(),
    this.alarm = const Value.absent(),
    this.mon = const Value.absent(),
    this.tue = const Value.absent(),
    this.wed = const Value.absent(),
    this.thu = const Value.absent(),
    this.fri = const Value.absent(),
    this.sat = const Value.absent(),
    this.sun = const Value.absent(),
    this.dateCreate = const Value.absent(),
    this.dateModify = const Value.absent(),
  });
  TasksListCompanion.insert({
    this.id = const Value.absent(),
    @required int idTask,
    this.alarm = const Value.absent(),
    this.mon = const Value.absent(),
    this.tue = const Value.absent(),
    this.wed = const Value.absent(),
    this.thu = const Value.absent(),
    this.fri = const Value.absent(),
    this.sat = const Value.absent(),
    this.sun = const Value.absent(),
    @required DateTime dateCreate,
    @required DateTime dateModify,
  })  : idTask = Value(idTask),
        dateCreate = Value(dateCreate),
        dateModify = Value(dateModify);
  static Insertable<TasksListData> custom({
    Expression<int> id,
    Expression<int> idTask,
    Expression<bool> alarm,
    Expression<bool> mon,
    Expression<bool> tue,
    Expression<bool> wed,
    Expression<bool> thu,
    Expression<bool> fri,
    Expression<bool> sat,
    Expression<bool> sun,
    Expression<DateTime> dateCreate,
    Expression<DateTime> dateModify,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idTask != null) 'id_task': idTask,
      if (alarm != null) 'alarm': alarm,
      if (mon != null) 'mon': mon,
      if (tue != null) 'tue': tue,
      if (wed != null) 'wed': wed,
      if (thu != null) 'thu': thu,
      if (fri != null) 'fri': fri,
      if (sat != null) 'sat': sat,
      if (sun != null) 'sun': sun,
      if (dateCreate != null) 'date_create': dateCreate,
      if (dateModify != null) 'date_modify': dateModify,
    });
  }

  TasksListCompanion copyWith(
      {Value<int> id,
      Value<int> idTask,
      Value<bool> alarm,
      Value<bool> mon,
      Value<bool> tue,
      Value<bool> wed,
      Value<bool> thu,
      Value<bool> fri,
      Value<bool> sat,
      Value<bool> sun,
      Value<DateTime> dateCreate,
      Value<DateTime> dateModify}) {
    return TasksListCompanion(
      id: id ?? this.id,
      idTask: idTask ?? this.idTask,
      alarm: alarm ?? this.alarm,
      mon: mon ?? this.mon,
      tue: tue ?? this.tue,
      wed: wed ?? this.wed,
      thu: thu ?? this.thu,
      fri: fri ?? this.fri,
      sat: sat ?? this.sat,
      sun: sun ?? this.sun,
      dateCreate: dateCreate ?? this.dateCreate,
      dateModify: dateModify ?? this.dateModify,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idTask.present) {
      map['id_task'] = Variable<int>(idTask.value);
    }
    if (alarm.present) {
      map['alarm'] = Variable<bool>(alarm.value);
    }
    if (mon.present) {
      map['mon'] = Variable<bool>(mon.value);
    }
    if (tue.present) {
      map['tue'] = Variable<bool>(tue.value);
    }
    if (wed.present) {
      map['wed'] = Variable<bool>(wed.value);
    }
    if (thu.present) {
      map['thu'] = Variable<bool>(thu.value);
    }
    if (fri.present) {
      map['fri'] = Variable<bool>(fri.value);
    }
    if (sat.present) {
      map['sat'] = Variable<bool>(sat.value);
    }
    if (sun.present) {
      map['sun'] = Variable<bool>(sun.value);
    }
    if (dateCreate.present) {
      map['date_create'] = Variable<DateTime>(dateCreate.value);
    }
    if (dateModify.present) {
      map['date_modify'] = Variable<DateTime>(dateModify.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksListCompanion(')
          ..write('id: $id, ')
          ..write('idTask: $idTask, ')
          ..write('alarm: $alarm, ')
          ..write('mon: $mon, ')
          ..write('tue: $tue, ')
          ..write('wed: $wed, ')
          ..write('thu: $thu, ')
          ..write('fri: $fri, ')
          ..write('sat: $sat, ')
          ..write('sun: $sun, ')
          ..write('dateCreate: $dateCreate, ')
          ..write('dateModify: $dateModify')
          ..write(')'))
        .toString();
  }
}

class $TasksListTable extends TasksList
    with TableInfo<$TasksListTable, TasksListData> {
  final GeneratedDatabase _db;
  final String _alias;
  $TasksListTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _idTaskMeta = const VerificationMeta('idTask');
  GeneratedIntColumn _idTask;
  @override
  GeneratedIntColumn get idTask => _idTask ??= _constructIdTask();
  GeneratedIntColumn _constructIdTask() {
    return GeneratedIntColumn('id_task', $tableName, false,
        $customConstraints: 'REFERENCES tasks(id)');
  }

  final VerificationMeta _alarmMeta = const VerificationMeta('alarm');
  GeneratedBoolColumn _alarm;
  @override
  GeneratedBoolColumn get alarm => _alarm ??= _constructAlarm();
  GeneratedBoolColumn _constructAlarm() {
    return GeneratedBoolColumn('alarm', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _monMeta = const VerificationMeta('mon');
  GeneratedBoolColumn _mon;
  @override
  GeneratedBoolColumn get mon => _mon ??= _constructMon();
  GeneratedBoolColumn _constructMon() {
    return GeneratedBoolColumn('mon', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _tueMeta = const VerificationMeta('tue');
  GeneratedBoolColumn _tue;
  @override
  GeneratedBoolColumn get tue => _tue ??= _constructTue();
  GeneratedBoolColumn _constructTue() {
    return GeneratedBoolColumn('tue', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _wedMeta = const VerificationMeta('wed');
  GeneratedBoolColumn _wed;
  @override
  GeneratedBoolColumn get wed => _wed ??= _constructWed();
  GeneratedBoolColumn _constructWed() {
    return GeneratedBoolColumn('wed', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _thuMeta = const VerificationMeta('thu');
  GeneratedBoolColumn _thu;
  @override
  GeneratedBoolColumn get thu => _thu ??= _constructThu();
  GeneratedBoolColumn _constructThu() {
    return GeneratedBoolColumn('thu', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _friMeta = const VerificationMeta('fri');
  GeneratedBoolColumn _fri;
  @override
  GeneratedBoolColumn get fri => _fri ??= _constructFri();
  GeneratedBoolColumn _constructFri() {
    return GeneratedBoolColumn('fri', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _satMeta = const VerificationMeta('sat');
  GeneratedBoolColumn _sat;
  @override
  GeneratedBoolColumn get sat => _sat ??= _constructSat();
  GeneratedBoolColumn _constructSat() {
    return GeneratedBoolColumn('sat', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _sunMeta = const VerificationMeta('sun');
  GeneratedBoolColumn _sun;
  @override
  GeneratedBoolColumn get sun => _sun ??= _constructSun();
  GeneratedBoolColumn _constructSun() {
    return GeneratedBoolColumn('sun', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _dateCreateMeta = const VerificationMeta('dateCreate');
  GeneratedDateTimeColumn _dateCreate;
  @override
  GeneratedDateTimeColumn get dateCreate =>
      _dateCreate ??= _constructDateCreate();
  GeneratedDateTimeColumn _constructDateCreate() {
    return GeneratedDateTimeColumn(
      'date_create',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateModifyMeta = const VerificationMeta('dateModify');
  GeneratedDateTimeColumn _dateModify;
  @override
  GeneratedDateTimeColumn get dateModify =>
      _dateModify ??= _constructDateModify();
  GeneratedDateTimeColumn _constructDateModify() {
    return GeneratedDateTimeColumn(
      'date_modify',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        idTask,
        alarm,
        mon,
        tue,
        wed,
        thu,
        fri,
        sat,
        sun,
        dateCreate,
        dateModify
      ];
  @override
  $TasksListTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tasks_list';
  @override
  final String actualTableName = 'tasks_list';
  @override
  VerificationContext validateIntegrity(Insertable<TasksListData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('id_task')) {
      context.handle(_idTaskMeta,
          idTask.isAcceptableOrUnknown(data['id_task'], _idTaskMeta));
    } else if (isInserting) {
      context.missing(_idTaskMeta);
    }
    if (data.containsKey('alarm')) {
      context.handle(
          _alarmMeta, alarm.isAcceptableOrUnknown(data['alarm'], _alarmMeta));
    }
    if (data.containsKey('mon')) {
      context.handle(
          _monMeta, mon.isAcceptableOrUnknown(data['mon'], _monMeta));
    }
    if (data.containsKey('tue')) {
      context.handle(
          _tueMeta, tue.isAcceptableOrUnknown(data['tue'], _tueMeta));
    }
    if (data.containsKey('wed')) {
      context.handle(
          _wedMeta, wed.isAcceptableOrUnknown(data['wed'], _wedMeta));
    }
    if (data.containsKey('thu')) {
      context.handle(
          _thuMeta, thu.isAcceptableOrUnknown(data['thu'], _thuMeta));
    }
    if (data.containsKey('fri')) {
      context.handle(
          _friMeta, fri.isAcceptableOrUnknown(data['fri'], _friMeta));
    }
    if (data.containsKey('sat')) {
      context.handle(
          _satMeta, sat.isAcceptableOrUnknown(data['sat'], _satMeta));
    }
    if (data.containsKey('sun')) {
      context.handle(
          _sunMeta, sun.isAcceptableOrUnknown(data['sun'], _sunMeta));
    }
    if (data.containsKey('date_create')) {
      context.handle(
          _dateCreateMeta,
          dateCreate.isAcceptableOrUnknown(
              data['date_create'], _dateCreateMeta));
    } else if (isInserting) {
      context.missing(_dateCreateMeta);
    }
    if (data.containsKey('date_modify')) {
      context.handle(
          _dateModifyMeta,
          dateModify.isAcceptableOrUnknown(
              data['date_modify'], _dateModifyMeta));
    } else if (isInserting) {
      context.missing(_dateModifyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TasksListData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TasksListData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TasksListTable createAlias(String alias) {
    return $TasksListTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TasksTable _tasks;
  $TasksTable get tasks => _tasks ??= $TasksTable(this);
  $TasksListTable _tasksList;
  $TasksListTable get tasksList => _tasksList ??= $TasksListTable(this);
  TasksRepository _tasksRepository;
  TasksRepository get tasksRepository =>
      _tasksRepository ??= TasksRepository(this as Database);
  TasksListRepository _tasksListRepository;
  TasksListRepository get tasksListRepository =>
      _tasksListRepository ??= TasksListRepository(this as Database);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tasks, tasksList];
}
