import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:high_performance/app/modules/home/interfaces/tasks_list_interface.dart';
import 'package:high_performance/app/modules/home/tasks_list_model.dart';
import 'package:high_performance/app/shared/db/database.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeBase with _$HomeController;

abstract class _HomeBase with Store {
  final _repository = Database.instance.tasksListRepository;

  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeNotifications() async {
    var initializeAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializeIOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(initializeAndroid, initializeIOS);
    await localNotificationsPlugin.initialize(initSettings);
  }

  _HomeBase() {
    getList();
    initializeNotifications();
  }

  @observable
  ObservableStream<List<TasksListWithTask>> tasksList;

  @action
  getList() {
    var teste = _repository.getTasksList().asObservable();
    tasksList = teste;
  }

  /* 
  @action
  toggleSearch() {
    showSearch = !showSearch;
  }

  @action
  search(String term) async {
    final repository = new TasksListRepository();
    tasksList2 = new ObservableList<TasksListModel>();
    var data = await repository.getTasksList();
    tasksList2.addAll(data);
  } */

  /* @action
  save(TasksListModel model) async {
    await _repository.create(model);
  }

  @action
  delete(int id) async {
    await _repository.deleteData(id);
  }

  @action
  update(TasksListModel model) async {
    await _repository.updateData(model);
  } */
}
