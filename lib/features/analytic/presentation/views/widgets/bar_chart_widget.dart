import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../core/funcs/get_month_abbreviation.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({
    super.key,
    required this.grouped,
    required this.maxValue,
  });

  final Map<int, Map<String, double>> grouped;
  final double maxValue;

  @override
  Widget build(BuildContext context) {
    return BarChart(
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
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 60,
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
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
    );
  }
}
