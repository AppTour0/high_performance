import 'package:high_performance/app/modules/tasks/tasks_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/modules/tasks/tasks_page.dart';

class TasksModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => TasksController()),
      ];

  @override
  List<Router> get routers => [
        Router('/:id', child: (_, args) => TasksPage(id: args.data)),
      ];

  static Inject get to => Inject<TasksModule>.of();
}
