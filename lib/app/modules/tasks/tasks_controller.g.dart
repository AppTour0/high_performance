// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TasksController on _TasksBase, Store {
  final _$tasksAtom = Atom(name: '_TasksBase.tasks');

  @override
  ObservableList<TasksModel> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<TasksModel> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  final _$getTasksAsyncAction = AsyncAction('_TasksBase.getTasks');

  @override
  Future getTasks() {
    return _$getTasksAsyncAction.run(() => super.getTasks());
  }

  final _$getTaskAsyncAction = AsyncAction('_TasksBase.getTask');

  @override
  Future getTask(int id) {
    return _$getTaskAsyncAction.run(() => super.getTask(id));
  }

  final _$submitAsyncAction = AsyncAction('_TasksBase.submit');

  @override
  Future submit(TasksListModel data) {
    return _$submitAsyncAction.run(() => super.submit(data));
  }

  @override
  String toString() {
    return '''
tasks: ${tasks}
    ''';
  }
}
