import 'package:moor_flutter/moor_flutter.dart';
import 'package:high_performance/app/shared/db/database.dart';

part 'tasks_list_repository.g.dart';

@UseDao(
  tables: [Tasks, TasksList],
)
class TasksListRepository extends DatabaseAccessor<Database>
    with _$TasksListRepositoryMixin {
  final Database db;

  TasksListRepository(this.db) : super(db);

  Stream<List<TasksListWithTask>> getTasksList() {
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
            leftOuterJoin(tasks, tasks.id.equalsExp(tasks.id)),
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

  Future insertData(Insertable<TasksListData> task) =>
      into(tasksList).insert(task);
  Future updateData(Insertable<TasksListData> task) =>
      update(tasksList).replace(task);
  Future deleteData(Insertable<TasksListData> task) =>
      delete(tasksList).delete(task);
}

/* @UseDao(tables: [TasksList, Tasks])
class TasksListRepository extends DatabaseAccessor<Database>
    with _$TasksListRepositoryMixin {
  final Database db;

  TasksListRepository(this.db) : super(db);

  Stream<List<TasksListWithTask>> getTasksList() {
    return (select(tasksList))
        .join(
          [
            innerJoin(
              tasks,
              tasks.id.equalsExp(tasksList.idTask),
            ),
          ],
        )
        .watch()
        .map((rows) => rows.map((row) {
              return TasksListWithTask(
                taskList: row.readTable(tasksList),
                task: row.readTable(tasks),
              );
            })); //..where(tasksList.idTask.equals(id));
  }

  Future create(TasksListData entity) {
    return into(tasksList).insert(entity);
  }

  Future updateData(TasksListData entity) {
    return update(tasksList).replace(entity);
  }

  Future deleteData(id) {
    return (delete(tasks)..where((task) => task.id.equals(id))).go();
  } */

/* static final _table = "tasks_list";

  Future<Database> _getDatabase() {
    return DatabaseHelper.instance.database;
  }

  Future<List<TasksListModel>> getTask(int id) async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.rawQuery('''
          SELECT a.*, b.name FROM tasks_list a
            inner join tasks b
              on b.id = a.task_id
          Where a.id = $id or $id = 0
        ''');

      return List.generate(
        maps.length,
        (i) {
          // no sqflite tipo boolean não existe
          return TasksListModel(
            id: maps[i]['id'],
            idTask: maps[i]['task_id'],
            dateCreate: maps[i]['date_create'],
            name: maps[i]['name'], // inner joit table tasks
            alarm: maps[i]['alarm'] == 1 ? true : false,
            mon: maps[i]['mon'] == 1 ? true : false,
            tue: maps[i]['tue'] == 1 ? true : false,
            wed: maps[i]['wed'] == 1 ? true : false,
            thu: maps[i]['thu'] == 1 ? true : false,
            fri: maps[i]['fri'] == 1 ? true : false,
            sat: maps[i]['sat'] == 1 ? true : false,
            sun: maps[i]['sun'] == 1 ? true : false,
            amount: maps[i]['amount'],
            time: maps[i]['time'],
            dateModification: maps[i]['date_modification'],
            description: maps[i]['description'],
          );
        },
      );
    } catch (ex) {
      print(ex);
      return new List<TasksListModel>();
    }
  }

  Future create(TasksListModel model) async {
    try {
      final Database db = await _getDatabase();

      await db.insert(
        _table,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future delete(int id) async {
    try {
      final Database db = await _getDatabase();
      await db.delete(
        _table,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future update(TasksListModel model) async {
    try {
      final Database db = await _getDatabase();
      await db.update(
        _table,
        model.toMap(),
        where: "id = ?",
        whereArgs: [model.id],
      );
    } catch (ex) {
      print(ex);
      return;
    }
  } */
