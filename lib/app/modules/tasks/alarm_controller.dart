import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'alarm_controller.g.dart';

class AlarmController = _AlarmBase with _$AlarmController;

abstract class _AlarmBase with Store {
  _AlarmBase() {
    getPrefs();
  }

  /// Global [SharedPreferences] object.
  @observable
  SharedPreferences prefs;

  Future getPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}
