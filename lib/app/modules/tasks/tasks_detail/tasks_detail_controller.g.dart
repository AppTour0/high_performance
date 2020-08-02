// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_detail_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TasksDetailController on _TasksDetailBase, Store {
  final _$taskAtom = Atom(name: '_TasksDetailBase.task');

  @override
  ObservableStream<List<Task>> get task {
    _$taskAtom.reportRead();
    return super.task;
  }

  @override
  set task(ObservableStream<List<Task>> value) {
    _$taskAtom.reportWrite(value, super.task, () {
      super.task = value;
    });
  }

  final _$deleteAsyncAction = AsyncAction('_TasksDetailBase.delete');

  @override
  Future<dynamic> delete(int id,
      {Future<VoidCallback> Function(String, String) onError,
      Future<VoidCallback> Function() onSuccess}) {
    return _$deleteAsyncAction
        .run(() => super.delete(id, onError: onError, onSuccess: onSuccess));
  }

  final _$_TasksDetailBaseActionController =
      ActionController(name: '_TasksDetailBase');

  @override
  dynamic getTask(int id) {
    final _$actionInfo = _$_TasksDetailBaseActionController.startAction(
        name: '_TasksDetailBase.getTask');
    try {
      return super.getTask(id);
    } finally {
      _$_TasksDetailBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
task: ${task}
    ''';
  }
}
