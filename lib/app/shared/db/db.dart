import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/* class DatabaseHelper {
  static final _databaseName = "high_p.db";
  static final _databaseVersion = 1;
// torna esta classe singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // tem somente uma referência ao banco de dados
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database;
  }

  // abre o banco de dados e o cria se ele não existir
  static _initDatabase() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, _databaseName);

      return await openDatabase(path,
          version: _databaseVersion,
          onCreate: _onCreate,
          onConfigure: _onConfigure);
    } catch (error) {
      print(error);
    }
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
    print('Foreign keys turned on');
  }

  // Código SQL para criar o banco de dados e a tabela
  static Future _onCreate(Database db, int version) async {
    var sql = [
      //'''DROP TABLE IF EXISTS tasks;''',
      //'''DROP TABLE IF EXISTS tasks_list;''',

      '''create table if not exists tasks (
            id integer primary key autoincrement,
            name text,
            date_create datetime,
            date_modification datetime
            );''',

      '''create table if not exists tasks_list (
            id integer primary key autoincrement,
            alarm integer,
            mon integer,
            tue integer,
            wed integer,
            thu integer,
            fri integer,
            sat integer,
            sun integer,
            amount integer,
            time datetime,
            description text,
            date_modification datetime,
            date_create datetime,
            task_id int NOT NULL,
            foreign key (task_id) references tasks (id) ON DELETE CASCADE
          );''',

      '''insert into tasks (name,date_create, date_modification) values('Acordar cedo',strftime(datetime('now')), strftime(datetime('now')));''',
      '''insert into tasks (name,date_create, date_modification) values('Ler livro',strftime(datetime('now')), strftime(datetime('now')));''',
      '''insert into tasks (name,date_create, date_modification) values('Beber água',strftime(datetime('now')), strftime(datetime('now')));''',

      '''insert into tasks_list (date_create, task_id, alarm, mon, tue, wed, thu, 
                                fri, sat, sun, amount, time, description, date_modification)
                 values(strftime(datetime('now')),1, 1, 1, 1, 1, 1, 0,
                    1, 0, 1, strftime(datetime('now')), "Agradecer", strftime(datetime('now')));''',

      '''insert into tasks_list (date_create, task_id, alarm, mon, tue, wed, thu, fri, sat, sun, amount, time, description, date_modification)
                 values(strftime(datetime('now')),1, 1, 1, 1, 1, 1, 1, 1, 1, 2, strftime(datetime('now')), "Orar", strftime(datetime('now')));''',
      '''insert into tasks_list (date_create, task_id, alarm, mon, tue, wed, thu, fri, sat, sun, amount, time, description, date_modification)
                 values(strftime(datetime('now')),1, 0, 0, 0, 0, 0, 0, 0, 0, 0, strftime(datetime('now')), "", strftime(datetime('now')));''',
    ];

    for (var i = 0; i < sql.length; i++) {
      print("execute sql : " + sql[i]);
      await db.execute(sql[i]).catchError((onError) => print(onError));
    }
  }
}
 */
