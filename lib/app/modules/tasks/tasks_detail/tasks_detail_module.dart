import 'package:high_performance/app/modules/tasks/tasks_detail/tasks_detail_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/modules/tasks/tasks_detail/tasks_detail_page.dart';

class TasksDetailModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => TasksDetailController()),
      ];

  @override
  List<Router> get routers => [
        Router('/:id', child: (_, args) => TasksDetailPage(id: args.data)),
      ];

  static Inject get to => Inject<TasksDetailModule>.of();
}
