class AppDateUtil {
  bool isToday(DateTime specifiedDate) {
    final DateTime thisInstant = DateTime.now();
    final Duration differenceBetweenDates =
        thisInstant.difference(specifiedDate);
    return differenceBetweenDates.inHours >= 0 &&
        differenceBetweenDates.inHours <= 23;
  }

  bool isYesterday(DateTime specifiedDate) {
    final DateTime thisInstant = DateTime.now();
    final Duration differenceBetweenDates =
        thisInstant.difference(specifiedDate);
    return differenceBetweenDates.inHours >= 24 &&
        differenceBetweenDates.inHours <= 48;
  }

  bool isFuture(DateTime specifiedDate) {
    final DateTime thisInstant = DateTime.now();
    final Duration differenceBetweenDates =
        thisInstant.difference(specifiedDate);
    return differenceBetweenDates.inHours < 0;
  }

  DateTime customDateTimeParser(String dateTimeString) {
    try {
      return DateTime.parse(dateTimeString);
    } catch (e) {
      return _tryToParseAfterError(dateTimeString);
    }
  }

  DateTime _tryToParseAfterError(final String dateTimeString) {
    try {
      int indexOfPlus = dateTimeString.indexOf(
        "+",
      );
      String f = dateTimeString.substring(0, indexOfPlus - 1);
      String s = dateTimeString.substring(indexOfPlus);
      return DateTime.parse(f + s);
    } catch (e) {
      return DateTime.now();
    }
  }
}

//
