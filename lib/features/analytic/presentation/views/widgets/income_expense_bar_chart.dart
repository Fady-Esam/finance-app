// Monthly Income vs Expense
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/funcs/get_month_abbreviation.dart';
import '../../../../../generated/l10n.dart';
import '../../../../home/data/models/finance_item_model.dart';
import '../../manager/cubits/manage_bar_chart_cubit/manage_bar_chart_cubit.dart';

class IncomeExpenseBarChart extends StatelessWidget {
  const IncomeExpenseBarChart({super.key, required this.transactions});
  final List<FinanceItemModel> transactions;

  @override
  Widget build(BuildContext context) {
    Map<int, Map<String, double>> grouped =
        BlocProvider.of<ManageBarChartCubit>(
          context,
        ).getGroupByMonth(transactions);
    final maxValue = grouped.values
        .expand((e) => e.values)
        .fold<double>(0, (prev, next) => next > prev ? next : prev);
    return Column(
      children: [
        Expanded(
          child: BarChart(
            BarChartData(
              // alignment: BarChartAlignment.end,
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                ),
              ),
              barGroups:
                  grouped.entries.map((entry) {
                    return BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value['income']!,
                          color: Colors.green,
                          width: 6,
                        ),
                        BarChartRodData(
                          toY: entry.value['expense']!,
                          color: Colors.red,
                          width: 6,
                        ),
                      ],
                    );
                  }).toList(),
              maxY: maxValue + 100,
              titlesData: FlTitlesData(
                // leftTitles: AxisTitles(
                //   sideTitles: SideTitles(showTitles: true),
                // ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    // getTitlesWidget: (value, meta) {
                    //   return Padding(
                    //     padding: const EdgeInsets.only(
                    //       right: 6.0,
                    //     ), // 👈 spacing from axis line
                    //     child: Text(
                    //       formatNumberAsK(value), // optional: format 1000 -> 1k
                    //       style: const TextStyle(fontSize: 10),
                    //     ),
                    //   );
                    // },
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        getMonthAbbreviation(context, value.toInt()),
                        style: const TextStyle(fontSize: 10),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BuildLegendItemCustomWidget(
              color: Colors.green,
              label: S.of(context).income,
            ),
            const SizedBox(width: 16),
            BuildLegendItemCustomWidget(
              color: Colors.red,
              label: S.of(context).expense,
            ),
          ],
        ),
      ],
    );
  }
}

class BuildLegendItemCustomWidget extends StatelessWidget {
  const BuildLegendItemCustomWidget({
    super.key,
    required this.color,
    required this.label,
  });
  final Color color;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
