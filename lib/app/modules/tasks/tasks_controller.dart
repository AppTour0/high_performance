import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:high_performance/app/shared/db/database.dart';
import 'package:mobx/mobx.dart';
import 'package:intl/intl.dart';

part 'tasks_controller.g.dart';

class TasksController = _TasksBase with _$TasksController;

abstract class _TasksBase with Store {
  final _repository = Database.instance.tasksRepository;
  final _listRepository = Database.instance.tasksListRepository;
  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
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

  _TasksBase() {
    getTasks();
  }

  TextEditingController taskEditing = TextEditingController();
  TextEditingController idTaskEditing = TextEditingController();
  TextEditingController nameTaskEditing = TextEditingController();
  DateFormat timeFomrat;
  TextEditingController timeEditing = TextEditingController();
  DateFormat dateFomrat;
  TextEditingController dateEditing = TextEditingController();
  TextEditingController messageEditing = TextEditingController(text: "");
  int idTaskList = 0;

  @observable
  ObservableStream<List<dynamic>> tasks;

  @action
  getTasks() {
    tasks = _repository.getTasks().asObservable();
  }

  @observable
  ObservableStream<List<TasksListWithTask>> taskList;

  @action
  getTask(int id) {
    taskList = _listRepository.getTasksListById(id).asObservable();
  }

  @observable
  DateFormat dateOnlyFormat = DateFormat('dd/mm/yyyy');
  @observable
  DateFormat timeOnlyFormat = DateFormat('hh:mm');

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
        importance: Importance.Max,
        priority: Priority.Max,
        vibrationPattern: vibrationPattern,
        enableLights: true,
        color: const Color.fromARGB(255, 255, 0, 0),
        ledColor: const Color.fromARGB(255, 255, 0, 0),
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

    localNotificationsPlugin.schedule(
        hashcode, message, subtext, datetime, platformChannel,
        payload: hashcode.toString());
  }

  @action
  Future dailyNotification(
      DateTime datetime, String message, String subtext, int hashcode,
      {String sound}) async {
    Time time = Time(timeOfDay.hour, timeOfDay.minute);

    var iosChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(alarmConfigurations(), iosChannel);

    localNotificationsPlugin.showDailyAtTime(
        hashcode, message, subtext, time, platformChannel,
        payload: hashcode.toString());
  }

  @action
  submitTask(List<TasksListWithTask> data) async {
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
  }

  @action
  Future<void> submitList(List<TasksListWithTask> data,
      {Future<VoidCallback> onError(String title, String description),
      Future<VoidCallback> onSuccess()}) async {
    if (data.length == 0) {
      TasksListData model = TasksListData(
        id: null,
        idTask: int.tryParse(idTaskEditing.text),
        alarm: false,
        sun: daysOfWeek[0]['bool'],
        mon: daysOfWeek[1]['bool'],
        tue: daysOfWeek[2]['bool'],
        wed: daysOfWeek[3]['bool'],
        thu: daysOfWeek[4]['bool'],
        fri: daysOfWeek[5]['bool'],
        sat: daysOfWeek[6]['bool'],
        dateTimeNotification: DateTime.now().add(Duration(seconds: 10)),
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
          .updateData(data[0].taskList.copyWith(
              idTask: int.tryParse(idTaskEditing.text),
              sun: daysOfWeek[0]['bool'],
              mon: daysOfWeek[1]['bool'],
              tue: daysOfWeek[2]['bool'],
              wed: daysOfWeek[3]['bool'],
              thu: daysOfWeek[4]['bool'],
              fri: daysOfWeek[5]['bool'],
              sat: daysOfWeek[6]['bool'],
              dateModify: DateTime.now()))
          .then((value) => localNotificationsPlugin.cancel(data[0].taskList.id))
          .then((value) => notification(data[0].taskList.id))
          .then((value) => onSuccess())
          .catchError((error) => {
                onError(title, error),
              });
    }
  }

  Future notification(value) async {
    if (repeat) {
      return dailyNotification(DateTime.tryParse(dateEditing.text),
          taskEditing.text, messageEditing.text, value);
    } else {
      singleNotification(DateTime.tryParse(dateEditing.text), taskEditing.text,
          messageEditing.text, value);
    }
  }

  @action
  Future delete(int id,
      {Future<VoidCallback> onError(String title, String description),
      Future<VoidCallback> onSuccess()}) async {
    try {
      await _listRepository
          .deleteData(id)
          .then((value) => {localNotificationsPlugin.cancel(id), onSuccess()})
          .catchError((error) => {
                onError(title, error),
              });
    } catch (e) {
      onError(title, e.message);
    }
  }
}
