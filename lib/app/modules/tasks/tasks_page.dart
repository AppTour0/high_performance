import 'dart:isolate';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/components/choose_modal.dart';
import 'package:high_performance/app/components/dialogs/input_dialog.dart';
import 'package:high_performance/app/modules/tasks/tasks_controller.dart';
import 'package:high_performance/app/modules/tasks/tasks_module.dart';
import 'package:high_performance/app/shared/db/database.dart';

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
  final InputDialog inputDialog = InputDialog();
  final _formKey = GlobalKey<FormState>();
  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String _date = "Not set";
  String _time = "Not set";

  final int helloAlarmID = 0;

  @override
  void initState() {
    super.initState();
    controller.getTask(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.id == 1
              ? Text("Editar " + widget.title)
              : Text("Adicionar " + widget.title),
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.notifications),
          onPressed: () async {
            DateTime now = DateTime.now().toUtc().add(
                  Duration(seconds: 10),
                );
            await singleNotification(
              now,
              "Notification",
              "This is a notification",
              98123871,
            );
          },
        ),
        body: Observer(builder: (context) {
          if (controller.taskList.data == null ||
              controller.tasks.data == null) {
            return Center(child: CircularProgressIndicator());
          }

          List<TasksListWithTask> dataList = controller.taskList.data;
          List<Task> dataTask = controller.tasks.data;

          if (dataList.length > 0 && controller.idTaskList == 0) {
            controller.idTaskList = dataList[0].taskList.id;
            controller.idTaskEditing.text =
                dataList[0].taskList.idTask.toString();
            controller.taskEditing.text = dataList[0].task.name;
            controller.alarm = dataList[0].taskList.alarm;
            controller.daysWeekCheck['mon'] = dataList[0].taskList.mon;
            controller.daysWeekCheck['tue'] = dataList[0].taskList.tue;
            controller.daysWeekCheck['wed'] = dataList[0].taskList.wed;
            controller.daysWeekCheck['thu'] = dataList[0].taskList.thu;
            controller.daysWeekCheck['fri'] = dataList[0].taskList.fri;
            controller.daysWeekCheck['sat'] = dataList[0].taskList.sat;
            controller.daysWeekCheck['sun'] = dataList[0].taskList.sun;
            /* controller.taskEditing.text = controller.tasks
                .where((element) => element.id == data.idTask)
                .last
                .name; */
          }

          List<Map<String, dynamic>> list = [];
          if (dataTask.length > 0) {
            for (var item in dataTask) {
              list.add({"id": item.id, "title": item.name});
            }
          }

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    task(list),
                    addTask(list),
                    daysOfWeek(),
                    datePicker(),
                    SizedBox(
                      height: 20.0,
                    ),
                    timePicker(),
                    alarmTest(),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  /* ==========================  Widgets ================================ */

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

  Widget addTask(List<Map<String, dynamic>> list) {
    return IconButton(
      onPressed: () {
        inputDialog.showInput(
            context: context,
            changedAction: null,
            tapAction: tapAction,
            textEditing: controller.nameTaskEditing);
      },
      icon: Icon(Icons.add_circle),
    );
  }

  tapAction() {
    List<TasksListWithTask> dataList = controller.taskList.data;
    controller.submitTask(dataList);
    controller.getTasks();
  }

  Widget datePicker() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 4.0,
      onPressed: () {
        _selectDateTime(context);
      },
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.date_range,
                        size: 18.0,
                        color: Colors.teal,
                      ),
                      Text(
                        " $_date",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Text(
              "  Change",
              style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ],
        ),
      ),
      color: Colors.white,
    );
  }

  Widget timePicker() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 4.0,
      onPressed: () {
        _selectTime(context);
        setState(() {});
      },
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        size: 18.0,
                        color: Colors.teal,
                      ),
                      Text(
                        " $_time",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Text(
              "  Change",
              style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ],
        ),
      ),
      color: Colors.white,
    );
  }

  Widget alarmTest() {
    return RaisedButton(
        onPressed: () async {
          await AndroidAlarmManager.periodic(
              const Duration(minutes: 1), helloAlarmID, printHello);
        },
        child: Text("Alarme"));
  }

  Widget daysOfWeek() {
    List<Widget> items = new List<Widget>();

    Widget buildItemCheck(String key, String value) {
      return Observer(builder: (_) {
        return Column(
          children: <Widget>[
            Text(value),
            Checkbox(
              value: controller.daysWeekCheck[key],
              onChanged: (bool value) {
                controller.daysWeekCheck[key] = value;
              },
            ),
          ],
        );
      });

      /* return Expanded(child: Observer(builder: (_) {
        return Column(children: <Widget>[
          Text(value),
          Checkbox(
            value: controller.daysWeekCheck[key],
            onChanged: (bool value) {
              controller.daysWeekCheck[key] = value;
            },
          )
        ]);
      })); */
    }

    controller.daysWeek.forEach((key, value) {
      items.add(buildItemCheck(key, value));
    });

    for (var item in items)
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(child: item),
        ],
      );
  }

  /* =========================== Functions ================================ */

  save() async {
    List<TasksListWithTask> dataList = controller.taskList.data;
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      await controller
          .submitList(
            dataList,

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

  Future<TimeOfDay> _selectTime(BuildContext context) {
    final now = DateTime.now();

    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
  }

  Future<DateTime> _selectDateTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(seconds: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );

  Future singleNotification(
      DateTime datetime, String message, String subtext, int hashcode,
      {String sound}) async {
    var androidChannel = AndroidNotificationDetails(
      'channel-id',
      'channel-name',
      'channel-description',
      importance: Importance.Max,
      priority: Priority.Max,
    );

    var iosChannel = IOSNotificationDetails();
    var platformChannel = NotificationDetails(androidChannel, iosChannel);
    localNotificationsPlugin.schedule(
        hashcode, message, subtext, datetime, platformChannel,
        payload: hashcode.toString());
  }

  void printHello() {
    final DateTime now = DateTime.now();
    final int isolateId = Isolate.current.hashCode;
    print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
  }
}
