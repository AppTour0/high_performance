import 'package:high_performance/app/modules/home/tasks_list_repository.dart';
import 'package:high_performance/app/modules/tasks/tasks_repository.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  BoolColumn get alarm => boolean().withDefault(const Constant(false))();
  BoolColumn get mon => boolean().withDefault(const Constant(false))();
  BoolColumn get tue => boolean().withDefault(const Constant(false))();
  BoolColumn get wed => boolean().withDefault(const Constant(false))();
  BoolColumn get thu => boolean().withDefault(const Constant(false))();
  BoolColumn get fri => boolean().withDefault(const Constant(false))();
  BoolColumn get sat => boolean().withDefault(const Constant(false))();
  BoolColumn get sun => boolean().withDefault(const Constant(false))();
  BoolColumn get repeat => boolean().withDefault(const Constant(false))();
  BoolColumn get unique => boolean().withDefault(const Constant(false))();
  TextColumn get message => text()();
  DateTimeColumn get dateTimeNotification => dateTime()();
  DateTimeColumn get dateCreate => dateTime()();
  DateTimeColumn get dateModify => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class TasksDetail extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idTask => integer().customConstraint('REFERENCES Tasks(id)')();
  BoolColumn get confirm => boolean().withDefault(const Constant(false))();
  DateTimeColumn get dateConfirm => dateTime()();
  DateTimeColumn get dateCreate => dateTime()();
  DateTimeColumn get dateModify => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/* class TasksListWithTask {
  final TasksListData taskList;
  final Task task;

  TasksListWithTask({
    @required this.taskList,
    @required this.task,
  });
} */

@UseMoor(
    tables: [Tasks, TasksDetail], daos: [TasksRepository, TasksListRepository])
class Database extends _$Database {
  static Database instance = Database._internal();

  TasksRepository tasksRepository;
  TasksListRepository tasksListRepository;

  Database._internal()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "high_p.sqlite", logStatements: true)) {
    tasksRepository = TasksRepository(this);
    tasksListRepository = TasksListRepository(this);
  }

  /* List<Tasks> tasksInit = [
    Tasks(
      id: null,
      name: "Acordar cedo",
      dateCreate: DateTime.now(),
      dateModify: DateTime.now(),
    ),
    Tasks(
      id: null,
      name: "Ler um Livro",
      dateCreate: DateTime.now(),
      dateModify: DateTime.now(),
    ),
    Tasks(
      id: null,
      name: "Meditar",
      dateCreate: DateTime.now(),
      dateModify: DateTime.now(),
    ),
  ]; */

  @override
  int get schemaVersion => 1;
  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          if (details.wasCreated) {
            /* tasksInit.forEach((element) async {
              await tasksRepository.insertData(element);
            }); */
          }
        },
      );
}
