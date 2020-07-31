import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:high_performance/app/modules/tasks/tasks_detail/tasks_detail_controller.dart';
import 'package:high_performance/app/modules/tasks/tasks_detail/tasks_detail_module.dart';

void main() {
  initModule(TasksDetailModule());
  TasksDetailController tasksdetail;

  setUp(() {
    tasksdetail = TasksDetailModule.to.bloc<TasksDetailController>();
  });

  group('TasksDetailController Test', () {
    test("First Test", () {
      expect(tasksdetail, isInstanceOf<TasksDetailController>());
    });

    test("Set Value", () {
      expect(tasksdetail.value, equals(0));
      tasksdetail.increment();
      expect(tasksdetail.value, equals(1));
    });
  });
}
