import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/funcs/get_month_abbreviation.dart';
import '../../../../../generated/l10n.dart';
import '../../../../home/data/models/finance_item_model.dart';
import '../../manager/cubits/manage_line_cubit/manage_line_chart_cubit.dart';

class CashFlowLineChart extends StatelessWidget {
  const CashFlowLineChart({super.key, required this.transactions});
  final List<FinanceItemModel> transactions;
  @override
  Widget build(BuildContext context) {
    List<FlSpot> spots = BlocProvider.of<ManageLineChartCubit>(
      context,
    ).calculateCumulativeBalance(transactions);
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 8,
            fitInsideHorizontally: true,
            fitInsideVertically: true, // This prevents clipping at top
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                return LineTooltipItem(
                  S
                      .of(context)
                      .tooltipBalanceLabel(
                        touchedSpot.x.toInt(),
                        touchedSpot.y.toStringAsFixed(2),
                      ),
                  const TextStyle(color: Colors.white),
                );
              }).toList();
            },
          ),
        ),
        minX: 1,
        maxX: 12,
        // minY:
        //     spots.isEmpty
        //         ? 0
        //         : spots.map((spot) => spot.y).reduce((a, b) => a < b ? a : b) -
        //             50, // Add margin below the minimum value
        maxY:
            spots.isEmpty
                ? 1000
                : spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b) +
                    50, // Add margin above the maximum value
        // minY:
        //     -50, // This can be adjusted if needed (e.g., based on the minimum value of the data)
        // maxY:
        //     spots.isEmpty
        //         ? 1000
        //         : spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b) *
        //             1.1, // Add 20% padding
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
        titlesData: FlTitlesData(
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
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                final month = value.toInt();
                if (month < 1 || month > 12) return const SizedBox.shrink();
                return Text(
                  getMonthAbbreviation(context, month),
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.blueAccent,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Color.fromRGBO(0, 145, 234, 0.2),
            ),
          ),
        ],
      ),
    );
  }
}
