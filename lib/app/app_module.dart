import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/app_controller.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:high_performance/app/app_widget.dart';
import 'package:high_performance/app/modules/home/home_module.dart';
import 'package:high_performance/app/modules/tasks/tasks_detail/tasks_detail_module.dart';
import 'package:high_performance/app/modules/tasks/tasks_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
      ];

  @override
  List<Router> get routers => [
        Router('/', module: HomeModule()),
        //Router('/tasks', child: (_, args) => TasksPage()),
        Router('/tasks', module: TasksModule()),
        Router('/tasksDetail', module: TasksDetailModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
