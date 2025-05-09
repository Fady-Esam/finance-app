import 'package:finance_flutter_app/core/funcs/get_next_monthly_date.dart';
import 'package:hive/hive.dart';

import '../enums/recurrence_type_enum.dart';
part 'finance_item_model.g.dart';

@HiveType(typeId: 0)
class FinanceItemModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  DateTime dateTime;
  @HiveField(2)
  double amount;
  @HiveField(3)
  int? categoryId;
  @HiveField(4)
  RecurrenceType recurrence;
  @HiveField(5)
  DateTime? recurrenceEndDate;
  // String? description;
  FinanceItemModel({
    required this.title,
    required this.dateTime,
    required this.amount,
    this.categoryId,
    this.recurrence = RecurrenceType.none,
    DateTime? recurrenceEndDate,
  }) {
    this.recurrenceEndDate = recurrenceEndDate ?? getNextMonthlyDate(dateTime);
  }
}
