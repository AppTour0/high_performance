import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:high_performance/app/app/modules/tasks/tasks_detail/tasks_detail_page.dart';

main() {
  testWidgets('TasksDetailPage has title', (WidgetTester tester) async {
    await tester
        .pumpWidget(buildTestableWidget(TasksDetailPage(title: 'TasksDetail')));
    final titleFinder = find.text('TasksDetail');
    expect(titleFinder, findsOneWidget);
  });
}
