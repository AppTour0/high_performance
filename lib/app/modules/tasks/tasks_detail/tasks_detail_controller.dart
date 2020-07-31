import 'package:mobx/mobx.dart';

part 'tasks_detail_controller.g.dart';

class TasksDetailController = _TasksDetailBase with _$TasksDetailController;

abstract class _TasksDetailBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
