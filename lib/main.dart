import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:high_performance/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'app/shared/db/db.dart';
SharedPreferences prefs;

/// The [SharedPreferences] key to access the alarm fire count.
String countKey = 'count';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //permite carregar dados dados assincronos no main()
  //await DatabaseHelper.instance.database;

  // TODO(bkonyi): uncomment
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey(countKey)) {
    await prefs.setInt(countKey, 0);
  }

  runApp(ModularApp(module: AppModule()));
}
