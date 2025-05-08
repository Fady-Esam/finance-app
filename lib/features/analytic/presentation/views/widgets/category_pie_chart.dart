
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/color_utils.dart';
import '../../../../../generated/l10n.dart';
import '../../../../category/data/models/category_model.dart';
import '../../../../category/presentation/manager/cubits/manage_category_cubit/manage_category_cubit.dart';
import '../../../../home/data/models/finance_item_model.dart';
import '../../manager/cubits/manage_pie_chart_cubit/manage_pie_chart_cubit.dart';


class CategoryPieChart extends StatelessWidget {
  const CategoryPieChart({super.key, required this.transactions});
  final List<FinanceItemModel> transactions;
  @override
  Widget build(BuildContext context) {
    bool dialogVisible = false;
    Map<int, double> totals = BlocProvider.of<ManagePieChartCubit>(
      context,
    ).getGroupByCategory(transactions);
    final totalAmount = totals.values.fold(0.0, (sum, val) => sum + val);
        if (totals.isEmpty) {
      return Center(child:Text(S.of(context).no_category_data),);
    }

    final pieSections =
        totals.entries.map((entry) {
          final percentage = (entry.value / totalAmount) * 100;
          final title = getCategoryById(context, entry.key)?.name;
          return PieChartSectionData(
            value: entry.value,
            title:
                title != null && title.trim().isNotEmpty
                    ? '$title\n${percentage.toStringAsFixed(1)}%'
                    : '${percentage.toStringAsFixed(1)}%',
            color: _getCategoryColor(context, entry.key),
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          );
        }).toList();
    return PieChart(
      PieChartData(
        sections: pieSections,
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            if (dialogVisible) return;
            if (!event.isInterestedForInteractions ||
                pieTouchResponse?.touchedSection == null) {
              return;
            }
            final sectionIndex =
                pieTouchResponse!.touchedSection!.touchedSectionIndex;
            if (sectionIndex < 0 || sectionIndex >= pieSections.length) return;
            final section = pieSections[sectionIndex];
            final title = section.title;
            final value = section.value;
            showDialog(
              context: context,
              builder:
                  (dialogContext) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            dialogVisible = false;
                            Navigator.pop(dialogContext);
                          },
                        ),
                      ],
                    ),
                    content: Row(
                      children: [
                        Text(
                          S.of(context).value,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          value.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
            );
            dialogVisible = true;
          },
        ),
      ),
    );
  }

  Color _getCategoryColor(BuildContext context, int ind) {
    String? colorHex = getCategoryById(context, ind)?.colorHex;
    return getColorfromHex(colorHex);
  }

  CategoryModel? getCategoryById(BuildContext context, int? categoryId) {
    return BlocProvider.of<ManageCategoryCubit>(
      context,
    ).getCategoryById(categoryId);
  }
}
