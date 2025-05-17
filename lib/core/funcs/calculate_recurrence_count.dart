import '../../features/home/data/enums/recurrence_type_enum.dart';
import 'calculate_next_occurence.dart';

int calculateRecurrenceCount(
  DateTime startDate,
  RecurrenceType recurrence,
  DateTime recurrenceEndDate,
  DateTime rangeStart,
  DateTime rangeEnd,
) {
  DateTime current = startDate;
  int count = 0;
  while (!current.isAfter(recurrenceEndDate)) {
    if (!current.isBefore(rangeStart) && !current.isAfter(rangeEnd)) {
      count++;
    }
    current = calculateNextOccurrence(current, recurrence);
    if (current.isAfter(rangeEnd) || current.isAfter(recurrenceEndDate)) {
      break;
    }
  }
  return count;
}
