import 'package:moor_flutter/moor_flutter.dart';
import 'package:high_performance/app/shared/db/database.dart';

part 'tasks_list_repository.g.dart';

@UseDao(
  tables: [Tasks, TasksDetail, TasksWithDetail],
)
class TasksListRepository extends DatabaseAccessor<Database>
    with _$TasksListRepositoryMixin {
  final Database db;

  /* Future<List<TasksWithDetail>> loadEntries() {
    // assume that an entry is important if it has the string "important" somewhere in its content
    final detail;
    //(select(tasksDetail)).get().then((value) => detail = value).then((value) => null);

    return select(tasks).addColumns([detail]).map((row) {
      final task = row.readTable(tasks);
      final detailTask = row.read(detail);

      return TasksWithDetail(task, detailTask);
    }).get();
  } */

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

  /* Stream<List<TasksWithDetail>> getTasksWithDetail() {
    return (select(tasks))
        .join(
          [
            innerJoin(tasksDetail, tasksDetail.idTask.equalsExp(tasks.id)),
          ],
        )
        .watch()
        .map((rows) => rows.map(
              (row) {
                return TasksWithDetail(
                  task: row.readTable(tasks),
                  taskDetail: row.readTable(tasksDetail),
                );
              },
            ).toList());
  } */

  /* Future insertData(Insertable<TasksListData> task) =>
      into(tasksList).insert(task); */
  Future insertData(Task task) async {
    return await into(tasks).insert(task);
  }

  Future updateData(Insertable<Task> task) => update(tasks).replace(task);

  Future deleteData(int id) {
    return (delete(tasks)..where((tasks) => tasks.id.equals(id))).go();
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
