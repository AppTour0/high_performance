import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:high_performance/app/modules/tasks/alarm_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  /// The [SharedPreferences] key to access the alarm fire count.
  static String countKey = 'count';

  /// The name associated with the UI isolate's [SendPort].
  static String isolateName = 'isolate';

  /// A port used to communicate from a background isolate to the UI isolate.
  final ReceivePort port = ReceivePort();

  final controller = AlarmController();

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    AndroidAlarmManager.initialize();

    // Register the UI isolate's SendPort to allow for communication from the
    // background isolate.
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      isolateName,
    );

    // Register for events from the background isolate. These messages will
    // always coincide with an alarm firing.
    port.listen((_) async => await _incrementCounter());
  }

  Future<void> _incrementCounter() async {
    print('Increment counter!');

    // Ensure we've loaded the updated count from the background isolate.
    await controller.prefs.reload();

    setState(() {
      _counter++;
    });
  }

  // The background
  static SendPort uiSendPort;

  // The callback for our alarm
  static Future<void> callback() async {
    print('Alarm fired!');

    // Get the previous cached count and increment it.
    final prefs = await SharedPreferences.getInstance();
    int currentCount = prefs.getInt(countKey);
    await prefs.setInt(countKey, currentCount + 1);

    // This will be null if we're running in the background.
    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send(null);
  }

  @override
  Widget build(BuildContext context) {
    // TODO(jackson): This has been deprecated and should be replaced
    // with `headline4` when it's available on all the versions of
    // Flutter that we test.
    // ignore: deprecated_member_use
    final textStyle = Theme.of(context).textTheme.display1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarme'),
      ),
      body: Observer(builder: (context) {
        if (controller.prefs == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  child: const Text('playAlarm'),
                  onPressed: () {
                    FlutterRingtonePlayer.playAlarm();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  child: const Text('playAlarm asAlarm: false'),
                  onPressed: () {
                    FlutterRingtonePlayer.playAlarm(asAlarm: false);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  child: const Text('playNotification'),
                  onPressed: () {
                    FlutterRingtonePlayer.playNotification();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  child: const Text('playRingtone'),
                  onPressed: () {
                    FlutterRingtonePlayer.playRingtone();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  child: const Text('play'),
                  onPressed: () {
                    FlutterRingtonePlayer.play(
                      android: AndroidSounds.notification,
                      ios: IosSounds.glass,
                      looping: true,
                      volume: 1.0,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  child: const Text('stop'),
                  onPressed: () {
                    FlutterRingtonePlayer.stop();
                  },
                ),
              ),
            ],
          ),
        );

        /* return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Alarm fired $_counter times',
                style: textStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total alarms fired: ',
                    style: textStyle,
                  ),
                  Text(
                    controller.prefs.getInt(countKey).toString(),
                    key: ValueKey('BackgroundCountText'),
                    style: textStyle,
                  ),
                ],
              ),
              RaisedButton(
                child: Text(
                  'Schedule OneShot Alarm',
                ),
                key: ValueKey('RegisterOneShotAlarm'),
                onPressed: () async {
                  await AndroidAlarmManager.oneShot(
                    const Duration(seconds: 5),
                    // Ensure we have a unique alarm ID.
                    Random().nextInt(pow(2, 31)),
                    callback,
                    exact: true,
                    wakeup: true,
                  );
                },
              ),
            ],
          ),
        ); */
      }),
    );
  }
}
