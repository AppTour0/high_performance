import 'package:high_performance/app/modules/home/models/tasks_list_model.dart';

abstract class ITaskListRepository {
  Future<int> insert(TasksListModel row);
  Future<List<TasksListModel>> queryAllRows();
  Future<int> queryRowCount();
  Future<int> update(TasksListModel row);
  Future<int> delete(id);
  Future<TasksListModel> findById(id);
}

abstract class ITaskListService {
  Future<int> insert(TasksListModel row);
  Future<List<TasksListModel>> queryAllRows();
  Future<int> queryRowCount();
  Future<int> update(TasksListModel row);
  Future<int> delete(id);
  Future<TasksListModel> findById(id);
}
