import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:high_performance/app/shared/db/database.dart';
import 'package:mobx/mobx.dart';
import 'package:intl/intl.dart';
import 'package:high_performance/app/shared/utils/notifications/receive_notification.dart';

part 'tasks_controller.g.dart';

class TasksController = _TasksBase with _$TasksController;

abstract class _TasksBase with Store {
  final _repository = Database.instance.tasksRepository;
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
  DateFormat timeFomrat;
  TextEditingController timeEditing = TextEditingController();
  DateFormat dateFomrat;
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
        importance: Importance.Max,
        priority: Priority.Max,
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
        NotificationDetails(alarmConfigurations(), iosChannel);

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
        NotificationDetails(alarmConfigurations(), iosChannel);

    await vars.flutterLocalNotificationsPlugin.showDailyAtTime(
        hashcode, message, subtext, time, platformChannel,
        payload: hashcode.toString());
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
        unique: false,
        dateModify: DateTime.now(),
        dateCreate: DateTime.now(),
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

  @action
  Future delete(int id,
      {Future<VoidCallback> onError(String title, String description),
      Future<VoidCallback> onSuccess()}) async {
    try {
      await _listRepository
          .deleteData(id)
          .then((value) =>
              {vars.flutterLocalNotificationsPlugin.cancel(id), onSuccess()})
          .catchError((error) => {
                onError(title, error),
              });
    } catch (e) {
      onError(title, e.message);
    }
  }
}
