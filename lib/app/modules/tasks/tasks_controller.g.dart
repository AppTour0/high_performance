// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TasksController on _TasksBase, Store {
  final _$daysOfWeekAtom = Atom(name: '_TasksBase.daysOfWeek');

  @override
  List<Map<String, dynamic>> get daysOfWeek {
    _$daysOfWeekAtom.reportRead();
    return super.daysOfWeek;
  }

  @override
  set daysOfWeek(List<Map<String, dynamic>> value) {
    _$daysOfWeekAtom.reportWrite(value, super.daysOfWeek, () {
      super.daysOfWeek = value;
    });
  }

  final _$repeatAtom = Atom(name: '_TasksBase.repeat');

  @override
  bool get repeat {
    _$repeatAtom.reportRead();
    return super.repeat;
  }

  @override
  set repeat(bool value) {
    _$repeatAtom.reportWrite(value, super.repeat, () {
      super.repeat = value;
    });
  }

  final _$alarmAtom = Atom(name: '_TasksBase.alarm');

  @override
  bool get alarm {
    _$alarmAtom.reportRead();
    return super.alarm;
  }

  @override
  set alarm(bool value) {
    _$alarmAtom.reportWrite(value, super.alarm, () {
      super.alarm = value;
    });
  }

  final _$taskAtom = Atom(name: '_TasksBase.task');

  @override
  ObservableStream<List<Task>> get task {
    _$taskAtom.reportRead();
    return super.task;
  }

  @override
  set task(ObservableStream<List<dynamic>> value) {
    _$taskAtom.reportWrite(value, super.task, () {
      super.task = value;
    });
  }

  final _$colorsAtom = Atom(name: '_TasksBase.colors');

  @override
  List<Map<String, dynamic>> get colors {
    _$colorsAtom.reportRead();
    return super.colors;
  }

  @override
  set colors(List<Map<String, dynamic>> value) {
    _$colorsAtom.reportWrite(value, super.colors, () {
      super.colors = value;
    });
  }

  final _$colorAtom = Atom(name: '_TasksBase.color');

  @override
  Color get color {
    _$colorAtom.reportRead();
    return super.color;
  }

  @override
  set color(Color value) {
    _$colorAtom.reportWrite(value, super.color, () {
      super.color = value;
    });
  }

  final _$colorDBAtom = Atom(name: '_TasksBase.colorDB');

  @override
  String get colorDB {
    _$colorDBAtom.reportRead();
    return super.colorDB;
  }

  @override
  set colorDB(String value) {
    _$colorDBAtom.reportWrite(value, super.colorDB, () {
      super.colorDB = value;
    });
  }

  final _$singleNotificationAsyncAction =
      AsyncAction('_TasksBase.singleNotification');

  @override
  Future<dynamic> singleNotification(
      DateTime datetime, String message, String subtext, int hashcode,
      {String sound}) {
    return _$singleNotificationAsyncAction.run(() => super.singleNotification(
        datetime, message, subtext, hashcode,
        sound: sound));
  }

  final _$dailyNotificationAsyncAction =
      AsyncAction('_TasksBase.dailyNotification');

  @override
  Future<dynamic> dailyNotification(
      DateTime datetime, String message, String subtext, int hashcode,
      {String sound}) {
    return _$dailyNotificationAsyncAction.run(() => super
        .dailyNotification(datetime, message, subtext, hashcode, sound: sound));
  }

  final _$_showInsistentNotificationAsyncAction =
      AsyncAction('_TasksBase._showInsistentNotification');

  @override
  Future<void> _showInsistentNotification() {
    return _$_showInsistentNotificationAsyncAction
        .run(() => super._showInsistentNotification());
  }

  final _$submitTaskAsyncAction = AsyncAction('_TasksBase.submitTask');

  @override
  Future<void> submitTask(List<dynamic> data,
      {Future<VoidCallback> Function(String, String) onError,
      Future<VoidCallback> Function() onSuccess}) {
    return _$submitTaskAsyncAction.run(
        () => super.submitTask(data, onError: onError, onSuccess: onSuccess));
  }

  final _$_TasksBaseActionController = ActionController(name: '_TasksBase');

  @override
  dynamic switchBool(bool value) {
    final _$actionInfo =
        _$_TasksBaseActionController.startAction(name: '_TasksBase.switchBool');
    try {
      return super.switchBool(value);
    } finally {
      _$_TasksBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getTask(int id) {
    final _$actionInfo =
        _$_TasksBaseActionController.startAction(name: '_TasksBase.getTask');
    try {
      return super.getTask(id);
    } finally {
      _$_TasksBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearColor() {
    final _$actionInfo =
        _$_TasksBaseActionController.startAction(name: '_TasksBase.clearColor');
    try {
      return super.clearColor();
    } finally {
      _$_TasksBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic localeColor() {
    final _$actionInfo = _$_TasksBaseActionController.startAction(
        name: '_TasksBase.localeColor');
    try {
      return super.localeColor();
    } finally {
      _$_TasksBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
daysOfWeek: ${daysOfWeek},
repeat: ${repeat},
alarm: ${alarm},
task: ${task},
colors: ${colors},
color: ${color},
colorDB: ${colorDB}
    ''';
  }
}
