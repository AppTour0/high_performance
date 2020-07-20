// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TasksController on _TasksBase, Store {
  final _$daysWeekCheckAtom = Atom(name: '_TasksBase.daysWeekCheck');

  @override
  Map<String, bool> get daysWeekCheck {
    _$daysWeekCheckAtom.reportRead();
    return super.daysWeekCheck;
  }

  @override
  set daysWeekCheck(Map<String, bool> value) {
    _$daysWeekCheckAtom.reportWrite(value, super.daysWeekCheck, () {
      super.daysWeekCheck = value;
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

  final _$submitTaskAsyncAction = AsyncAction('_TasksBase.submitTask');

  @override
  Future submitTask(List<TasksListWithTask> data) {
    return _$submitTaskAsyncAction.run(() => super.submitTask(data));
  }

  final _$submitListAsyncAction = AsyncAction('_TasksBase.submitList');

  @override
  Future submitList(List<TasksListWithTask> data) {
    return _$submitListAsyncAction.run(() => super.submitList(data));
  }

  final _$_TasksBaseActionController = ActionController(name: '_TasksBase');

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
daysWeekCheck: ${daysWeekCheck},
alarm: ${alarm},
tasks: ${tasks},
taskList: ${taskList}
    ''';
  }
}
