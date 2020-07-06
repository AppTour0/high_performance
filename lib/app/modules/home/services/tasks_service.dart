import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/modules/home/interfaces/tasks_interface.dart';
import 'package:high_performance/app/modules/home/models/tasks_model.dart';

class TasksService extends Disposable implements ITasksService {
  final ITasksRepository tasksRepository;
  TasksService({@required this.tasksRepository});

  Future<List<TasksModel>> queryAllRows() async {
    return await tasksRepository.queryAllRows();
  }

  Future<int> insert(TasksModel row) async {
    final id = await tasksRepository.insert(row);
    print('linha inserida id: $id');
    return id;
  }

  Future<TasksModel> findById(id) async {
    return await tasksRepository.findById(id);
  }

  Future<int> update(TasksModel row) async {
    final linesChanges = await tasksRepository.update(row);
    print('atualizadas $linesChanges linha(s)');
    return linesChanges;
  }

  Future<int> delete(id) async {
    final lineDelete = await tasksRepository.delete(id);
    print(lineDelete);
    return lineDelete;
  }

  Future<int> queryRowCount() async {
    return await tasksRepository.queryRowCount();
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
