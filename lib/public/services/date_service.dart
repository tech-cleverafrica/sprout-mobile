import 'package:sprout_mobile/public/model/date_range.dart';

class DateService {
  DateRange dateRangeFormatter(String value) {
    DateRange date = new DateRange();
    if (value == "Today") {
      date = today();
    }

    if (value == "Yesterday") {
      date = yesterday();
    }

    if (value == "This week") {
      date = thisWeek();
    }

    if (value == "Last week") {
      date = lastWeek();
    }

    if (value == "This month") {
      date = thisMonth();
    }

    if (value == "Last month") {
      date = lastMonth();
    }
    return date;
  }

  DateRange today() {
    var now = DateTime.now();
    var lastMidnight = DateTime(now.year, now.month, now.day).toIso8601String();
    var date = new DateRange();
    date.startDate = lastMidnight;
    date.endDate = now.toIso8601String();
    return date;
  }

  DateRange yesterday() {
    var now = DateTime.now();
    // var lastMidnight = DateTime(now.year, now.month, now.day).toIso8601String();
    var lastTwoMidnight =
        DateTime(now.year, now.month, now.day - 1).toIso8601String();
    var date = new DateRange();
    date.startDate = lastTwoMidnight;
    date.endDate = lastTwoMidnight;
    // date.endDate = lastMidnight;
    return date;
  }

  DateRange thisWeek() {
    var date = new DateRange();
    date.startDate = findFirstDateOfTheWeek(DateTime.now()).toIso8601String();
    date.endDate = (DateTime.now()).toIso8601String();
    return date;
  }

  DateRange lastWeek() {
    var date = new DateRange();
    date.startDate =
        findFirstDateOfTheWeek(DateTime.now().subtract(const Duration(days: 7)))
            .toIso8601String();
    date.endDate =
        findLastDateOfTheWeek(DateTime.now().subtract(const Duration(days: 7)))
            .toIso8601String();
    return date;
  }

  DateRange thisMonth() {
    var date = new DateRange();
    date.startDate = DateTime(DateTime.now().year, DateTime.now().month, 1)
        .toIso8601String();
    date.endDate = (DateTime.now()).toIso8601String();
    return date;
  }

  DateRange lastMonth() {
    var date = new DateRange();
    date.startDate = DateTime(DateTime.now().year, DateTime.now().month - 1, 1)
        .toIso8601String();
    date.endDate = DateTime(DateTime.now().year, DateTime.now().month, 0)
        .toIso8601String();
    return date;
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }
}
