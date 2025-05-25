// Monthly Income vs Expense
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../../../home/data/models/finance_item_model.dart';
import '../../manager/cubits/manage_bar_chart_cubit/manage_bar_chart_cubit.dart';
import 'bar_chart_widget.dart';
import 'build_legend_item_custom_widget.dart';

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
          child: BarChartWidget(grouped: grouped, maxValue: maxValue),
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

