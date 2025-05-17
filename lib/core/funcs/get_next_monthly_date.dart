DateTime getNextMonthlyDate(DateTime currentDate) {
  int nextMonth = currentDate.month + 1;
  int nextYear = currentDate.year;

  if (nextMonth > 12) {
    nextMonth = 1;
    nextYear += 1;
  }

  int day = currentDate.day;

  final lastDayOfNextMonth = DateTime(nextYear, nextMonth + 1, 0).day;

  if (day > lastDayOfNextMonth) {
    day = lastDayOfNextMonth;
  }

  return DateTime(
    nextYear,
    nextMonth,
    day,
    currentDate.hour,
    currentDate.minute,
    currentDate.second,
    currentDate.millisecond,
  );
}
