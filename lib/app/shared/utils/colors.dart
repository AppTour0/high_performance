import 'package:flutter/material.dart';

class TextColors {
  Color switchColors(String color) {
    switch (color) {
      case 'black':
        return Colors.black;
        break;
      case 'cyan':
        return Colors.cyan;
        break;
      case 'blue':
        return Colors.blue[600];
        break;
      case 'green':
        return Colors.green[600];
        break;
      case 'orange':
        return Colors.orange[600];
        break;
      case 'pink':
        return Colors.pink;
        break;
      case 'grey':
        return Colors.grey[600];
        break;
      case 'purple':
        return Colors.purple[600];
        break;
      case 'red':
        return Colors.red;
        break;
      case 'indigo':
        return Colors.indigo;
        break;
      default:
    }
  }
}
