import 'dart:async';

import 'package:flutter/material.dart';
import 'package:high_performance/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/shared/utils/notifications/receive_notification.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

VariablesNotification vars = VariablesNotification();

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //permite carregar dados dados assincronos no main()

  /* ================ bloco de notificações ======================== */
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        vars.didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await vars.flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    vars.selectNotificationSubject.add(payload);
  });

  /* ==================== firebase admob ===================== */

  /* MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    birthday: DateTime.now(),
    childDirected: false,
    designedForFamilies: false,
    gender:
        MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
    testDevices: <String>[], // Android emulators are considered test devices
  ); */

  runApp(ModularApp(module: AppModule()));
}
