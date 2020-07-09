import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/components/custom_tile/custom_tile.dart';
import 'package:high_performance/app/components/custom_tile/tile_model.dart';
import 'package:high_performance/app/modules/home/home_controller.dart';
import 'package:high_performance/app/modules/home/home_module.dart';
import 'package:high_performance/app/modules/home/models/tasks_list_model.dart';
import 'package:high_performance/app/modules/tasks/tasks_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Lista de Tarefas"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeModule.to.get<HomeController>();
  List<TasksModel> task;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          /* title: controller.tasksList.length == null
              ? Text(widget.title)
              : Text(
                  widget.title + " " + controller.tasksList.length.toString()), */
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          //onPressed: _modalAdd,
          onPressed: () async {
            await Modular.to
                .pushNamed("/tasks", arguments: null)
                .whenComplete(() => controller.getList());
          },
          child: Icon(Icons.add),
        ),
        body: Observer(
          builder: (context) {
            /* if (controller.tasksList.isEmpty || controller.tasks.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } */

            if (controller.tasksList.isEmpty || controller.tasks.isEmpty) {
              return Center(child: Text("Não há tarefas"));
            }

            List<TasksListModel> listTasks = controller.tasksList.toList();

            List<TileModel> tileModel = List.generate(
              listTasks.length,
              (i) {
                return TileModel(
                    id: listTasks[i].id,
                    title: listTasks[i].name,
                    subtitle: listTasks[i].dateCreate.toString());
              },
            );

            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: CustomTile(
                list: tileModel,
                route: "/tasks",
                tapAction: controller.getList(),
              ),
            );

            /* ListView.builder(
              shrinkWrap: true,
              itemCount: controller.tasksList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                int idTask = controller.tasksList[index].idTask;
                task = controller.tasks.where((e) => e.id == idTask).toList();
                List<TasksListModel> listTasks = controller.tasksList.toList();

                return Center(
                    child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(task[0].name),
                      subtitle: Text(
                          controller.tasksList[index].dateCreate.toString()),
                      trailing: Wrap(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () => setState(() {
                              controller.delete(controller.tasksList[index].id);
                              controller.getList();
                            }),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.deepPurple,
                              ),
                              onPressed: () async {
                                await Modular.to
                                    .pushNamed("/tasks",
                                        arguments: listTasks[index])
                                    .whenComplete(() => controller.getList());
                                /* _modalUpdate(
                                    model: controller.tasksList[index]); */
                              }),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ));
              },
            ); */
          },
        ));
  }

  _modalAdd({TasksListModel model}) {
    model ??= TasksListModel(idTask: null);
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Adicionar'),
            content: TextFormField(
              onChanged: (v) {
                model = TasksListModel(
                    idTask: int.tryParse(v),
                    dateCreate: DateTime.now().toString());
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'escreva...',
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Modular.to.pop();
                },
                child: Text('Cancelar'),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    controller.save(model);
                    controller.getList();
                  });

                  Modular.to.pop();
                },
                child: Text('Adicionar'),
              ),
            ],
          );
        });
  }

  _modalUpdate({TasksListModel model}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Alterar"),
            content: TextFormField(
              initialValue: model.idTask.toString(),
              onChanged: (v) =>
                  model = TasksListModel(idTask: int.tryParse(v), id: model.id),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'escreva...',
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Modular.to.pop();
                },
                child: Text('Cancelar'),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    controller.update(model);
                    controller.getList();
                  });

                  Modular.to.pop();
                },
                child: Text('Alterar'),
              ),
            ],
          );
        });
  }
}
