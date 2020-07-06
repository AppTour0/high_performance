import 'package:high_performance/app/modules/home/models/tasks_list_model.dart';

abstract class ITasksListRepository {
  Future<int> insert(TasksListModel row);
  Future<List<TasksListModel>> queryAllRows();
  Future<int> queryRowCount();
  Future<int> update(TasksListModel row);
  Future<int> delete(id);
  Future<TasksListModel> findById(id);
}

abstract class ITasksListService {
  Future<int> insert(TasksListModel row);
  Future<List<TasksListModel>> queryAllRows();
  Future<int> queryRowCount();
  Future<int> update(TasksListModel row);
  Future<int> delete(id);
  Future<TasksListModel> findById(id);
}
