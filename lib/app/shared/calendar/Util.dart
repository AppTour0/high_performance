///class that contains the methods used to date
class MyDateTime {
  static String formatDate(DateTime date, {String format = "dd/MM/yyyy"}) {
    var str = format.replaceAll(
        "dd", (date.day < 10 ? "0" : "") + date.day.toString());
    str = str.replaceAll(
        "MM", (date.month < 10 ? "0" : "") + date.month.toString());
    str = str.replaceAll("yyyy", date.year.toString());
    return str;
  }

  ///get first date of week
  static DateTime getFirstDateOfWeek(DateTime date) {
    return date.weekday == 7
        ? date
        : date.add(new Duration(days: -date.weekday));
  }

  ///get all days of week
  static List<int> getDaysOfWeek(DateTime date) {
    var firstDay = getFirstDateOfWeek(date);
    var days = <int>[];
    for (var i = 0; i < 7; i++) {
      days.add(firstDay.add(new Duration(days: i)).day);
    }
    return days;
  }

  // test have day in list of dates
  static List<int> getListDaysOfWeek(DateTime date, List<DateTime> dateList) {
    DateTime firstDay = getFirstDateOfWeek(date);
    var days = <DateTime>[];
    for (var i = 0; i < 7; i++) {
      DateTime dateTest = DateTime(
          firstDay.add(new Duration(days: i)).year,
          firstDay.add(new Duration(days: i)).month,
          firstDay.add(new Duration(days: i)).day);
      days.add(dateTest);
    }

    List<int> selectedDays = [];

    dateList.forEach((e) {
      if (days.contains(e)) {
        selectedDays.add(e.weekday == 7 ? 0 : e.weekday);
      }
    });

    return selectedDays;
  }
}
