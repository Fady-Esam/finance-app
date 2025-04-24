import 'package:hive/hive.dart';
part 'finance_item_model.g.dart';
@HiveType(typeId: 0)
class FinanceItemModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final DateTime dateTime;
  @HiveField(2)
  final double amount;

  FinanceItemModel({
    required this.title,
    required this.dateTime,
    required this.amount,
  });
}
