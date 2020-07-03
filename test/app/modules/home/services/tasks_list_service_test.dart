import 'package:flutter_test/flutter_test.dart';

import 'package:high_performance/app/modules/home/services/tasks_list_service.dart';

void main() {
  TasksListService service;

  setUp(() {
    service = TasksListService();
  });

  group('TasksListService Test', () {
    test("First Test", () {
      expect(service, isInstanceOf<TasksListService>());
    });
  });
}
