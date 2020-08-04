import 'package:dio/dio.dart';
import 'package:high_performance/app/shared/db/database.dart';
import 'package:high_performance/app/shared/utils/notifications/receive_notification.dart';
import 'package:mobx/mobx.dart';

part 'tasks_detail_controller.g.dart';

class TasksDetailController = _TasksDetailBase with _$TasksDetailController;

abstract class _TasksDetailBase with Store {
  final _repository = Database.instance.tasksListRepository;
  final _detailRepository = Database.instance.tasksDetailRepository;

  VariablesNotification vars = VariablesNotification();
  String title = "Atenção!!!";

  List<Map<String, dynamic>> daysOfWeek = [
    {'day': 'sun', 'label': 'Domingo', 'bool': false},
    {'day': 'mon', 'label': 'Segunda', 'bool': false},
    {'day': 'tue', 'label': 'Terça', 'bool': false},
    {'day': 'wed', 'label': 'Quarta', 'bool': false},
    {'day': 'thu', 'label': 'Quinta', 'bool': false},
    {'day': 'fri', 'label': 'Sexta', 'bool': false},
    {'day': 'sat', 'label': 'Sabado', 'bool': false},
  ];

  ObservableStream<List<Task>> task;
  ObservableStream<List<TasksDetailData>> habitsCompleted;

  @action
  getTask(int id) {
    task = _repository.getTaskById(id).asObservable();
    habitsCompleted = _detailRepository.getDetailById(id).asObservable();
  }

  @action
  Future delete(int id,
      {Future<VoidCallback> onError(String title, String description),
      Future<VoidCallback> onSuccess()}) async {
    try {
      await _repository
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

  @action
  insertDetail(DateTime date, int id) async {
    TasksDetailData model = TasksDetailData(
      id: null,
      idTask: id,
      confirm: true,
      dateConfirm: date,
      dateModify: DateTime.now(),
      dateCreate: DateTime.now(),
    );
    await _detailRepository.insertData(model);
  }

  @action
  deleteDetail(int id) async {
    await _detailRepository.deleteData(id);
  }
}
