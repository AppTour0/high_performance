import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/components/choose_modal.dart';
import 'package:high_performance/app/components/dialogs/input_dialog.dart';
import 'package:high_performance/app/components/inputs.dart';
import 'package:high_performance/app/modules/tasks/tasks_controller.dart';
import 'package:high_performance/app/modules/tasks/tasks_module.dart';
import 'package:high_performance/app/shared/db/database.dart';
import 'package:high_performance/app/shared/utils/utils.dart';
import 'package:high_performance/app/shared/utils/validators.dart';

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

  @override
  void initState() {
    super.initState();
    controller.getTask(widget.id);
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
            Visibility(
              visible: widget.id > 0,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  delete();
                },
              ),
            )
          ],
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
            controller.daysOfWeek[1]['bool'] = dataList[0].taskList.mon;
            controller.daysOfWeek[2]['bool'] = dataList[0].taskList.tue;
            controller.daysOfWeek[3]['bool'] = dataList[0].taskList.wed;
            controller.daysOfWeek[4]['bool'] = dataList[0].taskList.thu;
            controller.daysOfWeek[5]['bool'] = dataList[0].taskList.fri;
            controller.daysOfWeek[6]['bool'] = dataList[0].taskList.sat;
            controller.daysOfWeek[0]['bool'] = dataList[0].taskList.sun;
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 5,
                          child: task(list),
                        ),
                        Flexible(
                          child: addTask(list),
                        ),
                      ],
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
                            controller.repeat ? Icons.date_range : Icons.timer,
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
                              ? _selectTime(context)
                              : _selectDateTime(context)
                                  .then((value) => _selectTime(context));
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
                        validator: validators.validateEmpty),
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
      color: Theme.of(context).accentColor,
      iconSize: 40,
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
    List<TasksListWithTask> dataList = controller.taskList.data;
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      await controller
          .submitList(dataList,
              onError: (title, description) async {}, onSuccess: () async {})
          .then(
            //alarmTest();
            (value) => Modular.to.pop(),
          );
    }
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
                          context: context,
                          title: "Sucesso!",
                          description: "Tarefa deletada com sucesso.");
                    },
                  )
                }
            });
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
