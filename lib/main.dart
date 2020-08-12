import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:high_performance/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/shared/utils/notifications/receive_notification.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await vars.flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    vars.selectNotificationSubject.add(payload);
  });

  /* ==================== not test ===================== */

  OneSignal.shared.init(
    "42ed2b9b-d4d3-438d-9361-826499f3ed25",
    iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: false,
    },
  );
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

  //
  // Ao criar a instancia (que deve acontecer apenas uma vez)
  // o sistema ja deve guardar o playerID do OneSignal
  var status = await OneSignal.shared.getPermissionSubscriptionState();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("playerId", status.subscriptionStatus.userId);

  runApp(ModularApp(isCupertino: true, module: AppModule()));
}
