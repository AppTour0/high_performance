import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:high_performance/app/shared/db/database.dart';
import 'package:mobx/mobx.dart';
import 'package:high_performance/app/shared/utils/notifications/receive_notification.dart';

part 'tasks_controller.g.dart';

class TasksController = _TasksBase with _$TasksController;

abstract class _TasksBase with Store {
  final _listRepository = Database.instance.tasksListRepository;
  VariablesNotification vars = VariablesNotification();
  String title = "Atenção!!!";

  @observable
  List<Map<String, dynamic>> daysOfWeek = [
    {'day': 'sun', 'label': 'Domingo', 'bool': false},
    {'day': 'mon', 'label': 'Segunda', 'bool': false},
    {'day': 'tue', 'label': 'Terça', 'bool': false},
    {'day': 'wed', 'label': 'Quarta', 'bool': false},
    {'day': 'thu', 'label': 'Quinta', 'bool': false},
    {'day': 'fri', 'label': 'Sexta', 'bool': false},
    {'day': 'sat', 'label': 'Sabado', 'bool': false},
  ];

  @observable
  bool repeat = false;

  @action
  switchBool(bool value) {
    for (var i = 0; i < daysOfWeek.length; i++) {
      daysOfWeek[i]['bool'] = value;
    }
  }

  @observable
  bool alarm = false;

  TextEditingController taskEditing = TextEditingController();
  TextEditingController nameTaskEditing = TextEditingController();
  TextEditingController timeEditing = TextEditingController();
  TextEditingController dateEditing = TextEditingController();
  TextEditingController messageEditing = TextEditingController(text: "");
  int idTask = 0;

  DateTime datetimeToDb;

  @observable
  ObservableStream<List<Task>> task;

  @action
  getTask(int id) {
    task = _listRepository.getTaskById(id).asObservable();
  }

  DateTime dateTimeNotification;
  TimeOfDay timeOfDay;

  AndroidNotificationDetails alarmConfigurations() {
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    var androidChannel = AndroidNotificationDetails(
        'channel-id', 'channel-name', 'channel-description',
        //sound: RawResourceAndroidNotificationSound('slow_spring_board'),
        //largeIcon: DrawableResourceAndroidBitmap('sample_large_icon'),
        importance: Importance.max,
        priority: Priority.max,
        vibrationPattern: vibrationPattern,
        enableLights: true,
        icon: "app_icon",
        color: const Color.fromARGB(0, 255, 130, 0),
        ledColor: const Color.fromARGB(0, 255, 130, 0),
        ledOnMs: 1000,
        ledOffMs: 500);

    return androidChannel;
  }

  @action
  Future singleNotification(
      DateTime datetime, String message, String subtext, int hashcode,
      {String sound}) async {
    var iosChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: alarmConfigurations(), iOS: iosChannel);

    vars.flutterLocalNotificationsPlugin.schedule(
        hashcode, message, subtext, datetime, platformChannel,
        payload: hashcode.toString());
  }

  @action
  Future dailyNotification(
      DateTime datetime, String message, String subtext, int hashcode,
      {String sound}) async {
    Time time = Time(datetime.hour, datetime.minute);

    var iosChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: alarmConfigurations(), iOS: iosChannel);

    await vars.flutterLocalNotificationsPlugin.showDailyAtTime(
        hashcode, message, subtext, time, platformChannel,
        payload: hashcode.toString());
  }

  @action
  Future<void> _showInsistentNotification() async {
    // This value is from: https://developer.android.com/reference/android/app/Notification.html#FLAG_INSISTENT
    var insistentFlag = 4;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        additionalFlags: Int32List.fromList([insistentFlag]));
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await vars.flutterLocalNotificationsPlugin.show(
        0, 'insistent title', 'insistent body', platformChannelSpecifics,
        payload: 'item x');
  }

  /* @action
  submitTask(List<Task> data) async {
    if (data.length == 0) {
      Task model = Task(
        id: null,
        name: nameTaskEditing.text,
        dateModify: DateTime.now(),
        dateCreate: DateTime.now(),
      );
      await _repository.insertData(model);
    } else {
      await _repository.updateData(data[0]
          .task
          .copyWith(name: nameTaskEditing.text, dateModify: DateTime.now()));
    }
  } */

  /* ======================== colors ============================ */
  @observable
  List<Map<String, dynamic>> colors = [
    {'colorString': 'black', 'color': Colors.black, 'selected': true},
    {'colorString': 'cyan', 'color': Colors.cyan, 'selected': false},
    {'colorString': 'blue', 'color': Colors.blue[600], 'selected': false},
    {'colorString': 'green', 'color': Colors.green[600], 'selected': false},
    {'colorString': 'orange', 'color': Colors.orange[600], 'selected': false},
    {'colorString': 'pink', 'color': Colors.pink, 'selected': false},
    {'colorString': 'grey', 'color': Colors.grey[600], 'selected': false},
    {'colorString': 'purple', 'color': Colors.purple[600], 'selected': false},
    {'colorString': 'red', 'color': Colors.red, 'selected': false},
    {'colorString': 'indigo', 'color': Colors.indigo, 'selected': false},
  ];

  @observable
  Color color = Colors.black;

  @observable
  String colorDB = "black";

  @action
  clearColor() {
    for (var i = 0; i < colors.length; i++) {
      colors[i]["selected"] = false;
    }
  }

  @action
  localeColor() {
    for (var i = 0; i < colors.length; i++) {
      if (colors[i]["selected"]) {
        color = colors[i]["color"];
        colorDB = colors[i]["colorString"];
      }
    }
  }

  @action
  Future<void> submitTask(List<Task> data,
      {Future<VoidCallback> onError(String title, String description),
      Future<VoidCallback> onSuccess()}) async {
    if (data.length == 0) {
      Task model = Task(
        id: null,
        name: taskEditing.text,
        alarm: false,
        sun: daysOfWeek[0]['bool'],
        mon: daysOfWeek[1]['bool'],
        tue: daysOfWeek[2]['bool'],
        wed: daysOfWeek[3]['bool'],
        thu: daysOfWeek[4]['bool'],
        fri: daysOfWeek[5]['bool'],
        sat: daysOfWeek[6]['bool'],
        dateTimeNotification: datetimeToDb,
        message: messageEditing.text,
        repeat: repeat,
        dateModify: DateTime.now(),
        dateCreate: DateTime.now(),
        color: colorDB,
      );
      await _listRepository
          .insertData(model)
          .then((value) => notification(value))
          .then((value) => onSuccess())
          .catchError((error) => {
                onError(title, error),
              });
    } else {
      await _listRepository
          .updateData(data[0].copyWith(
              name: taskEditing.text,
              sun: daysOfWeek[0]['bool'],
              mon: daysOfWeek[1]['bool'],
              tue: daysOfWeek[2]['bool'],
              wed: daysOfWeek[3]['bool'],
              thu: daysOfWeek[4]['bool'],
              fri: daysOfWeek[5]['bool'],
              sat: daysOfWeek[6]['bool'],
              message: messageEditing.text,
              repeat: repeat,
              dateTimeNotification: datetimeToDb,
              dateModify: DateTime.now()))
          .then((value) =>
              vars.flutterLocalNotificationsPlugin.cancel(data[0].id))
          .then((value) => notification(data[0].id))
          .then((value) => onSuccess())
          .catchError((error) => {
                onError(title, error),
              });
    }
  }

  Future notification(value) async {
    if (repeat) {
      return dailyNotification(
          datetimeToDb, taskEditing.text, messageEditing.text, value);
    } else {
      singleNotification(
          datetimeToDb, taskEditing.text, messageEditing.text, value);
    }
  }
}
