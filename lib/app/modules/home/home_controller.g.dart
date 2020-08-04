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

  final _$bottomIndexAtom = Atom(name: '_HomeBase.bottomIndex');

  @override
  int get bottomIndex {
    _$bottomIndexAtom.reportRead();
    return super.bottomIndex;
  }

  @override
  set bottomIndex(int value) {
    _$bottomIndexAtom.reportWrite(value, super.bottomIndex, () {
      super.bottomIndex = value;
    });
  }

  final _$insertDetailAsyncAction = AsyncAction('_HomeBase.insertDetail');

  @override
  Future insertDetail(DateTime date, int id) {
    return _$insertDetailAsyncAction.run(() => super.insertDetail(date, id));
  }

  final _$deleteDetailAsyncAction = AsyncAction('_HomeBase.deleteDetail');

  @override
  Future deleteDetail(int id) {
    return _$deleteDetailAsyncAction.run(() => super.deleteDetail(id));
  }

  final _$_HomeBaseActionController = ActionController(name: '_HomeBase');

  @override
  dynamic getLists() {
    final _$actionInfo =
        _$_HomeBaseActionController.startAction(name: '_HomeBase.getLists');
    try {
      return super.getLists();
    } finally {
      _$_HomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
daysOfWeek: ${daysOfWeek},
bottomIndex: ${bottomIndex}
    ''';
  }
}
