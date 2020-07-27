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

  final _$tasksAtom = Atom(name: '_TasksBase.tasks');

  @override
  ObservableStream<List<dynamic>> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableStream<List<dynamic>> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  final _$taskListAtom = Atom(name: '_TasksBase.taskList');

  @override
  ObservableStream<List<TasksListWithTask>> get taskList {
    _$taskListAtom.reportRead();
    return super.taskList;
  }

  @override
  set taskList(ObservableStream<List<TasksListWithTask>> value) {
    _$taskListAtom.reportWrite(value, super.taskList, () {
      super.taskList = value;
    });
  }

  final _$dateOnlyFormatAtom = Atom(name: '_TasksBase.dateOnlyFormat');

  @override
  DateFormat get dateOnlyFormat {
    _$dateOnlyFormatAtom.reportRead();
    return super.dateOnlyFormat;
  }

  @override
  set dateOnlyFormat(DateFormat value) {
    _$dateOnlyFormatAtom.reportWrite(value, super.dateOnlyFormat, () {
      super.dateOnlyFormat = value;
    });
  }

  final _$timeOnlyFormatAtom = Atom(name: '_TasksBase.timeOnlyFormat');

  @override
  DateFormat get timeOnlyFormat {
    _$timeOnlyFormatAtom.reportRead();
    return super.timeOnlyFormat;
  }

  @override
  set timeOnlyFormat(DateFormat value) {
    _$timeOnlyFormatAtom.reportWrite(value, super.timeOnlyFormat, () {
      super.timeOnlyFormat = value;
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

  final _$submitTaskAsyncAction = AsyncAction('_TasksBase.submitTask');

  @override
  Future submitTask(List<TasksListWithTask> data) {
    return _$submitTaskAsyncAction.run(() => super.submitTask(data));
  }

  final _$submitListAsyncAction = AsyncAction('_TasksBase.submitList');

  @override
  Future<void> submitList(List<TasksListWithTask> data,
      {Future<VoidCallback> Function(String, String) onError,
      Future<VoidCallback> Function() onSuccess}) {
    return _$submitListAsyncAction.run(
        () => super.submitList(data, onError: onError, onSuccess: onSuccess));
  }

  final _$deleteAsyncAction = AsyncAction('_TasksBase.delete');

  @override
  Future<dynamic> delete(int id,
      {Future<VoidCallback> Function(String, String) onError,
      Future<VoidCallback> Function() onSuccess}) {
    return _$deleteAsyncAction
        .run(() => super.delete(id, onError: onError, onSuccess: onSuccess));
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
  dynamic getTasks() {
    final _$actionInfo =
        _$_TasksBaseActionController.startAction(name: '_TasksBase.getTasks');
    try {
      return super.getTasks();
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
  String toString() {
    return '''
daysOfWeek: ${daysOfWeek},
repeat: ${repeat},
alarm: ${alarm},
tasks: ${tasks},
taskList: ${taskList},
dateOnlyFormat: ${dateOnlyFormat},
timeOnlyFormat: ${timeOnlyFormat}
    ''';
  }
}
