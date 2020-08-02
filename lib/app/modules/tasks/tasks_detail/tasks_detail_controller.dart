import 'package:dio/dio.dart';
import 'package:high_performance/app/shared/db/database.dart';
import 'package:high_performance/app/shared/utils/notifications/receive_notification.dart';
import 'package:mobx/mobx.dart';

part 'tasks_detail_controller.g.dart';

class TasksDetailController = _TasksDetailBase with _$TasksDetailController;

abstract class _TasksDetailBase with Store {
  final _repository = Database.instance.tasksListRepository;
  VariablesNotification vars = VariablesNotification();
  String title = "Atenção!!!";

  @observable
  ObservableStream<List<Task>> task;

  @action
  getTask(int id) {
    task = _repository.getTaskById(id).asObservable();
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
}
