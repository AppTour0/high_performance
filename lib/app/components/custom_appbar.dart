import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  CustomAppBar({Key key, Widget title})
      : super(
          key: key,
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            title: title,
            // maybe other AppBar properties
          ),
        );
}
