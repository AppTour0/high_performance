import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  ObservableStream<List<TasksListWithTask>> tasksList;

  @action
  getList() {
    tasksList = _repository.getTasksList().asObservable();
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
