import 'package:hive/hive.dart';
part 'finance_item_model.g.dart';
@HiveType(typeId: 0)
class FinanceItemModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  DateTime dateTime;
  @HiveField(2)
  double amount;

  FinanceItemModel({
    required this.title,
    required this.dateTime,
    required this.amount,
  });
}
