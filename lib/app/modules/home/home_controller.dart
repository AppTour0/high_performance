import 'package:flutter/cupertino.dart';
import 'package:high_performance/app/modules/home/interfaces/tasks_interface.dart';
import 'package:high_performance/app/modules/home/interfaces/tasks_list_interface.dart';
import 'package:high_performance/app/modules/home/models/tasks_list_model.dart';
import 'package:high_performance/app/modules/home/models/tasks_model.dart';
import 'package:high_performance/app/modules/home/repositories/tasks_list_repository.dart';
import 'package:high_performance/app/modules/home/repositories/tasks_repository.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeBase with _$HomeController;

abstract class _HomeBase with Store {
  final ITasksListService tasksListService;
  final _repository = TasksListRepository();
  final _taskRepository = TasksRepository();

  _HomeBase({@required this.tasksListService}) {
    getList();
    getTask();
  }

  ObservableList<TasksListModel> tasksList = ObservableList<TasksListModel>();
  ObservableList<TasksModel> tasks = ObservableList<TasksModel>();

/*   @action
  toggleSearch() {
    showSearch = !showSearch;
  } */

  @action
  getList() async {
    var data = await _repository.getTasksList();
    tasksList.clear();
    tasksList.addAll(data);
  }

  @action
  getTask() async {
    var data = await _taskRepository.getTasks();
    tasks.clear();
    tasks.addAll(data);
  }
  /* @action
  search(String term) async {
    final repository = new TasksListRepository();
    tasksList2 = new ObservableList<TasksListModel>();
    var data = await repository.getTasksList();
    tasksList2.addAll(data);
  } */

  /* @action
  Future<List<TasksModel>> getList() async {
    return await tasksService.queryAllRows();
  } */

  @action
  save(TasksListModel model) async {
    await _repository.create(model);
  }

  @action
  delete(int id) async {
    await _repository.delete(id);
  }

  @action
  update(TasksListModel model) async {
    await _repository.update(model);
  }
}
