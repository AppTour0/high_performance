import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/modules/home/models/tasks_list_model.dart';
import 'package:high_performance/app/shared/db/db.dart';
import 'package:sqflite/sqflite.dart';

class TasksListRepository extends Disposable {
  static final _table = "tasks_list";

  Future<Database> _getDatabase() {
    return DatabaseHelper.instance.database;
  }

  Future<List<TasksListModel>> getTasksList() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(_table);

      return List.generate(
        maps.length,
        (i) {
          return TasksListModel(
            id: maps[i]['id'],
            idTask: maps[i]['task_id'],
            dateCreate: maps[i]['date_create'],
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
  }

  /* 

  // Insere uma linha no banco de dados onde cada chave
  // no Map é um nome de coluna e o valor é o valor da coluna.
  // O valor de retorno é o id da linha inserida.
  Future<int> insert(TasksListModel row) async {
    final Database db = await _database();
    try {
      return await db.insert(_table, row.toMap());
    } catch (error) {
      print(error);
    }
    return null;
  }

  // Todas as linhas são retornadas como uma lista de mapas, onde cada mapa é
  // uma lista de valores-chave de colunas.
  Future<List<TasksListModel>> queryAllRows() async {
    final Database db = await _database();
    try {
      final List<Map<String, dynamic>> task = await db.query(_table);

      return List.generate(task.length, (i) {
        return TasksListModel(
          id: task[i]['id'],
          idTask: task[i]['id_task'],
          dateModification: task[i]['date_modification'],
        );
      });
    } catch (error) {
      print(error);
    }
    return null;
  }

  // também podem ser feitos usando  comandos SQL brutos.
  // Esse método usa uma consulta bruta para fornecer a contagem de linhas.
  Future<int> queryRowCount() async {
    final Database db = await _database();
    try {
      return Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM $_table'));
    } catch (error) {
      print(error);
    }
    return null;
  }

  // Assumimos aqui que a coluna id no mapa está definida. Os outros
  // valores das colunas serão usados para atualizar a linha.
  Future<int> update(TasksListModel row) async {
    final Database db = await _database();
    try {
      return await db
          .update(_table, row.toMap(), where: 'id = ?', whereArgs: [row.id]);
    } catch (error) {
      print(error);
    }
    return null;
  }

  // Exclui a linha especificada pelo id. O número de linhas afetadas é
  // retornada. Isso deve ser igual a 1, contanto que a linha exista.
  Future<int> delete(id) async {
    final Database db = await _database();
    try {
      return await db.delete(_table, where: 'id = ?', whereArgs: [id]);
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future<TasksListModel> findById(id) async {
    final Database db = await _database();
    try {
      List<Map<String, dynamic>> maps = await db.query("$_table",
          columns: ["id", "name", "date_modification", "date_create"],
          where: 'id = ?',
          whereArgs: [id]);

      if (maps.first.length > 0) {
        return TasksListModel.fromMap(maps.first);
      }
    } catch (error) {
      print(error);
    }

    return null;
  } */

  //dispose will be called automatically
  @override
  void dispose() {}
}
