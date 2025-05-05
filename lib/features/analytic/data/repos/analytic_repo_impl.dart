import 'package:finance_flutter_app/features/analytic/data/repos/analytic_repo.dart';
import 'package:finance_flutter_app/features/home/data/models/finance_item_model.dart';

class AnalyticRepoImpl implements AnalyticRepo {
  @override
  Map<int, Map<String, double>> getGroupByMonth(List<FinanceItemModel> items) {
    final result = <int, Map<String, double>>{};
    items.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    for (var item in items) {
      final month = item.dateTime.month;
      final type = item.amount >= 0 ? 'income' : 'expense';
      result[month] ??= {'income': 0, 'expense': 0};
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
}
