import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:high_performance/app/shared/db/database.dart';
import 'package:mobx/mobx.dart';

part 'tasks_controller.g.dart';

class TasksController = _TasksBase with _$TasksController;

abstract class _TasksBase with Store {
  final _repository = Database.instance.tasksRepository;
  final _listRepository = Database.instance.tasksListRepository;
  Map<String, String> daysWeek = {
    'mon': 'Segunda',
    'tue': 'Terça',
    'wed': 'Quarta',
    'thu': 'Quinta',
    'fri': 'Sexta',
    'sat': 'Sábado',
    'sun': 'Domingo'
  };

  @observable
  Map<String, bool> daysWeekCheck = {
    'mon': false,
    'tue': false,
    'wed': false,
    'thu': false,
    'fri': false,
    'sat': false,
    'sun': false
  };

  @observable
  bool alarm = false;

  _TasksBase() {
    getTasks();
  }

  TextEditingController taskEditing = TextEditingController();
  TextEditingController idTaskEditing = TextEditingController();
  TextEditingController nameTaskEditing = TextEditingController();
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
  submitList(List<TasksListWithTask> data) async {
    if (data.length == 0) {
      TasksListData model = TasksListData(
        id: null,
        idTask: int.tryParse(idTaskEditing.text),
        alarm: false,
        mon: false,
        tue: false,
        wed: false,
        thu: false,
        fri: false,
        sat: false,
        sun: false,
        dateModify: DateTime.now(),
        dateCreate: DateTime.now(),
      );
      await _listRepository.insertData(model);
    } else {
      await _listRepository.updateData(data[0].taskList.copyWith(
          idTask: int.tryParse(idTaskEditing.text),
          dateModify: DateTime.now()));
    }
  }
}
