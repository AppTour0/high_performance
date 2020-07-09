import 'package:flutter/cupertino.dart';
import 'package:high_performance/app/modules/home/models/tasks_list_model.dart';
import 'package:high_performance/app/modules/home/repositories/tasks_list_repository.dart';
import 'package:high_performance/app/modules/tasks/tasks_model.dart';
import 'package:high_performance/app/modules/tasks/tasks_repository.dart';
import 'package:mobx/mobx.dart';

part 'tasks_controller.g.dart';

class TasksController = _TasksBase with _$TasksController;

abstract class _TasksBase with Store {
  final _repository = TasksRepository();
  final _listRepository = TasksListRepository();

  _TasksBase() {
    getTasks();
  }

  TextEditingController taskEditing = TextEditingController();
  TextEditingController idTaskEditing = TextEditingController();
  int idTaskList = 0;

  @observable
  ObservableList<TasksModel> tasks = ObservableList<TasksModel>();

  @action
  getTasks() async {
    var data = await _repository.getTasks();
    tasks.clear();
    tasks.addAll(data);
  }

  ObservableList<TasksListModel> taskList = ObservableList<TasksListModel>();

  @action
  getTask(int id) async {
    var data = await _listRepository.getTask(id);
    taskList.addAll(data);
  }

  @action
  submit(TasksListModel data) async {
    TasksListModel model = TasksListModel(
        id: data == null ? null : data.id,
        idTask: int.tryParse(idTaskEditing.text),
        dateCreate: DateTime.now().toString());
    if (data == null) {
      await _listRepository.create(model);
    } else {
      await _listRepository.update(model);
    }
  }
}
