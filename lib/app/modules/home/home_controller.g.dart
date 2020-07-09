// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeBase, Store {
  final _$tasksListAtom = Atom(name: '_HomeBase.tasksList');

  @override
  ObservableList<TasksListModel> get tasksList {
    _$tasksListAtom.reportRead();
    return super.tasksList;
  }

  @override
  set tasksList(ObservableList<TasksListModel> value) {
    _$tasksListAtom.reportWrite(value, super.tasksList, () {
      super.tasksList = value;
    });
  }

  final _$tasksAtom = Atom(name: '_HomeBase.tasks');

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

  final _$getListAsyncAction = AsyncAction('_HomeBase.getList');

  @override
  Future getList() {
    return _$getListAsyncAction.run(() => super.getList());
  }

  final _$getTaskAsyncAction = AsyncAction('_HomeBase.getTask');

  @override
  Future getTask() {
    return _$getTaskAsyncAction.run(() => super.getTask());
  }

  final _$saveAsyncAction = AsyncAction('_HomeBase.save');

  @override
  Future save(TasksListModel model) {
    return _$saveAsyncAction.run(() => super.save(model));
  }

  final _$deleteAsyncAction = AsyncAction('_HomeBase.delete');

  @override
  Future delete(int id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }

  final _$updateAsyncAction = AsyncAction('_HomeBase.update');

  @override
  Future update(TasksListModel model) {
    return _$updateAsyncAction.run(() => super.update(model));
  }

  @override
  String toString() {
    return '''
tasksList: ${tasksList},
tasks: ${tasks}
    ''';
  }
}
