import 'package:flutter/cupertino.dart';

class TileModel {
  int id;
  Widget title;
  List<Widget> subtitle;
  dynamic trailing;

  TileModel({this.id, this.title, this.subtitle});
}
