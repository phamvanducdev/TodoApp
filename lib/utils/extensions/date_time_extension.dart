extension DateTimeExtension on DateTime {
  List<DateTime> get daysInMonth {
    DateTime firstDayOfMonth = DateTime(year, month, 1);

    DateTime firstDayOfNextMonth = (month < 12) ? DateTime(year, month + 1, 1) : DateTime(year + 1, 1, 1);
    DateTime lastDayOfMonth = firstDayOfNextMonth.subtract(const Duration(days: 1));

    List<DateTime> days = [];
    for (int i = 0; i < lastDayOfMonth.day; i++) {
      days.add(firstDayOfMonth.add(Duration(days: i)));
    }

    return days;
  }

  bool isSameDate(DateTime dateTime) {
    return year == dateTime.year && month == dateTime.month && day == dateTime.day;
  }

  bool isSameOrBeforeDate(DateTime dateTime) {
    return isSameDate(dateTime) || isBefore(dateTime);
  }

  bool isSameOrAfterDate(DateTime dateTime) {
    return isSameDate(dateTime) || isAfter(dateTime);
  }

  DateTime startOfYear() {
    return DateTime(year, 1, 1);
  }

  DateTime addYears(int years) {
    return DateTime(year + years, month, day, hour, minute, second, millisecond, microsecond);
  }

  DateTime subtractYears(int years) {
    return DateTime(year - years, month, day, hour, minute, second, millisecond, microsecond);
  }
}
