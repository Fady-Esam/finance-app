import 'package:fl_chart/fl_chart.dart';

import '../../../home/data/models/finance_item_model.dart';

abstract class AnalyticRepo {
  Map<int, Map<String, double>> getGroupByMonth(List<FinanceItemModel> items);
  Map<int, double> getGroupByCategory(List<FinanceItemModel> items);
  List<FlSpot> calculateCumulativeBalance(List<FinanceItemModel> items);
}
