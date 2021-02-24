import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:high_performance/app/modules/home/tasks_list_model.dart';
import 'package:high_performance/app/shared/db/database.dart';
import 'package:mobx/mobx.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

part 'home_controller.g.dart';

class HomeController = _HomeBase with _$HomeController;

abstract class _HomeBase with Store {
  final _repository = Database.instance.tasksListRepository;
  final _detailRepository = Database.instance.tasksDetailRepository;
  String playerId = "";

  /* FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeNotifications() async {
    var initializeAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializeIOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(initializeAndroid, initializeIOS);
    await localNotificationsPlugin.initialize(initSettings);
  } */

  _HomeBase() {
    getLists();
    getPlayerId();
    //initializeNotifications();
  }

  @action
  Future getPlayerId() async {
    var state = await OneSignal.shared.getPermissionSubscriptionState();
    playerId = state.subscriptionStatus.userId;
    print(playerId);
  }

  /*  @observable
  List<Map<String, dynamic>> daysOfWeek = [
    {'day': 'sun', 'label': 'Domingo', 'bool': false},
    {'day': 'mon', 'label': 'Segunda', 'bool': false},
    {'day': 'tue', 'label': 'Terça', 'bool': false},
    {'day': 'wed', 'label': 'Quarta', 'bool': false},
    {'day': 'thu', 'label': 'Quinta', 'bool': false},
    {'day': 'fri', 'label': 'Sexta', 'bool': false},
    {'day': 'sat', 'label': 'Sabado', 'bool': false},
  ]; */

  ObservableStream<List<Task>> tasks;
  ObservableStream<List<Task>> habits;
  ObservableStream<List<TasksDetailData>> habitsCompleted;

  @observable
  List<DateTime> dateList = [];

  @action
  getLists() {
    tasks = _repository.getTasksList(false).asObservable();
    habits = _repository.getTasksList(true).asObservable();
    habitsCompleted = _detailRepository.getAllTasksDetail().asObservable();
  }

  @observable
  int bottomIndex = 0;

  @action
  insertDetail(DateTime date, int id) async {
    TasksDetailData model = TasksDetailData(
      id: null,
      idTask: id,
      dateConfirm: date,
    );
    await _detailRepository.insertData(model);
  }

  @action
  deleteDetail(int id) async {
    await _detailRepository.deleteData(id);
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

}
