// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String name;
  final bool alarm;
  final bool mon;
  final bool tue;
  final bool wed;
  final bool thu;
  final bool fri;
  final bool sat;
  final bool sun;
  final bool repeat;
  final String message;
  final DateTime dateTimeNotification;
  final DateTime dateCreate;
  final DateTime dateModify;
  final String color;
  Task(
      {@required this.id,
      @required this.name,
      @required this.alarm,
      @required this.mon,
      @required this.tue,
      @required this.wed,
      @required this.thu,
      @required this.fri,
      @required this.sat,
      @required this.sun,
      @required this.repeat,
      @required this.message,
      @required this.dateTimeNotification,
      @required this.dateCreate,
      @required this.dateModify,
      @required this.color});
  factory Task.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Task(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      alarm: boolType.mapFromDatabaseResponse(data['${effectivePrefix}alarm']),
      mon: boolType.mapFromDatabaseResponse(data['${effectivePrefix}mon']),
      tue: boolType.mapFromDatabaseResponse(data['${effectivePrefix}tue']),
      wed: boolType.mapFromDatabaseResponse(data['${effectivePrefix}wed']),
      thu: boolType.mapFromDatabaseResponse(data['${effectivePrefix}thu']),
      fri: boolType.mapFromDatabaseResponse(data['${effectivePrefix}fri']),
      sat: boolType.mapFromDatabaseResponse(data['${effectivePrefix}sat']),
      sun: boolType.mapFromDatabaseResponse(data['${effectivePrefix}sun']),
      repeat:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}repeat']),
      message:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}message']),
      dateTimeNotification: dateTimeType.mapFromDatabaseResponse(
          data['${effectivePrefix}date_time_notification']),
      dateCreate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_create']),
      dateModify: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_modify']),
      color:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
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
    if (!nullToAbsent || repeat != null) {
      map['repeat'] = Variable<bool>(repeat);
    }
    if (!nullToAbsent || message != null) {
      map['message'] = Variable<String>(message);
    }
    if (!nullToAbsent || dateTimeNotification != null) {
      map['date_time_notification'] = Variable<DateTime>(dateTimeNotification);
    }
    if (!nullToAbsent || dateCreate != null) {
      map['date_create'] = Variable<DateTime>(dateCreate);
    }
    if (!nullToAbsent || dateModify != null) {
      map['date_modify'] = Variable<DateTime>(dateModify);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      alarm:
          alarm == null && nullToAbsent ? const Value.absent() : Value(alarm),
      mon: mon == null && nullToAbsent ? const Value.absent() : Value(mon),
      tue: tue == null && nullToAbsent ? const Value.absent() : Value(tue),
      wed: wed == null && nullToAbsent ? const Value.absent() : Value(wed),
      thu: thu == null && nullToAbsent ? const Value.absent() : Value(thu),
      fri: fri == null && nullToAbsent ? const Value.absent() : Value(fri),
      sat: sat == null && nullToAbsent ? const Value.absent() : Value(sat),
      sun: sun == null && nullToAbsent ? const Value.absent() : Value(sun),
      repeat:
          repeat == null && nullToAbsent ? const Value.absent() : Value(repeat),
      message: message == null && nullToAbsent
          ? const Value.absent()
          : Value(message),
      dateTimeNotification: dateTimeNotification == null && nullToAbsent
          ? const Value.absent()
          : Value(dateTimeNotification),
      dateCreate: dateCreate == null && nullToAbsent
          ? const Value.absent()
          : Value(dateCreate),
      dateModify: dateModify == null && nullToAbsent
          ? const Value.absent()
          : Value(dateModify),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      alarm: serializer.fromJson<bool>(json['alarm']),
      mon: serializer.fromJson<bool>(json['mon']),
      tue: serializer.fromJson<bool>(json['tue']),
      wed: serializer.fromJson<bool>(json['wed']),
      thu: serializer.fromJson<bool>(json['thu']),
      fri: serializer.fromJson<bool>(json['fri']),
      sat: serializer.fromJson<bool>(json['sat']),
      sun: serializer.fromJson<bool>(json['sun']),
      repeat: serializer.fromJson<bool>(json['repeat']),
      message: serializer.fromJson<String>(json['message']),
      dateTimeNotification:
          serializer.fromJson<DateTime>(json['dateTimeNotification']),
      dateCreate: serializer.fromJson<DateTime>(json['dateCreate']),
      dateModify: serializer.fromJson<DateTime>(json['dateModify']),
      color: serializer.fromJson<String>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'alarm': serializer.toJson<bool>(alarm),
      'mon': serializer.toJson<bool>(mon),
      'tue': serializer.toJson<bool>(tue),
      'wed': serializer.toJson<bool>(wed),
      'thu': serializer.toJson<bool>(thu),
      'fri': serializer.toJson<bool>(fri),
      'sat': serializer.toJson<bool>(sat),
      'sun': serializer.toJson<bool>(sun),
      'repeat': serializer.toJson<bool>(repeat),
      'message': serializer.toJson<String>(message),
      'dateTimeNotification': serializer.toJson<DateTime>(dateTimeNotification),
      'dateCreate': serializer.toJson<DateTime>(dateCreate),
      'dateModify': serializer.toJson<DateTime>(dateModify),
      'color': serializer.toJson<String>(color),
    };
  }

  Task copyWith(
          {int id,
          String name,
          bool alarm,
          bool mon,
          bool tue,
          bool wed,
          bool thu,
          bool fri,
          bool sat,
          bool sun,
          bool repeat,
          String message,
          DateTime dateTimeNotification,
          DateTime dateCreate,
          DateTime dateModify,
          String color}) =>
      Task(
        id: id ?? this.id,
        name: name ?? this.name,
        alarm: alarm ?? this.alarm,
        mon: mon ?? this.mon,
        tue: tue ?? this.tue,
        wed: wed ?? this.wed,
        thu: thu ?? this.thu,
        fri: fri ?? this.fri,
        sat: sat ?? this.sat,
        sun: sun ?? this.sun,
        repeat: repeat ?? this.repeat,
        message: message ?? this.message,
        dateTimeNotification: dateTimeNotification ?? this.dateTimeNotification,
        dateCreate: dateCreate ?? this.dateCreate,
        dateModify: dateModify ?? this.dateModify,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('alarm: $alarm, ')
          ..write('mon: $mon, ')
          ..write('tue: $tue, ')
          ..write('wed: $wed, ')
          ..write('thu: $thu, ')
          ..write('fri: $fri, ')
          ..write('sat: $sat, ')
          ..write('sun: $sun, ')
          ..write('repeat: $repeat, ')
          ..write('message: $message, ')
          ..write('dateTimeNotification: $dateTimeNotification, ')
          ..write('dateCreate: $dateCreate, ')
          ..write('dateModify: $dateModify, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
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
                                          $mrjc(
                                              repeat.hashCode,
                                              $mrjc(
                                                  message.hashCode,
                                                  $mrjc(
                                                      dateTimeNotification
                                                          .hashCode,
                                                      $mrjc(
                                                          dateCreate.hashCode,
                                                          $mrjc(
                                                              dateModify
                                                                  .hashCode,
                                                              color
                                                                  .hashCode))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.name == this.name &&
          other.alarm == this.alarm &&
          other.mon == this.mon &&
          other.tue == this.tue &&
          other.wed == this.wed &&
          other.thu == this.thu &&
          other.fri == this.fri &&
          other.sat == this.sat &&
          other.sun == this.sun &&
          other.repeat == this.repeat &&
          other.message == this.message &&
          other.dateTimeNotification == this.dateTimeNotification &&
          other.dateCreate == this.dateCreate &&
          other.dateModify == this.dateModify &&
          other.color == this.color);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> alarm;
  final Value<bool> mon;
  final Value<bool> tue;
  final Value<bool> wed;
  final Value<bool> thu;
  final Value<bool> fri;
  final Value<bool> sat;
  final Value<bool> sun;
  final Value<bool> repeat;
  final Value<String> message;
  final Value<DateTime> dateTimeNotification;
  final Value<DateTime> dateCreate;
  final Value<DateTime> dateModify;
  final Value<String> color;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.alarm = const Value.absent(),
    this.mon = const Value.absent(),
    this.tue = const Value.absent(),
    this.wed = const Value.absent(),
    this.thu = const Value.absent(),
    this.fri = const Value.absent(),
    this.sat = const Value.absent(),
    this.sun = const Value.absent(),
    this.repeat = const Value.absent(),
    this.message = const Value.absent(),
    this.dateTimeNotification = const Value.absent(),
    this.dateCreate = const Value.absent(),
    this.dateModify = const Value.absent(),
    this.color = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.alarm = const Value.absent(),
    this.mon = const Value.absent(),
    this.tue = const Value.absent(),
    this.wed = const Value.absent(),
    this.thu = const Value.absent(),
    this.fri = const Value.absent(),
    this.sat = const Value.absent(),
    this.sun = const Value.absent(),
    this.repeat = const Value.absent(),
    @required String message,
    @required DateTime dateTimeNotification,
    @required DateTime dateCreate,
    @required DateTime dateModify,
    @required String color,
  })  : name = Value(name),
        message = Value(message),
        dateTimeNotification = Value(dateTimeNotification),
        dateCreate = Value(dateCreate),
        dateModify = Value(dateModify),
        color = Value(color);
  static Insertable<Task> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<bool> alarm,
    Expression<bool> mon,
    Expression<bool> tue,
    Expression<bool> wed,
    Expression<bool> thu,
    Expression<bool> fri,
    Expression<bool> sat,
    Expression<bool> sun,
    Expression<bool> repeat,
    Expression<String> message,
    Expression<DateTime> dateTimeNotification,
    Expression<DateTime> dateCreate,
    Expression<DateTime> dateModify,
    Expression<String> color,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (alarm != null) 'alarm': alarm,
      if (mon != null) 'mon': mon,
      if (tue != null) 'tue': tue,
      if (wed != null) 'wed': wed,
      if (thu != null) 'thu': thu,
      if (fri != null) 'fri': fri,
      if (sat != null) 'sat': sat,
      if (sun != null) 'sun': sun,
      if (repeat != null) 'repeat': repeat,
      if (message != null) 'message': message,
      if (dateTimeNotification != null)
        'date_time_notification': dateTimeNotification,
      if (dateCreate != null) 'date_create': dateCreate,
      if (dateModify != null) 'date_modify': dateModify,
      if (color != null) 'color': color,
    });
  }

  TasksCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<bool> alarm,
      Value<bool> mon,
      Value<bool> tue,
      Value<bool> wed,
      Value<bool> thu,
      Value<bool> fri,
      Value<bool> sat,
      Value<bool> sun,
      Value<bool> repeat,
      Value<String> message,
      Value<DateTime> dateTimeNotification,
      Value<DateTime> dateCreate,
      Value<DateTime> dateModify,
      Value<String> color}) {
    return TasksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      alarm: alarm ?? this.alarm,
      mon: mon ?? this.mon,
      tue: tue ?? this.tue,
      wed: wed ?? this.wed,
      thu: thu ?? this.thu,
      fri: fri ?? this.fri,
      sat: sat ?? this.sat,
      sun: sun ?? this.sun,
      repeat: repeat ?? this.repeat,
      message: message ?? this.message,
      dateTimeNotification: dateTimeNotification ?? this.dateTimeNotification,
      dateCreate: dateCreate ?? this.dateCreate,
      dateModify: dateModify ?? this.dateModify,
      color: color ?? this.color,
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
    if (repeat.present) {
      map['repeat'] = Variable<bool>(repeat.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (dateTimeNotification.present) {
      map['date_time_notification'] =
          Variable<DateTime>(dateTimeNotification.value);
    }
    if (dateCreate.present) {
      map['date_create'] = Variable<DateTime>(dateCreate.value);
    }
    if (dateModify.present) {
      map['date_modify'] = Variable<DateTime>(dateModify.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('alarm: $alarm, ')
          ..write('mon: $mon, ')
          ..write('tue: $tue, ')
          ..write('wed: $wed, ')
          ..write('thu: $thu, ')
          ..write('fri: $fri, ')
          ..write('sat: $sat, ')
          ..write('sun: $sun, ')
          ..write('repeat: $repeat, ')
          ..write('message: $message, ')
          ..write('dateTimeNotification: $dateTimeNotification, ')
          ..write('dateCreate: $dateCreate, ')
          ..write('dateModify: $dateModify, ')
          ..write('color: $color')
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

  final VerificationMeta _repeatMeta = const VerificationMeta('repeat');
  GeneratedBoolColumn _repeat;
  @override
  GeneratedBoolColumn get repeat => _repeat ??= _constructRepeat();
  GeneratedBoolColumn _constructRepeat() {
    return GeneratedBoolColumn('repeat', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _messageMeta = const VerificationMeta('message');
  GeneratedTextColumn _message;
  @override
  GeneratedTextColumn get message => _message ??= _constructMessage();
  GeneratedTextColumn _constructMessage() {
    return GeneratedTextColumn(
      'message',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateTimeNotificationMeta =
      const VerificationMeta('dateTimeNotification');
  GeneratedDateTimeColumn _dateTimeNotification;
  @override
  GeneratedDateTimeColumn get dateTimeNotification =>
      _dateTimeNotification ??= _constructDateTimeNotification();
  GeneratedDateTimeColumn _constructDateTimeNotification() {
    return GeneratedDateTimeColumn(
      'date_time_notification',
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

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedTextColumn _color;
  @override
  GeneratedTextColumn get color => _color ??= _constructColor();
  GeneratedTextColumn _constructColor() {
    return GeneratedTextColumn(
      'color',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        alarm,
        mon,
        tue,
        wed,
        thu,
        fri,
        sat,
        sun,
        repeat,
        message,
        dateTimeNotification,
        dateCreate,
        dateModify,
        color
      ];
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
    if (data.containsKey('repeat')) {
      context.handle(_repeatMeta,
          repeat.isAcceptableOrUnknown(data['repeat'], _repeatMeta));
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message'], _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('date_time_notification')) {
      context.handle(
          _dateTimeNotificationMeta,
          dateTimeNotification.isAcceptableOrUnknown(
              data['date_time_notification'], _dateTimeNotificationMeta));
    } else if (isInserting) {
      context.missing(_dateTimeNotificationMeta);
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
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color'], _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
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

class TasksDetailData extends DataClass implements Insertable<TasksDetailData> {
  final int id;
  final int idTask;
  final DateTime dateConfirm;
  TasksDetailData(
      {@required this.id, @required this.idTask, @required this.dateConfirm});
  factory TasksDetailData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return TasksDetailData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      idTask:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_task']),
      dateConfirm: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_confirm']),
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
    if (!nullToAbsent || dateConfirm != null) {
      map['date_confirm'] = Variable<DateTime>(dateConfirm);
    }
    return map;
  }

  TasksDetailCompanion toCompanion(bool nullToAbsent) {
    return TasksDetailCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idTask:
          idTask == null && nullToAbsent ? const Value.absent() : Value(idTask),
      dateConfirm: dateConfirm == null && nullToAbsent
          ? const Value.absent()
          : Value(dateConfirm),
    );
  }

  factory TasksDetailData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TasksDetailData(
      id: serializer.fromJson<int>(json['id']),
      idTask: serializer.fromJson<int>(json['idTask']),
      dateConfirm: serializer.fromJson<DateTime>(json['dateConfirm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idTask': serializer.toJson<int>(idTask),
      'dateConfirm': serializer.toJson<DateTime>(dateConfirm),
    };
  }

  TasksDetailData copyWith({int id, int idTask, DateTime dateConfirm}) =>
      TasksDetailData(
        id: id ?? this.id,
        idTask: idTask ?? this.idTask,
        dateConfirm: dateConfirm ?? this.dateConfirm,
      );
  @override
  String toString() {
    return (StringBuffer('TasksDetailData(')
          ..write('id: $id, ')
          ..write('idTask: $idTask, ')
          ..write('dateConfirm: $dateConfirm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(idTask.hashCode, dateConfirm.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TasksDetailData &&
          other.id == this.id &&
          other.idTask == this.idTask &&
          other.dateConfirm == this.dateConfirm);
}

class TasksDetailCompanion extends UpdateCompanion<TasksDetailData> {
  final Value<int> id;
  final Value<int> idTask;
  final Value<DateTime> dateConfirm;
  const TasksDetailCompanion({
    this.id = const Value.absent(),
    this.idTask = const Value.absent(),
    this.dateConfirm = const Value.absent(),
  });
  TasksDetailCompanion.insert({
    this.id = const Value.absent(),
    @required int idTask,
    @required DateTime dateConfirm,
  })  : idTask = Value(idTask),
        dateConfirm = Value(dateConfirm);
  static Insertable<TasksDetailData> custom({
    Expression<int> id,
    Expression<int> idTask,
    Expression<DateTime> dateConfirm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idTask != null) 'id_task': idTask,
      if (dateConfirm != null) 'date_confirm': dateConfirm,
    });
  }

  TasksDetailCompanion copyWith(
      {Value<int> id, Value<int> idTask, Value<DateTime> dateConfirm}) {
    return TasksDetailCompanion(
      id: id ?? this.id,
      idTask: idTask ?? this.idTask,
      dateConfirm: dateConfirm ?? this.dateConfirm,
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
    if (dateConfirm.present) {
      map['date_confirm'] = Variable<DateTime>(dateConfirm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksDetailCompanion(')
          ..write('id: $id, ')
          ..write('idTask: $idTask, ')
          ..write('dateConfirm: $dateConfirm')
          ..write(')'))
        .toString();
  }
}

class $TasksDetailTable extends TasksDetail
    with TableInfo<$TasksDetailTable, TasksDetailData> {
  final GeneratedDatabase _db;
  final String _alias;
  $TasksDetailTable(this._db, [this._alias]);
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
        $customConstraints: 'REFERENCES Tasks(id)');
  }

  final VerificationMeta _dateConfirmMeta =
      const VerificationMeta('dateConfirm');
  GeneratedDateTimeColumn _dateConfirm;
  @override
  GeneratedDateTimeColumn get dateConfirm =>
      _dateConfirm ??= _constructDateConfirm();
  GeneratedDateTimeColumn _constructDateConfirm() {
    return GeneratedDateTimeColumn(
      'date_confirm',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, idTask, dateConfirm];
  @override
  $TasksDetailTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tasks_detail';
  @override
  final String actualTableName = 'tasks_detail';
  @override
  VerificationContext validateIntegrity(Insertable<TasksDetailData> instance,
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
    if (data.containsKey('date_confirm')) {
      context.handle(
          _dateConfirmMeta,
          dateConfirm.isAcceptableOrUnknown(
              data['date_confirm'], _dateConfirmMeta));
    } else if (isInserting) {
      context.missing(_dateConfirmMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TasksDetailData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TasksDetailData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TasksDetailTable createAlias(String alias) {
    return $TasksDetailTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TasksTable _tasks;
  $TasksTable get tasks => _tasks ??= $TasksTable(this);
  $TasksDetailTable _tasksDetail;
  $TasksDetailTable get tasksDetail => _tasksDetail ??= $TasksDetailTable(this);
  TasksRepository _tasksRepository;
  TasksRepository get tasksRepository =>
      _tasksRepository ??= TasksRepository(this as Database);
  TasksListRepository _tasksListRepository;
  TasksListRepository get tasksListRepository =>
      _tasksListRepository ??= TasksListRepository(this as Database);
  TasksDetailRepository _tasksDetailRepository;
  TasksDetailRepository get tasksDetailRepository =>
      _tasksDetailRepository ??= TasksDetailRepository(this as Database);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tasks, tasksDetail];
}
