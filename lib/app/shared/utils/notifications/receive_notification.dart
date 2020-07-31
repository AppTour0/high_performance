import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moor/moor.dart';
import 'package:rxdart/rxdart.dart';

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

class VariablesNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
  BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();

  BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();

  NotificationAppLaunchDetails notificationAppLaunchDetails;
}
