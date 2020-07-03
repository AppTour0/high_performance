import 'package:flutter_test/flutter_test.dart';

import 'package:high_performance/app/modules/home/services/tasks_service.dart';

void main() {
  TasksService service;

  setUp(() {
    service = TasksService();
  });

  group('TasksService Test', () {
    test("First Test", () {
      expect(service, isInstanceOf<TasksService>());
    });
  });
}
