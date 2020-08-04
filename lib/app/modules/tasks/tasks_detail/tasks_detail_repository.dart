import 'package:moor_flutter/moor_flutter.dart';
import 'package:high_performance/app/shared/db/database.dart';

part 'tasks_detail_repository.g.dart';

@UseDao(
  tables: [Tasks, TasksDetail],
)
class TasksDetailRepository extends DatabaseAccessor<Database>
    with _$TasksDetailRepositoryMixin {
  final Database db;

  TasksDetailRepository(this.db) : super(db);

  Stream<List<TasksDetailData>> getAllTasksDetail() {
    return (select(tasksDetail)).watch();
  }

  Stream<List<TasksDetailData>> getDetailById(int id) {
    return (select(tasksDetail)..where((u) => u.idTask.equals(id))).watch();
  }

  /* Future insertData(Insertable<TasksListData> task) =>
      into(tasksList).insert(task); */
  Future insertData(TasksDetailData taskDetail) async {
    return await into(tasksDetail).insert(taskDetail);
  }

  Future updateData(Insertable<TasksDetailData> taskDetail) =>
      update(tasksDetail).replace(taskDetail);
  Future deleteData(int id) {
    return (delete(tasksDetail)
          ..where((tasksDetail) => tasksDetail.id.equals(id)))
        .go();
  }
}
