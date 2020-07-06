import 'package:high_performance/app/modules/home/models/tasks_model.dart';

abstract class ITasksRepository {
  Future<int> insert(TasksModel row);
  Future<List<TasksModel>> queryAllRows();
  Future<int> queryRowCount();
  Future<int> update(TasksModel row);
  Future<int> delete(id);
  Future<TasksModel> findById(id);
}

abstract class ITasksService {
  Future<int> insert(TasksModel row);
  Future<List<TasksModel>> queryAllRows();
  Future<int> queryRowCount();
  Future<int> update(TasksModel row);
  Future<int> delete(id);
  Future<TasksModel> findById(id);
}
