import '../../features/home/data/enums/recurrence_type_enum.dart';
import 'calculate_next_occurence.dart';
import 'get_next_monthly_date.dart';

int calculateRecurrenceCount(
  DateTime startDate,
  RecurrenceType recurrence,
  DateTime? recurrenceEndDate,
  DateTime? rangeStart,
  DateTime? rangeEnd,
) {
  if(recurrence == RecurrenceType.none) return 0;
  final finalEndDate = recurrenceEndDate ?? getNextMonthlyDate(startDate);
  final endRange = rangeEnd ?? DateTime.now();
  final startRange = rangeStart ?? startDate;
  int count = 0;
  DateTime current = startDate;
  while (!current.isAfter(finalEndDate)) {
    if (!current.isBefore(startRange) && !current.isAfter(endRange)) {
      count++;
    }
    current = calculateNextOccurrence(current, recurrence);
    if (current.isAfter(endRange) || current.isAfter(finalEndDate)) {
      break;
    }
  }
  return count;
}
