import 'package:finance_flutter_app/features/home/data/enums/recurrence_type_enum.dart';
import 'package:finance_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';

String getRecurrenceText(BuildContext context, RecurrenceType recurrenceType) {
  switch (recurrenceType) {
    // case RecurrenceType.none:
    //   return 'None';
    case RecurrenceType.daily:
      return S.of(context).daily;
    case RecurrenceType.weekly:
      return S.of(context).weekly;
    case RecurrenceType.monthly:
      return S.of(context).monthly;
    case RecurrenceType.yearly:
      return S.of(context).yearly;
    default:
      return S.of(context).none;
  }
}
