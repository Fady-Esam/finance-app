class BalanceSummary {
  double totalIncome;
  double totalExpense;

  BalanceSummary({this.totalIncome = 0, this.totalExpense = 0});
  double get netBalance => totalIncome - totalExpense;
}
