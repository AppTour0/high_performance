import 'package:high_performance/app/modules/home/services/tasks_list_service.dart';
import 'package:high_performance/app/modules/home/services/tasks_service.dart';
import 'package:high_performance/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/modules/home/home_page.dart';
import 'package:high_performance/app/modules/home/interfaces/tasks_list_interface.dart';
import 'package:high_performance/app/modules/home/interfaces/tasks_interface.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        //Bind((i) => TasksListRepository()),
        //Bind((i) => TasksRepository()),
        Bind<ITasksListService>(
            (i) => TasksListService(tasksListRepository: i.get())),
        Bind<ITasksService>((i) => TasksService(tasksRepository: i.get())),
        Bind((i) => HomeController()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
