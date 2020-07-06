import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'package:high_performance/app/modules/home/interfaces/tasks_interface.dart';
import 'package:high_performance/app/modules/home/models/tasks_model.dart';
import 'package:high_performance/app/shared/db/db.dart';
import 'package:sqflite/sqflite.dart';

class TasksRepository extends Disposable {
  static final _table = "tasks";

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
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
