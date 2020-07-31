import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:high_performance/app/modules/tasks/tasks_page.dart';

main() {
  testWidgets('TasksPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(TasksPage(title: 'Tasks')));
    final titleFinder = find.text('Tasks');
    expect(titleFinder, findsOneWidget);
  });
}
