import 'package:flutter/material.dart';

class TasksDetailPage extends StatefulWidget {
  final String title;
  const TasksDetailPage({Key key, this.title = "TasksDetail"})
      : super(key: key);

  @override
  _TasksDetailPageState createState() => _TasksDetailPageState();
}

class _TasksDetailPageState extends State<TasksDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
