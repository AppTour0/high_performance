import 'package:admob_flutter/admob_flutter.dart';
import 'package:calendarro/calendarro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/modules/tasks/tasks_arguments.dart';
import 'package:high_performance/app/modules/tasks/tasks_detail/tasks_detail_controller.dart';
import 'package:high_performance/app/modules/tasks/tasks_detail/tasks_detail_module.dart';
import 'package:high_performance/app/shared/db/database.dart';
import 'package:high_performance/app/shared/utils/admob/ad_manager.dart';
import 'package:high_performance/app/shared/utils/utils.dart';
import 'package:high_performance/app/shared/utils/week_custom.dart';
import 'package:intl/intl.dart';

class TasksDetailPage extends StatefulWidget {
  final TasksArguments args;
  const TasksDetailPage({Key key, this.args}) : super(key: key);

  @override
  _TasksDetailPageState createState() => _TasksDetailPageState();
}

class _TasksDetailPageState extends State<TasksDetailPage> {
  final controller = TasksDetailModule.to.get<TasksDetailController>();
  final now = new DateTime.now();
  Utils utils = Utils();
  String formatDate;
  AdManager _adManager = AdManager();
  AdmobBannerSize bannerSize;
  AdmobBanner bannerAd;

  @override
  void initState() {
    super.initState();
    controller.getTask(widget.args.id);

    bannerSize = AdmobBannerSize.MEDIUM_RECTANGLE;

    bannerAd = AdmobBanner(
      adUnitId: _adManager.bannerAdUnitId,
      adSize: bannerSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.args.title),
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
                Modular.to.pushNamed('/tasks', arguments: widget.args.id);
              },
            )
          ],
        ),
        body: Observer(builder: (context) {
          if (controller.task.data == null ||
              controller.habitsCompleted.data == null) {
            return Center(child: CircularProgressIndicator());
          }

          List<Task> data = controller.task.data;
          List<TasksDetailData> dataDetail = controller.habitsCompleted.data;

          if (data.length == 0) {
            return Center(child: Text("Algo deu errado"));
          }

          data[0].repeat
              ? formatDate = "kk:mm"
              : formatDate = "dd/mm/yyyy - kk:mm";

          List<DateTime> dateList = [];
          List<TasksDetailData> dateListOfTask = [];

          dateListOfTask = dataDetail
              .where((element) => element.idTask == data[0].id)
              .toList();

          dateList = List.generate(dateListOfTask.length, (index) {
            return dateListOfTask[index].dateConfirm;
          });

          List<String> days = [];
          data[0].sun
              ? days.add(
                  controller.daysOfWeek[0]['label'].toString().substring(0, 3))
              : null;
          data[0].mon
              ? days.add(
                  controller.daysOfWeek[1]['label'].toString().substring(0, 3))
              : null;
          data[0].tue
              ? days.add(
                  controller.daysOfWeek[2]['label'].toString().substring(0, 3))
              : null;
          data[0].wed
              ? days.add(
                  controller.daysOfWeek[3]['label'].toString().substring(0, 3))
              : null;
          data[0].thu
              ? days.add(
                  controller.daysOfWeek[4]['label'].toString().substring(0, 3))
              : null;
          data[0].fri
              ? days.add(
                  controller.daysOfWeek[5]['label'].toString().substring(0, 3))
              : null;
          data[0].sat
              ? days.add(
                  controller.daysOfWeek[6]['label'].toString().substring(0, 3))
              : null;

          TextStyle textStyle = TextStyle(fontSize: 16);
          return SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.repeat),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Repetir: ",
                            style: textStyle,
                          ),
                          Text(
                            days
                                .toString()
                                .replaceAll(RegExp(r"(\[)|(\])"), ''),
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.timer),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat(formatDate)
                              .format(data[0].dateTimeNotification),
                          style: textStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black26,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Calendarro(
                      selectionMode: SelectionMode.MULTI,
                      weekdayLabelsRow: CustomWeekdayLabelsRow(),
                      selectedDates: dateList,
                      selectedSingleDate: now,
                      displayMode: DisplayMode.MONTHS,
                      onTap: (datetime) {
                        List<TasksDetailData> dateFilter = dateListOfTask
                            .where((element) => element.dateConfirm == datetime)
                            .toList();
                        dateFilter.length == 0
                            ? controller.insertDetail(datetime, data[0].id)
                            : controller.deleteDetail(dateFilter[0].id);
                      },
                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              bannerAd,
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
                    widget.args.id,
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
