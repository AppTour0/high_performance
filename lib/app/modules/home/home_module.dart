import 'package:high_performance/app/modules/home/repositories/tasks_list_repository.dart';
import 'package:high_performance/app/modules/home/repositories/tasks_repository.dart';
import 'package:high_performance/app/modules/home/services/tasks_list_service.dart';
import 'package:high_performance/app/modules/home/services/tasks_service.dart';
import 'package:high_performance/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/modules/home/home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => TasksListRepository()),
        Bind((i) => TasksRepository()),
        Bind((i) => TasksListService()),
        Bind((i) => TasksService()),
        Bind((i) => HomeController()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
