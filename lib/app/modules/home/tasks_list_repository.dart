import 'package:moor_flutter/moor_flutter.dart';
import 'package:high_performance/app/shared/db/database.dart';

part 'tasks_list_repository.g.dart';

@UseDao(
  tables: [Tasks, TasksDetail],
)
class TasksListRepository extends DatabaseAccessor<Database>
    with _$TasksListRepositoryMixin {
  final Database db;

  TasksListRepository(this.db) : super(db);

  Stream<List<Task>> getAllTasksList() {
    return (select(tasks)).watch();
  }

  Stream<List<Task>> getTasksList(bool repeat) {
    return (select(tasks)..where((u) => u.repeat.equals(repeat))).watch();
  }

  Stream<List<Task>> getTaskById(int id) {
    return (select(tasks)..where((u) => u.id.equals(id))).watch();
  }

  /* Future insertData(Insertable<TasksListData> task) =>
      into(tasksList).insert(task); */
  Future insertData(Task task) async {
    return await into(tasks).insert(task);
  }

  Future updateData(Insertable<Task> task) => update(tasks).replace(task);
  Future deleteData(int id) {
    return (delete(tasks)..where((tasksList) => tasksList.id.equals(id))).go();
  }
}

/* Stream<List<TasksListWithTask>> getTasksList() {
    return (select(tasksList))
        .join(
          [
            innerJoin(tasks, tasks.id.equalsExp(tasksList.idTask)),
          ],
        )
        .watch()
        .map((rows) => rows.map(
              (row) {
                return TasksListWithTask(
                  task: row.readTable(tasks),
                  taskList: row.readTable(tasksList),
                );
              },
            ).toList());
  }

  Stream<List<TasksListWithTask>> getTasksListById(int id) {
    return (select(tasksList)..where((u) => u.id.equals(id)))
        .join(
          [
            innerJoin(tasks, tasks.id.equalsExp(tasksList.id)),
          ],
        )
        .watch()
        .map((rows) => rows.map(
              (row) {
                return TasksListWithTask(
                  task: row.readTable(tasks),
                  taskList: row.readTable(tasksList),
                );
              },
            ).toList());
  } */
