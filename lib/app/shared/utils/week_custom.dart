import 'package:flutter/cupertino.dart';

class CustomWeekdayLabelsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Text("Seg", textAlign: TextAlign.center)),
        Expanded(child: Text("Ter", textAlign: TextAlign.center)),
        Expanded(child: Text("Qua", textAlign: TextAlign.center)),
        Expanded(child: Text("Qui", textAlign: TextAlign.center)),
        Expanded(child: Text("Sex", textAlign: TextAlign.center)),
        Expanded(child: Text("Sab", textAlign: TextAlign.center)),
        Expanded(child: Text("Dom", textAlign: TextAlign.center)),
      ],
    );
  }
}
