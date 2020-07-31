// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeBase, Store {
  final _$daysOfWeekAtom = Atom(name: '_HomeBase.daysOfWeek');

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

  final _$tasksAtom = Atom(name: '_HomeBase.tasks');

  @override
  ObservableStream<List<Task>> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableStream<List<Task>> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  final _$_HomeBaseActionController = ActionController(name: '_HomeBase');

  @override
  dynamic getList() {
    final _$actionInfo =
        _$_HomeBaseActionController.startAction(name: '_HomeBase.getList');
    try {
      return super.getList();
    } finally {
      _$_HomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
daysOfWeek: ${daysOfWeek},
tasks: ${tasks}
    ''';
  }
}
