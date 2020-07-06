import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/modules/home/home_controller.dart';
import 'package:high_performance/app/modules/home/home_module.dart';
import 'package:high_performance/app/modules/home/models/tasks_list_model.dart';
import 'package:high_performance/app/modules/home/models/tasks_model.dart';
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

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: controller.tasksList.length == null
              ? Text(widget.title)
              : Text(
                  widget.title + " " + controller.tasksList.length.toString()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _modalAdd,
          child: Icon(Icons.add),
        ),
        body: Observer(
          builder: (context) {
            if (controller.tasksList.length == null) {
              return Center(child: CircularProgressIndicator());
            }

            if (controller.tasksList.length == 0) {
              return Center(child: Text("Não há dados"));
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.tasksList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                int idTask = controller.tasksList[index].idTask;
                List<TasksModel> task =
                    controller.tasks.where((e) => e.id == idTask).toList();

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
                              onPressed: () {
                                _modalUpdate(
                                    model: controller.tasksList[index]);
                              }),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ));
              },
            );
          },
        )

        /* FutureBuilder<List<TasksModel>>(
          future: controller.getList(),
          builder: (BuildContext context, snapshot) {
            Widget child;

            if (snapshot.hasData) {
              child = ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Center(
                      child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(snapshot.data[index].name),
                        subtitle: Text(
                            snapshot.data[index].dateModification.toString()),
                        trailing: Wrap(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () => setState(() {
                                controller.delete(snapshot.data[index].id);
                              }),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.deepPurple,
                              ),
                              onPressed: () =>
                                  _modalUpdate(model: snapshot.data[index]),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ));
                },
              );
            } else if (snapshot.hasError) {
              child = Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              );
            } else {
              child = Center(child: CircularProgressIndicator());
            }
            return Container(
              child: child,
            );
          },
        ) */
        );
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
