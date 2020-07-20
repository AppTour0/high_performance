// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlarmController on _AlarmBase, Store {
  final _$prefsAtom = Atom(name: '_AlarmBase.prefs');

  @override
  SharedPreferences get prefs {
    _$prefsAtom.reportRead();
    return super.prefs;
  }

  @override
  set prefs(SharedPreferences value) {
    _$prefsAtom.reportWrite(value, super.prefs, () {
      super.prefs = value;
    });
  }

  @override
  String toString() {
    return '''
prefs: ${prefs}
    ''';
  }
}
