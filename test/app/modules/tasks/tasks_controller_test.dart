import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:high_performance/app/modules/tasks/tasks_controller.dart';
import 'package:high_performance/app/modules/tasks/tasks_module.dart';

void main() {
  initModule(TasksModule());
  TasksController tasks;

  setUp(() {
    tasks = TasksModule.to.bloc<TasksController>();
  });

  group('TasksController Test', () {
    test("First Test", () {
      expect(tasks, isInstanceOf<TasksController>());
    });

    test("Set Value", () {
      expect(tasks.value, equals(0));
      tasks.increment();
      expect(tasks.value, equals(1));
    });
  });
}
