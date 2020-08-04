import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/components/choose_modal.dart';
import 'package:high_performance/app/components/dialogs/input_dialog.dart';
import 'package:high_performance/app/components/inputs.dart';
import 'package:high_performance/app/modules/tasks/tasks_controller.dart';
import 'package:high_performance/app/modules/tasks/tasks_module.dart';
import 'package:high_performance/app/shared/db/database.dart';
import 'package:high_performance/app/shared/utils/admob/ad_manager.dart';
import 'package:high_performance/app/shared/utils/utils.dart';
import 'package:high_performance/app/shared/utils/validators.dart';
import 'package:intl/intl.dart';

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
  final now = new DateTime.now();
  final _formKey = GlobalKey<FormState>();
  Utils utils = Utils();
  Validators validators = Validators();

  String _date = "Selecione uma data";
  String _time = "Selecione um horário";

  String hintText;
  String labelText;

  final int helloAlarmID = 0;

  AdManager _adManager = AdManager();
  AdmobInterstitial interstitialAd;

  @override
  void initState() {
    super.initState();
    controller.getTask(widget.id);

    interstitialAd = AdmobInterstitial(
      adUnitId: _adManager.interstitialAdUnitId,
      /* listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      }, */
    );
    interstitialAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.id > 0
              ? Text("Editar " + widget.title)
              : Text("Adicionar " + widget.title),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  save();
                },
              ),
            ),
          ],
        ),
        body: Observer(builder: (context) {
          if (controller.task.data == null) {
            return Center(child: CircularProgressIndicator());
          }

          List<Task> task = controller.task.data;

          if (task.length > 0 && controller.idTask == 0) {
            String formatCoditional =
                task[0].repeat ? "kk:mm" : "dd/mm/yyyy - kk:mm";
            controller.idTask = task[0].id;
            controller.taskEditing.text = task[0].name;
            controller.alarm = task[0].alarm;
            controller.daysOfWeek[1]['bool'] = task[0].mon;
            controller.daysOfWeek[2]['bool'] = task[0].tue;
            controller.daysOfWeek[3]['bool'] = task[0].wed;
            controller.daysOfWeek[4]['bool'] = task[0].thu;
            controller.daysOfWeek[5]['bool'] = task[0].fri;
            controller.daysOfWeek[6]['bool'] = task[0].sat;
            controller.daysOfWeek[0]['bool'] = task[0].sun;
            controller.dateEditing.text = DateFormat(formatCoditional)
                .format(task[0].dateTimeNotification);
            controller.datetimeToDb = task[0].dateTimeNotification;
            controller.messageEditing.text = task[0].message;
            controller.repeat = task[0].repeat;
            /* controller.taskEditing.text = controller.tasks
                .where((element) => element.id == data.idTask)
                .last
                .name; */
          }

          if (controller.repeat) {
            hintText = "Selecione um horário";
            labelText = "Selecione um horário";
          } else {
            hintText = "Selecione uma data e hora";
            labelText = "Selecione uma data e hora";
          }

          /* List<Map<String, dynamic>> list = [];
          if (dataTask.length > 0) {
            for (var item in dataTask) {
              list.add({"id": item.id, "title": item.name});
            }
          } */

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomInput(
                      editingController: controller.taskEditing,
                      inputType: TextInputType.text,
                      hintText: "Nome do Hábito",
                      labelText: "Nome do Hábito",
                      validator: validators.validateNotEmptyForm,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: <Widget>[
                        Switch(
                          value: controller.repeat,
                          onChanged: (value) {
                            controller.repeat = value;
                            controller.switchBool(value);
                          },
                          activeTrackColor: Colors.blue[200],
                          activeColor: Theme.of(context).accentColor,
                        ),
                        customText("Repetir"),
                      ],
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 400),
                      firstChild: Container(
                        height: 0,
                      ),
                      secondChild: Column(
                        children: <Widget>[
                          daysOfWeek(),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                      crossFadeState: !controller.repeat
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomInput(
                        editingController: controller.dateEditing,
                        inputType: TextInputType.text,
                        hintText: hintText,
                        labelText: labelText,
                        icon:
                            controller.repeat ? Icons.timer : Icons.date_range,
                        readOnly: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Theme.of(context).accentColor,
                            size: 30,
                          ),
                          onPressed: () {},
                        ),
                        validator: !controller.repeat
                            ? validators.validateEmpty
                            : validators.validateNotEmptyForm,
                        onTap: () {
                          controller.repeat
                              ? _selectTime(context).then((value) => {
                                    controller.datetimeToDb = DateTime(
                                        now.year,
                                        now.month,
                                        now.day,
                                        value.hour,
                                        value.minute),
                                    controller.dateEditing.text =
                                        DateFormat("kk:mm")
                                            .format(controller.datetimeToDb)
                                  })
                              : _selectDateTime(context).then((value) => {
                                    controller.datetimeToDb = DateTime(
                                        value.year,
                                        value.month,
                                        value.day,
                                        now.hour,
                                        now.minute),
                                    _selectTime(context).then((value) => {
                                          controller.datetimeToDb = DateTime(
                                              controller.datetimeToDb.year,
                                              controller.datetimeToDb.month,
                                              controller.datetimeToDb.day,
                                              value.hour,
                                              value.minute),
                                          controller.dateEditing.text =
                                              DateFormat("dd/mm/yyyy - kk:mm")
                                                  .format(
                                                      controller.datetimeToDb),
                                        })
                                  });
                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomInput(
                      editingController: controller.messageEditing,
                      inputType: TextInputType.text,
                      hintText: 'Mensagem',
                      labelText: 'Mensagem',
                      icon: Icons.textsms,
                      validator: validators.validateEmpty,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  /* ==========================  Widgets ================================ */

  Widget customText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text,
          style: TextStyle(
              color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget taskSelect(List<Map<String, dynamic>> list) {
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
                  //idEditing: controller.idTaskEditing,
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

  /* Widget addTask(List<Map<String, dynamic>> list) {
    return IconButton(
      onPressed: () {
        inputDialog.showInput(
            context: context,
            changedAction: null,
            tapAction: tapAction,
            textEditing: controller.nameTaskEditing);
      },
      icon: Icon(Icons.add_circle),
      color: Theme.of(context).accentColor,
      iconSize: 40,
    );
  } */

  /* tapAction() {
    List<Task> dataList = controller.task.data;
    //controller.submitTask(dataList);
    controller.getTasks();
  } */

  Widget datePicker() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 4.0,
      onPressed: () {
        _selectDateTime(context).then((value) => {
              _date = value.toString(),
              setState(() {}),
            });
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
              "  Alterar",
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
        _selectTime(context).then((value) => {
              _time = value.toString(),
              controller.timeOfDay = value,
              setState(() {}),
            });
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
              "  Alterar",
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
          /* await AndroidAlarmManager.periodic(
              const Duration(minutes: 1), helloAlarmID, printHello); */
          for (var i = 0; i < 10; i++) {
            await controller.singleNotification(
              DateTime(now.year, now.month, now.day, controller.timeOfDay.hour,
                      controller.timeOfDay.minute)
                  .add(Duration(minutes: i)),
              "Beber Agua $i",
              DateTime(now.year, now.month, now.day, controller.timeOfDay.hour,
                      controller.timeOfDay.minute)
                  .add(Duration(minutes: i))
                  .toString(),
              i + 1,
            );
          }
        },
        child: Text("Alarme"));
  }

  Widget buildItemCheck(Map<String, dynamic> map, int index) {
    return Column(
      children: <Widget>[
        Observer(builder: (context) {
          return RaisedButton(
            shape: CircleBorder(
                side: BorderSide(
                    width: 2,
                    color: Theme.of(context).accentColor,
                    style: BorderStyle.solid)),
            color: controller.daysOfWeek[index]['bool']
                ? Colors.greenAccent
                : Colors.grey[300],
            onPressed: () {
              controller.daysOfWeek[index]['bool'] =
                  !controller.daysOfWeek[index]['bool'];
              setState(() {});
            },
            child: Text(map['label'].substring(0, 1)),
          );
        }),
      ],
    );
  }

  Widget daysOfWeek() {
    List<Widget> items = new List<Widget>();

    return Observer(builder: (context) {
      for (var i = 0; i < controller.daysOfWeek.length; i++) {
        items.add(buildItemCheck(controller.daysOfWeek[i], i));
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          for (var item in items) Expanded(child: item),
        ],
      );
    });
  }

  /* =========================== Functions ================================ */

  Future<void> save() async {
    List<Task> dataList = controller.task.data;
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      await controller.submitTask(dataList, onError: (title, description) {
        utils.flushBarDanger(
            context: context, title: title, description: description);
      }, onSuccess: () {
        Modular.to.pop();
        interstitialAd.show();
      });
    }
  }

  Future<TimeOfDay> _selectTime(BuildContext context) {
    final now = DateTime.now();

    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
  }

  Future<DateTime> _selectDateTime(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(seconds: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
  }
}
