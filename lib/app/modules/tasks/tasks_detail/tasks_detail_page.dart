import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/modules/tasks/tasks_detail/tasks_detail_controller.dart';
import 'package:high_performance/app/modules/tasks/tasks_detail/tasks_detail_module.dart';
import 'package:high_performance/app/shared/db/database.dart';
import 'package:high_performance/app/shared/utils/utils.dart';
import 'package:intl/intl.dart';

class TasksDetailPage extends StatefulWidget {
  final String title;
  final int id;
  const TasksDetailPage({Key key, this.title = "Detalhes", this.id})
      : super(key: key);

  @override
  _TasksDetailPageState createState() => _TasksDetailPageState();
}

class _TasksDetailPageState extends State<TasksDetailPage> {
  final controller = TasksDetailModule.to.get<TasksDetailController>();
  final now = new DateTime.now();
  Utils utils = Utils();
  String formatDate;

  @override
  void initState() {
    super.initState();
    controller.getTask(widget.id);

    /* interstitialAd = AdmobInterstitial(
      adUnitId: _adManager.interstitialAdUnitId,
    );
    interstitialAd.load(); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                delete();
              },
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Modular.to.pushNamed('/tasks', arguments: widget.id);
              },
            )
          ],
        ),
        body: Observer(builder: (context) {
          if (controller.task.data == null) {
            return Center(child: CircularProgressIndicator());
          }

          List<Task> data = controller.task.data;

          if (data.length == 0) {
            return Center(child: Text("Algo deu errado"));
          }

          data[0].repeat
              ? formatDate = "kk:mm"
              : formatDate = "dd/mm/yyyy - kk:mm";

          return SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Text(data[0].name),
              Text(DateFormat(formatDate).format(data[0].dateTimeNotification)),
            ],
          ));
        }));
  }

  delete() async {
    String title = "Atenção!!!";
    String value = "Deseja realente excluir esta tarefa?";
    utils
        .asyncConfirmDialog(
            context: context, title: title, value: value, color: Colors.red)
        .then((value) => {
              if (value.index == 1)
                {
                  controller.delete(
                    widget.id,
                    onError: (title, description) => utils.flushBarDanger(
                        context: context,
                        title: title,
                        description: description),
                    onSuccess: () {
                      Modular.to.pop();
                      utils.flushBarSuccess(
                          positionBottom: true,
                          context: context,
                          title: "Sucesso!",
                          description: "Tarefa deletada com sucesso.");
                    },
                  )
                }
            });
  }
}
