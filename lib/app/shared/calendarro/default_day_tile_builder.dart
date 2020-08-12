import 'package:flutter/material.dart';
import 'package:high_performance/app/shared/calendarro/calendarro.dart';
import 'package:high_performance/app/shared/calendarro/default_day_tile.dart';

class DefaultDayTileBuilder extends DayTileBuilder {
  DefaultDayTileBuilder();

  @override
  Widget build(BuildContext context, DateTime date, DateTimeCallback onTap,
      bool enable, Color color) {
    return CalendarroDayItem(
      date: date,
      calendarroState: Calendarro.of(context),
      onTap: onTap,
      enable: enable,
      color: color,
    );
  }
}
