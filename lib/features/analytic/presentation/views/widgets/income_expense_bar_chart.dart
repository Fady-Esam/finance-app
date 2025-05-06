// Monthly Income vs Expense
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/funcs/get_month_abbreviation.dart';
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
              // barTouchData: BarTouchData(
              //   enabled: true,
              //   touchTooltipData: BarTouchTooltipData(
              //     tooltipRoundedRadius: 12,
              //     fitInsideHorizontally: true,
              //     fitInsideVertically: true,
              //     getTooltipItem: (group, groupIndex, rod, rodIndex) {
              //       final label = rod.toY.toStringAsFixed(2);
              //       return BarTooltipItem(
              //         'Expensed: $label',
              //         const TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       );
              //     },
              //   ),
              // ),
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
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        getMonthAbbreviation(context, value.toInt()),
                        style: const TextStyle(fontSize: 8),
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
            _buildLegendItem(Colors.green, 'Income'),
            const SizedBox(width: 16),
            _buildLegendItem(Colors.red, 'Expense'),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
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
