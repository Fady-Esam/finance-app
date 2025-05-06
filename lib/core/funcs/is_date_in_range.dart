import 'package:flutter/material.dart';

bool isDateInRange(DateTime date, DateTimeRange range) {
  return !date.isBefore(range.start) && !date.isAfter(range.end);
}
