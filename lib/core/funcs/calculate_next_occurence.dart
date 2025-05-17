import 'package:finance_flutter_app/core/funcs/get_next_monthly_date.dart';
import 'package:finance_flutter_app/features/home/data/enums/recurrence_type_enum.dart';

DateTime calculateNextOccurrence(
  DateTime originalDate,
  RecurrenceType recurrence,
) {
  switch (recurrence) {
    case RecurrenceType.daily:
      return originalDate.add(const Duration(days: 1));

    case RecurrenceType.weekly:
      return originalDate.add(const Duration(days: 7));

    case RecurrenceType.monthly:
      return getNextMonthlyDate(originalDate);

    case RecurrenceType.yearly:
      return DateTime(
        originalDate.year + 1,
        originalDate.month,
        originalDate.day,
        originalDate.hour,
        originalDate.minute,
        originalDate.second,
        originalDate.millisecond,
      );

    case RecurrenceType.none:
      return originalDate;
  }
}
