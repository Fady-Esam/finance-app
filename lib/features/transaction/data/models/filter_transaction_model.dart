class FilterTransactionModel {
  final DateTime dateTime;
  int? categoryId;
  bool? isAmountPositive;
  FilterTransactionModel({
    required this.dateTime,
    this.categoryId,
    this.isAmountPositive,
  });
}
