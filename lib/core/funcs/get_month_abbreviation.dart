import 'package:finance_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';

String getMonthAbbreviation(BuildContext context, int month) {
  final months = [
    '', // index 0 unused
    S.of(context).jan,
    S.of(context).feb,
    S.of(context).mar,
    S.of(context).apr,
    S.of(context).may,
    S.of(context).jun,
    S.of(context).jul,
    S.of(context).aug,
    S.of(context).sep,
    S.of(context).oct,
    S.of(context).nov,
    S.of(context).dec,
  ];
  return months[month];
}
