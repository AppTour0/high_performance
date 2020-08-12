import 'package:flutter/material.dart';
import 'package:high_performance/app/shared/calendarro/calendarro.dart';
import 'package:high_performance/app/shared/calendarro/date_utils.dart';

class CalendarroDayItem extends StatelessWidget {
  CalendarroDayItem(
      {this.date, this.calendarroState, this.onTap, this.enable, this.color});

  DateTime date;
  CalendarroState calendarroState;
  DateTimeCallback onTap;
  bool enable;
  Color color;

  @override
  Widget build(BuildContext context) {
    bool isWeekend = DateUtils.isWeekend(date);
    var textColor = /* isWeekend ? Colors.grey :  */ Colors.black;
    bool isToday = DateUtils.isToday(date);
    calendarroState = Calendarro.of(context);

    bool daySelected = calendarroState.isDateSelected(date);

    BoxDecoration boxDecoration;
    if (daySelected) {
      boxDecoration = BoxDecoration(color: color, shape: BoxShape.circle);
      textColor = Colors.white;
    } else if (isToday) {
      boxDecoration = BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1.0,
          ),
          shape: BoxShape.circle);
    }

    return Expanded(
        child: GestureDetector(
      child: Container(
          height: 40.0,
          decoration: boxDecoration,
          child: Center(
              child: Text(
            "${date.day}",
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor),
          ))),
      onTap: enable ? handleTap : null,
      behavior: HitTestBehavior.translucent,
    ));
  }

  void handleTap() {
    if (onTap != null) {
      onTap(date);
    }

    calendarroState.setSelectedDate(date);
    calendarroState.setCurrentDate(date);
  }
}
