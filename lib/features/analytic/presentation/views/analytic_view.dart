import 'package:finance_flutter_app/core/utils/color_utils.dart';
import 'package:finance_flutter_app/features/analytic/data/repos/analytic_repo_impl.dart';
import 'package:finance_flutter_app/features/analytic/presentation/manager/cubits/manage_bar_chart_cubit/manage_bar_chart_cubit.dart';
import 'package:finance_flutter_app/features/category/data/models/category_model.dart';
import 'package:finance_flutter_app/features/category/presentation/manager/cubits/manage_category_cubit/manage_category_cubit.dart';
import 'package:finance_flutter_app/features/home/presentation/manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
import 'package:finance_flutter_app/features/home/presentation/manager/cubits/manage_finance_cubit/manage_finance_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/funcs/get_month_abbreviation.dart';
import '../../../../generated/l10n.dart';
import '../../../home/data/models/finance_item_model.dart';
import '../manager/cubits/manage_pie_chart_cubit/manage_pie_chart_cubit.dart';

// Main AnalyticView
class AnalyticView extends StatelessWidget {
  const AnalyticView({super.key});

  @override
  Widget build(BuildContext context) {
    //final transactions = dummyData;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ManageBarChartCubit(analyticRepo: AnalyticRepoImpl()),
        ),
        BlocProvider(
          create: (_) => ManagePieChartCubit(analyticRepo: AnalyticRepoImpl()),
        ),
      ],
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: S.of(context).monthly),
                Tab(text: S.of(context).categories),
                Tab(text: S.of(context).cashflow),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  IncomeExpenseChart(),
                  CategoryPieChart(),
                  IncomeExpenseChart(),
                  // CategoryPieChart(transactions: transactions),
                  // CashFlowLineChart(transactions: transactions),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Monthly Income vs Expense
class IncomeExpenseChart extends StatefulWidget {
  const IncomeExpenseChart({super.key});

  @override
  State<IncomeExpenseChart> createState() => _IncomeExpenseChartState();
}

class _IncomeExpenseChartState extends State<IncomeExpenseChart> {
  List<FinanceItemModel> transactions = [];
  Map<int, Map<String, double>> grouped = {};
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ManageFinanceCubit>(context).getFilteredFinances(
        DateTimeRange(
          start: DateTime(DateTime.now().year, 1, 1),
          end: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    grouped = BlocProvider.of<ManageBarChartCubit>(
      context,
    ).getGroupByMonth(transactions);
    return BlocConsumer<ManageFinanceCubit, ManageFinanceState>(
      listener: (context, state) {
        if (state is GetFilteredFinancesSuccessState) {
          transactions = state.financeItems;
          setState(() {});
        }
      },
      builder: (context, state) {
        return BarChart(
          BarChartData(
            barGroups:
                grouped.entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value['income']!,
                        color: Colors.green,
                        width: 8,
                      ),
                      BarChartRodData(
                        toY: entry.value['expense']!,
                        color: Colors.red,
                        width: 8,
                      ),
                    ],
                  );
                }).toList(),
            titlesData: FlTitlesData(
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              // topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      getMonthAbbreviation(context, value.toInt()),
                      style: const TextStyle(fontSize: 12),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CategoryPieChart extends StatefulWidget {
  const CategoryPieChart({super.key});

  @override
  State<CategoryPieChart> createState() => _CategoryPieChartState();
}

class _CategoryPieChartState extends State<CategoryPieChart> {
    List<FinanceItemModel> transactions = [];
    Map<int, double> totals = {};

  Color _getCategoryColor(int ind) {
    String? colorHex = getCategoryById(ind)?.colorHex;
    return getColorfromHex(colorHex);
  }


  CategoryModel? getCategoryById(int? categoryId) {
    return BlocProvider.of<ManageCategoryCubit>(
      context,
    ).getCategoryById(categoryId)!;
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ManageFinanceCubit>(context).getFilteredFinances(
        DateTimeRange(
          start: DateTime(DateTime.now().year, 1, 1),
          end: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    totals = BlocProvider.of<ManagePieChartCubit>(
      context,
    ).getGroupByCategory(transactions);
    final total = totals.values.fold(0.0, (a, b) => a + b);
    return BlocConsumer<ManageFinanceCubit, ManageFinanceState>(
      listener: (context, state) {
        if (state is GetFilteredFinancesSuccessState) {
          transactions = state.financeItems;
          setState(() {});
        }
      },
      builder: (context, state) {
        return PieChart(
          PieChartData(
            sections:
                totals.entries.map((entry) {
                  final percentage = entry.value / total * 100;
                  return PieChartSectionData(
                    value: entry.value,
                    title: '${getCategoryById(entry.key)?.name}\n${percentage.toStringAsFixed(1)}%',
                    color: _getCategoryColor(entry.key),
                  );
                }).toList(),
          ),
        );
      },
    );
  }
}

// // Cash Flow Line Chart
// class CashFlowLineChart extends StatelessWidget {
//   final List<FinanceItemModel> transactions;
//   const CashFlowLineChart({required this.transactions});

//   List<FlSpot> _calculateCumulativeBalance(List<FinanceItemModel> items) {
//     final sorted = [...items]..sort((a, b) => a.dateTime.compareTo(b.dateTime));
//     double balance = 0;
//     List<FlSpot> spots = [];
//     for (int i = 0; i < sorted.length; i++) {
//       balance += sorted[i].amount;
//       spots.add(FlSpot(i.toDouble(), balance));
//     }
//     return spots;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final spots = _calculateCumulativeBalance(transactions);
//     return LineChart(
//       LineChartData(
//         lineBarsData: [
//           LineChartBarData(
//             spots: spots,
//             isCurved: true,
//             color: Colors.blue,
//             belowBarData: BarAreaData(
//               show: true,
//               color: Colors.blue.withOpacity(0.3),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
