import 'package:moor_flutter/moor_flutter.dart';
import 'package:high_performance/app/shared/db/database.dart';

part 'tasks_repository.g.dart';

@UseDao(tables: [Tasks])
class TasksRepository extends DatabaseAccessor<Database>
    with _$TasksRepositoryMixin {
  Stream<List<Task>> getTasks() {
    return (select(tasks)).watch();
  }

  Future<List<Task>> getUserFuture() {
    return (select(tasks)).get();
  }

  Future insertData(Task entity) {
    return into(tasks).insert(entity);
  }

  Future updateData(Task entity) {
    return update(tasks).replace(entity);
  }

  Future deleteData(id) {
    return (delete(tasks)..where((task) => task.id.equals(id))).go();
  }

  TasksRepository(Database db) : super(db);
}

/* static final _table = "tasks";

  Future<Database> _getDatabase() {
    return DatabaseHelper.instance.database;
  }

  Future<List<TasksModel>> getTasks() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(_table);

      return List.generate(
        maps.length,
        (i) {
          return TasksModel(
            id: maps[i]['id'],
            name: maps[i]['name'],
            dateModification: maps[i]['date_modification'],
          );
        },
      );
    } catch (ex) {
      print(ex);
      return new List<TasksModel>();
    }
  }

  Future create(TasksModel model) async {
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

  Future update(TasksModel model) async {
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

//dispose will be called automatically
/* W */
