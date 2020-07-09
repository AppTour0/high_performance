import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/components/choose_modal.dart';
import 'package:high_performance/app/modules/home/models/tasks_list_model.dart';
import 'package:high_performance/app/modules/tasks/tasks_controller.dart';
import 'package:high_performance/app/modules/tasks/tasks_model.dart';
import 'package:high_performance/app/modules/tasks/tasks_module.dart';

class TasksPage extends StatefulWidget {
  final String title;
  //final TasksListModel model;
  final int id;
  const TasksPage({Key key, this.title = "Tarefa", this.id}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final controller = TasksModule.to.get<TasksController>();
  final ChooseModal chooseModal = ChooseModal();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.getTask(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.id == null
              ? Text("Adicionar " + widget.title)
              : Text("Editar " + widget.title),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  save();
                },
              ),
            )
          ],
        ),
        body: Observer(builder: (context) {
          if (controller.tasks.length == 0) {
            return Center(child: CircularProgressIndicator());
          }

          TasksListModel data;
          if (controller.taskList.isNotEmpty) {
            data = controller.taskList.last;

            controller.idTaskList = data.id;
            controller.idTaskEditing.text = data.idTask.toString();
            controller.taskEditing.text = controller.tasks
                .where((element) => element.id == data.idTask)
                .last
                .name;
          }

          List<TasksModel> tasksModel = controller.tasks.toList();
          List<Map<String, dynamic>> list = [];
          list.clear();
          for (var item in tasksModel) {
            list.add({"id": item.id, "title": item.name});
          }

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    task(list),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  Widget task(List<Map<String, dynamic>> list) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: TextFormField(
            controller: controller.taskEditing,
            keyboardType: TextInputType.text,
            readOnly: true,
            onTap: () {
              chooseModal.choose(
                  context: context,
                  list: list,
                  idEditing: controller.idTaskEditing,
                  textEditing: controller.taskEditing);
            },
            onChanged: (value) {
              print(value);
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'A tarefa não pode ser vazia';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: 'Selecione uma tarefa',
                labelText: 'Tarefa',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).accentColor,
                    size: 30,
                  ),
                  onPressed: () {},
                ))));
  }

  save() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      await controller
          .submit(controller.taskList.isEmpty ? null : controller.taskList.last

              /* onError: (title, description) async {

            },
            onSuccess: (title, description) async {
              
            } */
              )
          .then(
            (value) => Modular.to.pop(),
          );
    }
  }
}
