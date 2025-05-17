import 'package:finance_flutter_app/features/analytic/data/repos/analytic_repo.dart';
import 'package:finance_flutter_app/features/home/data/models/finance_item_model.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticRepoImpl implements AnalyticRepo {
  @override
  Map<int, Map<String, double>> getGroupByMonth(List<FinanceItemModel> items) {
    final result = <int, Map<String, double>>{
      for (int i = 1; i <= 12; i++) i: {'income': 0, 'expense': 0},
    };
    for (final item in items) {
      final month = item.dateTime.month;
      final type = item.amount >= 0 ? 'income' : 'expense';
      final count = item.recurrenceCount == 0 ? 1 : item.recurrenceCount;
      result[month]![type] = result[month]![type]! + item.amount.abs() * count;
    }
    return result;
  }

  @override
  Map<int, double> getGroupByCategory(List<FinanceItemModel> items) {
    final result = <int, double>{};

    for (final item in items) {
      if (item.amount > 0 || item.categoryId == null) continue;
      final categoryId = item.categoryId!;
      final count = item.recurrenceCount == 0 ? 1 : item.recurrenceCount;
      result[categoryId] =
          (result[categoryId] ?? 0) + item.amount.abs() * count;
    }
    return result;
  }

  @override
  List<FlSpot> calculateCumulativeBalance(List<FinanceItemModel> items) {
    if (items.isEmpty) return [];

    final monthlySums = <int, double>{};
    for (final item in items) {
      final month = item.dateTime.month;
      final count = item.recurrenceCount == 0 ? 1 : item.recurrenceCount;
      monthlySums[month] = (monthlySums[month] ?? 0) + item.amount * count;
    }

    final lastMonth = monthlySums.keys.reduce((a, b) => a > b ? a : b);

    double total = 0;
    final spots = <FlSpot>[];
    for (int month = 1; month <= lastMonth; month++) {
      total += (monthlySums[month] ?? 0);
      spots.add(FlSpot(month.toDouble(), total));
    }

    return spots;
  }
}
