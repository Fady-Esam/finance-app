DateTime getNextMonthlyDate(DateTime currentDate) {
  // Calculate the next month and year
  int nextMonth = currentDate.month + 1;
  int nextYear = currentDate.year;

  if (nextMonth > 12) {
    nextMonth = 1; // Wrap around to January
    nextYear += 1; // Increment year
  }

  // Try to keep the same day, but adjust for shorter months
  int day = currentDate.day;
  // Get the last day of the next month
  final lastDayOfNextMonth = DateTime(nextYear, nextMonth + 1, 0).day;

  // If the current day exceeds the last day of the next month, use the last day
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
