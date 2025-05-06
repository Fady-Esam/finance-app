import 'package:finance_flutter_app/features/analytic/data/repos/analytic_repo.dart';
import 'package:finance_flutter_app/features/home/data/models/finance_item_model.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticRepoImpl implements AnalyticRepo {
  @override
  // Map<int, Map<String, double>> getGroupByMonth(List<FinanceItemModel> items) {
  //   final result = <int, Map<String, double>>{};
  //   for (var item in items) {
  //     final month = item.dateTime.month;
  //     final type = item.amount >= 0 ? 'income' : 'expense';
  //     result[month] ??= {'income': 0, 'expense': 0};
  //     result[month]![type] = result[month]![type]! + item.amount.abs();
  //   }
  //   return result;
  // }
Map<int, Map<String, double>> getGroupByMonth(List<FinanceItemModel> items) {
    final result = <int, Map<String, double>>{
      for (int i = 1; i <= 12; i++) i: {'income': 0, 'expense': 0},
    };

    for (var item in items) {
      final month = item.dateTime.month;
      final type = item.amount >= 0 ? 'income' : 'expense';
      result[month]![type] = result[month]![type]! + item.amount.abs();
    }

    return result;
  }
  @override
  Map<int, double> getGroupByCategory(List<FinanceItemModel> items) {
    final Map<int, double> result = {};

    for (var item in items) {
      if (item.amount > 0 || item.categoryId == null) continue;
      int categoryId = item.categoryId!;
      result[categoryId] = (result[categoryId] ?? 0) + item.amount.abs();
    }
    return result;
  }

  @override
  List<FlSpot> calculateCumulativeBalance(List<FinanceItemModel> items) {
    if (items.isEmpty) return [];

    // Group by month (1-12), sum up balance change
    Map<int, double> monthlySums = {};
    for (var item in items) {
      final month = item.dateTime.month;
      monthlySums[month] = (monthlySums[month] ?? 0) + item.amount;
    }

    // Create cumulative total per month
final lastUsedMonth = monthlySums.keys.reduce((a, b) => a > b ? a : b);

    double total = 0;
    List<FlSpot> spots = [];
    for (int m = 1; m <= lastUsedMonth; m++) {
      total += (monthlySums[m] ?? 0);
      spots.add(FlSpot(m.toDouble(), total));
    }

    return spots;
  }
}
