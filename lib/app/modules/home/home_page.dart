import 'package:admob_flutter/admob_flutter.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/modules/home/home_controller.dart';
import 'package:high_performance/app/modules/home/home_module.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:high_performance/app/modules/tasks/tasks_arguments.dart';
import 'package:high_performance/app/shared/calendar/g2x_simple_week_calendar.dart';
import 'package:high_performance/app/shared/calendarro/calendarro.dart';
import 'package:high_performance/app/shared/db/database.dart';
import 'package:high_performance/app/shared/utils/admob/ad_manager.dart';
import 'package:high_performance/app/shared/utils/colors.dart';
import 'package:high_performance/app/shared/utils/utils.dart';
import 'package:high_performance/app/shared/utils/week_custom.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:high_performance/app/shared/utils/notifications/receive_notification.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final controller = HomeModule.to.get<HomeController>();
  VariablesNotification vars = VariablesNotification();
  Utils utils = Utils();
  AdManager _adManager = AdManager();
  DateTime now = DateTime.now();
  final TextColors textColor = TextColors();

  AdmobBannerSize bannerSize;
  AdmobBanner bannerAd;

  void initState() {
    super.initState();
    Admob.initialize(_adManager.appId);
    bannerSize = AdmobBannerSize.BANNER;

    bannerAd = AdmobBanner(
      adUnitId: _adManager.bannerAdUnitId,
      adSize: bannerSize,
    );
  }

  setStateCustom() {
    setState(() {});
  }

  DateTime dateCallback;

  _dateCallback(DateTime date) {
    dateCallback = date;
    print(dateCallback);
  }

  static Future onesignalNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _playerId = prefs.getString('playerId');

    var notification = OSCreateNotification(
        playerIds: [_playerId],
        content: "Teste depois de 1 minuto",
        heading: "Test Notification",
        buttons: [
          OSActionButton(
              text: "OK",
              id: "id1",
              icon:
                  "@mipmap/ic_launcher" /* icon: "lib/assets/icons/check_icon.png" */),
          OSActionButton(text: "Cancelar", id: "id2", icon: "ic_launcher.png")
        ]);

    var response = await OneSignal.shared.postNotification(notification);
    //print(response);

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      controller.insertDetail(DateTime.now(), 1);
    });
  }

  static Future<void> callback() async {
    print("ok");
    onesignalNotification();
  }

  Future alarm() async {
    await AndroidAlarmManager.oneShot(
      const Duration(seconds: 5),
      //DateTime.now(),
      0,
      callback,
      exact: true,
      wakeup: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [habits(), unique()];
    List<String> _title = ["Hábitos", "Tarefas"];

    return Scaffold(
      appBar: AppBar(
        /* title: controller.tasksList.length == null
              ? Text(widget.title)
              : Text(
                  widget.title + " " + controller.tasksList.length.toString()), */
        title: Text(
          _title[controller.bottomIndex],
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                await Modular.to
                    .pushNamed("/tasks", arguments: 0)
                    .then((value) => setStateCustom());
              }),
          IconButton(
              icon: Icon(Icons.timer),
              onPressed: () {
                alarm();
                /*  Navigator.push(
                  context,
                  //MaterialPageRoute(builder: (context) => NotificationPage()),
                  MaterialPageRoute(builder: (context) => AlarmHomePage()),
                ); */
              })
        ],
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
      body: _children[controller.bottomIndex],
      bottomNavigationBar: Container(
        height: 107,
        child: Column(
          children: <Widget>[
            Observer(builder: (context) {
              return BottomNavigationBar(
                  elevation: 0,
                  currentIndex: controller.bottomIndex,
                  onTap: (index) {
                    controller.bottomIndex = index;
                    setState(() {});
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.refresh),
                      title: Text("Hábitos"),
                      backgroundColor: Theme.of(context).accentColor,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.format_list_bulleted),
                      title: Text("Tarefas"),
                      backgroundColor: Colors.deepPurpleAccent[200],
                    ),
                  ]);
            }),
            bannerAd,
          ],
        ),
      ),
    );
  }

  Widget habits() {
    return Observer(
      builder: (context) {
        if (controller.habits.data == null ||
            controller.habitsCompleted.data == null) {
          return Center(child: CircularProgressIndicator());
        }

        List<Task> data = controller.habits.data;
        List<TasksDetailData> dataDetail = controller.habitsCompleted.data;

        if (data.length == 0) {
          return Center(child: Text("Não há hábitos"));
        }

        List<TasksDetailData> dateListOfTask = [];

        return ListView.builder(
          itemCount: data.length,
          primary: true,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            controller.dateList.clear();
            dateListOfTask.clear();

            dateListOfTask = dataDetail
                .where((element) => element.idTask == data[index].id)
                .toList();

            for (var i = 0; i < dateListOfTask.length; i++) {
              controller.dateList.add(dateListOfTask[i].dateConfirm);
            }

            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  border: Border.all(
                    color: textColor.switchColors(data[index].color),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () async {
                        await Modular.to
                            .pushNamed("/tasksDetail",
                                arguments: TasksArguments(
                                    data[index].id, data[index].name))
                            .then((value) {
                          //controller.getLists();
                          setState(() {});
                        });
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(data[index].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: textColor
                                      .switchColors(data[index].color))),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.notifications_active,
                                size: 16,
                                color: Colors.black45,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Icon(
                                data[index].alarm
                                    ? Icons.timer
                                    : Icons.timer_off,
                                size: 16,
                                color: Colors.black45,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                  DateFormat("kk:mm")
                                      .format(data[index].dateTimeNotification),
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 16,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: G2xSimpleWeekCalendar(
                          50.0,
                          DateTime.now(),
                          dateCallback: (date) => _dateCallback(date),
                          strWeekDays: [
                            'Dom',
                            'Seg',
                            'Ter',
                            'Qua',
                            'Qui',
                            'Sex',
                            'Sab'
                          ],
                          circleColor:
                              textColor.switchColors(data[index].color),
                          dateList: controller.dateList,
                          selectedTextStyle: TextStyle(color: Colors.white),
                          selectedTextWeek: TextStyle(
                            color: textColor.switchColors(data[index].color),
                          ),
                          backgroundDecoration:
                              new BoxDecoration(color: Colors.white),
                        )

                        /* Observer(builder: (context) {
                        return Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ListView.builder(
                                itemCount: controller.dateList.length,
                                primary: true,
                                //shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle),
                                      child: Center(
                                          child: Text(
                                        controller.dateList[index].day
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      )));
                                }),
                          ),
                        );
                        Calendarro(
                          enable: false,
                          selectionMode: SelectionMode.MULTI,
                          weekdayLabelsRow: CustomWeekdayLabelsRow(),
                          selectedDates: controller.dateList,
                          selectedSingleDate: now,
                          color: textColor.switchColors(data[index].color),
                        );
                      }), */
                        ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /* Widget daysOfWeek() {
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
 */
  Widget unique() {
    return Observer(
      builder: (context) {
        if (controller.tasks.data == null) {
          return Center(child: CircularProgressIndicator());
        }

        List<Task> data = controller.tasks.data;

        if (data.length == 0) {
          return Center(child: Text("Não há tarefas"));
        }

        return ListView.builder(
          itemCount: data.length,
          primary: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black26,
                    width: 1,
                  ),
                ),
                child: ListTile(
                  onTap: () async {
                    await Modular.to
                        .pushNamed('/tasks', arguments: data[index].id)
                        .then((value) {
                      setState(() {});
                    });
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(data[index].name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color:
                                  textColor.switchColors(data[index].color))),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.notifications_active,
                            size: 16,
                            color: Colors.black45,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(
                            data[index].alarm ? Icons.timer : Icons.timer_off,
                            size: 16,
                            color: Colors.black45,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                              DateFormat("kk:mm")
                                  .format(data[index].dateTimeNotification),
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                              )),
                        ],
                      )
                    ],
                  ),
                  subtitle: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 6, 5, 0),
                      child: Text(data[index].message)),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/* List<String> days = [];

            List<TileModel> tileModel = List.generate(
              data.length,
              (i) {
                String dateTimeFormated = DateFormat("dd/mm/yyyy - kk:mm")
                    .format(data[i].dateTimeNotification);
                String timeFormated =
                    DateFormat("kk:mm").format(data[i].dateTimeNotification);
                days.clear();
                data[i].sun
                    ? days.add(controller.daysOfWeek[0]['label']
                        .toString()
                        .substring(0, 3))
                    : null;
                data[i].mon
                    ? days.add(controller.daysOfWeek[1]['label']
                        .toString()
                        .substring(0, 3))
                    : null;
                data[i].tue
                    ? days.add(controller.daysOfWeek[2]['label']
                        .toString()
                        .substring(0, 3))
                    : null;
                data[i].wed
                    ? days.add(controller.daysOfWeek[3]['label']
                        .toString()
                        .substring(0, 3))
                    : null;
                data[i].thu
                    ? days.add(controller.daysOfWeek[4]['label']
                        .toString()
                        .substring(0, 3))
                    : null;
                data[i].fri
                    ? days.add(controller.daysOfWeek[5]['label']
                        .toString()
                        .substring(0, 3))
                    : null;
                data[i].sat
                    ? days.add(controller.daysOfWeek[6]['label']
                        .toString()
                        .substring(0, 3))
                    : null;

                return TileModel(
                    id: data[i].id,
                    title: Text(
                      data[i].id.toString() + " - " + data[i].name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: data[i].repeat
                        ? [
                            Text(
                              timeFormated,
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Repetir: " +
                                days
                                    .toString()
                                    .replaceAll(RegExp(r"(\[)|(\])"), ''))
                          ]
                        : [
                            Text(
                              dateTimeFormated,
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ]);
              },
            );

            return Padding(
              padding: const EdgeInsets.all(5),
              child: CustomTile(
                list: tileModel,
                route: "/tasks",
              ),
            ); */
