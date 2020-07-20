import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/components/custom_tile/custom_tile.dart';
import 'package:high_performance/app/components/custom_tile/tile_model.dart';
import 'package:high_performance/app/modules/home/home_controller.dart';
import 'package:high_performance/app/modules/home/home_module.dart';
import 'package:high_performance/app/modules/tasks/alarm.dart';
import 'package:high_performance/app/modules/tasks/tasks_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:high_performance/app/shared/db/database.dart';
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
        /* floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Alarm()),
            );
          },
          child: Icon(Icons.add),
        ), */
        floatingActionButton: FloatingActionButton(
          //onPressed: _modalAdd,
          onPressed: () async {
            await Modular.to
                .pushNamed("/tasks", arguments: 0)
                .whenComplete(() => controller.getList());
          },
          child: Icon(Icons.add),
        ),
        body: Observer(
          builder: (context) {
            if (controller.tasksList.data == null) {
              return Center(child: CircularProgressIndicator());
            }

            List<TasksListWithTask> data = controller.tasksList.data;

            if (data.length == 0) {
              return Center(child: Text("Não há tarefas"));
            }

            List<TileModel> tileModel = List.generate(
              data.length,
              (i) {
                return TileModel(
                    id: data[i].taskList.id,
                    title: data[i].task.name,
                    subtitle:
                        DateFormat.yMd().format(DateTime.now()).toString());
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
          },
        ));
  }
}
