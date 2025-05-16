import 'package:finance_flutter_app/core/funcs/get_next_monthly_date.dart';
import 'package:hive/hive.dart';

import '../enums/recurrence_type_enum.dart';
part 'finance_item_model.g.dart';

@HiveType(typeId: 0)
class FinanceItemModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  DateTime dateTime;
  @HiveField(3)
  double amount;
  @HiveField(4)
  int? categoryId;
  @HiveField(5)
  RecurrenceType recurrence;
  @HiveField(6)
  DateTime? recurrenceEndDate;
  @HiveField(7)
  int recurrenceCount;
  FinanceItemModel({
    required this.title,
    this.description,
    required this.dateTime,
    required this.amount,
    this.categoryId,
    this.recurrence = RecurrenceType.none,
    DateTime? recurrenceEndDate,
    this.recurrenceCount = 0,
  }) {
    this.recurrenceEndDate = recurrenceEndDate ?? getNextMonthlyDate(dateTime);
  }
}
