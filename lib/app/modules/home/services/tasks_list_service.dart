import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/modules/home/interfaces/tasks_list_interface.dart';
import 'package:high_performance/app/modules/home/models/tasks_list_model.dart';

class TasksListService extends Disposable implements ITasksListService {
  final ITasksListRepository tasksListRepository;
  TasksListService({@required this.tasksListRepository});

  Future<List<TasksListModel>> queryAllRows() async {
    return await tasksListRepository.queryAllRows();
  }

  Future<int> insert(TasksListModel row) async {
    final id = await tasksListRepository.insert(row);
    print('linha inserida id: $id');
    return id;
  }

  Future<TasksListModel> findById(id) async {
    return await tasksListRepository.findById(id);
  }

  Future<int> update(TasksListModel row) async {
    final linesChanges = await tasksListRepository.update(row);
    print('atualizadas $linesChanges linha(s)');
    return linesChanges;
  }

  Future<int> delete(id) async {
    final lineDelete = await tasksListRepository.delete(id);
    print(lineDelete);
    return lineDelete;
  }

  Future<int> queryRowCount() async {
    return await tasksListRepository.queryRowCount();
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
