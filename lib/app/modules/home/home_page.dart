import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/components/custom_tile/custom_tile.dart';
import 'package:high_performance/app/components/custom_tile/tile_model.dart';
import 'package:high_performance/app/modules/home/home_controller.dart';
import 'package:high_performance/app/modules/home/home_module.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:high_performance/app/shared/db/database.dart';
import 'package:high_performance/app/shared/utils/admob/ad_manager.dart';
import 'package:high_performance/app/shared/utils/utils.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:high_performance/app/shared/utils/notifications/receive_notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Lista de Tarefas"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeModule.to.get<HomeController>();
  VariablesNotification vars = VariablesNotification();
  Utils utils = Utils();
  AdManager _adManager = AdManager();

  AdmobBannerSize bannerSize;
  AdmobBanner bannerAd;

  void initState() {
    super.initState();

    //List<String> testDeviceIds = ["99A13FDAA901F1416753FEB3677CC044"];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /* title: controller.tasksList.length == null
              ? Text(widget.title)
              : Text(
                  widget.title + " " + controller.tasksList.length.toString()), */
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                await Modular.to
                    .pushNamed("/tasks", arguments: 0)
                    .then((value) => setStateCustom());
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
      body: Observer(
        builder: (context) {
          if (controller.tasks.data == null) {
            return Center(child: CircularProgressIndicator());
          }

          List<Task> data = controller.tasks.data;

          if (data.length == 0) {
            return Center(child: Text("Não há tarefas"));
          }

          List<String> days = [];

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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[300],
        child: Container(
          height: 50,
          child: bannerAd,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
