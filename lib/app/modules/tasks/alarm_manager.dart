// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AlarmHomePage extends StatefulWidget {
  @override
  _AlarmHomePageState createState() => _AlarmHomePageState();
}

class _AlarmHomePageState extends State<AlarmHomePage> {
  int _counter = 0;
  var status;
  static var playerId;

  @override
  void initState() {
    super.initState();
    AndroidAlarmManager.initialize();

    // Register for events from the background isolate. These messages will
    // always coincide with an alarm firing.
    //port.listen((_) async => await _incrementCounter());
  }

  // The background
  static SendPort uiSendPort;

  // The callback for our alarm
  static Future<void> callback() async {
    print('Alarm fired!');

    //await _handleSendNotification();

    var imgUrlString =
        "http://cdn1-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-2.jpg";

    var notification = OSCreateNotification(
        playerIds: [playerId],
        content: "this is a test from OneSignal's Flutter SDK",
        heading: "Test Notification",
        iosAttachments: {"id1": imgUrlString},
        bigPicture: imgUrlString,
        buttons: [
          OSActionButton(text: "test1", id: "id1"),
          OSActionButton(text: "test2", id: "id2")
        ]);

    var response = await OneSignal.shared.postNotification(notification);

    print(response);

    /* // Get the previous cached count and increment it.
    final prefs = await SharedPreferences.getInstance();
    int currentCount = 0;
    //await prefs.setInt(countKey, currentCount + 1);

    // This will be null if we're running in the background.
    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send(null); */
  }

  Future _handleSendNotification() async {
    /* this.setState(() {
      _debugLabelString = "Sent notification with response: $response";
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("teste"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Alarm fired $_counter times',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total alarms fired: ',
                  ),
                  Text(
                    //prefs.getInt(countKey).toString(),
                    "teste",
                    key: ValueKey('BackgroundCountText'),
                  ),
                ],
              ),
              RaisedButton(
                child: Text(
                  'Schedule OneShot Alarm',
                ),
                key: ValueKey('RegisterOneShotAlarm'),
                onPressed: () async {
                  /* oneShotAt(DateTime.now(), Random().nextInt(pow(2, 31)),
                      (id) => null); */
                  await AndroidAlarmManager.oneShot(
                    const Duration(seconds: 5),
                    //DateTime.now().add(Duration(minutes: 1)),
                    0,
                    callback,
                    exact: true,
                    wakeup: true,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
