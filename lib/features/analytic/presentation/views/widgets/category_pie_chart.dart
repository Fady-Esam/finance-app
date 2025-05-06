import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/color_utils.dart';
import '../../../../category/data/models/category_model.dart';
import '../../../../category/presentation/manager/cubits/manage_category_cubit/manage_category_cubit.dart';
import '../../../../home/data/models/finance_item_model.dart';
import '../../manager/cubits/manage_pie_chart_cubit/manage_pie_chart_cubit.dart';

// class CategoryPieChart extends StatefulWidget {
//   const CategoryPieChart({super.key, required this.transactions});
//   final List<FinanceItemModel> transactions;

//   @override
//   State<CategoryPieChart> createState() => _CategoryPieChartState();
// }

// class _CategoryPieChartState extends State<CategoryPieChart> {
//   @override
//   Widget build(BuildContext context) {
//     // Calculate totals and pie chart sections
//     final managePieChartCubit = BlocProvider.of<ManagePieChartCubit>(context);
//     final totals = managePieChartCubit.getGroupByCategory(widget.transactions);
//     final totalAmount = totals.values.fold(0.0, (sum, val) => sum + val);

//     // Generate pie chart sections
//     final pieSections =
//         totals.entries.map((entry) {
//           final percentage = (entry.value / totalAmount) * 100;
//           final title = getCategoryById(context, entry.key)?.name;
//           return PieChartSectionData(
//             value: entry.value,
//             title: '$title\n${percentage.toStringAsFixed(1)}%',
//             color: _getCategoryColor(context, entry.key),
//             radius: 60,
//             titleStyle: const TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.bold,
//             ),
//           );
//         }).toList();

//     return PieChart(
//       PieChartData(
//         sections: pieSections,
//         pieTouchData: PieTouchData(
//           touchCallback: (
//             FlTouchEvent event,
//             PieTouchResponse? pieTouchResponse,
//           ) {
//             // Only handle tap-up events to avoid multiple triggers
//             if (event is! FlTapUpEvent ||
//                 !event.isInterestedForInteractions ||
//                 pieTouchResponse?.touchedSection == null) {
//               return;
//             }

//             final sectionIndex =
//                 pieTouchResponse!.touchedSection!.touchedSectionIndex;
//             if (sectionIndex < 0 || sectionIndex >= pieSections.length) return;

//             final section = pieSections[sectionIndex];
//             final title =
//                 section.title.split(
//                   '\n',
//                 )[0]; // Extract title without percentage
//             final value = section.value;

//             // Show dialog with proper focus handling
//           },
//         ),
//       ),
//     );
//   }

//   Color _getCategoryColor(BuildContext context, int ind) {
//     final colorHex = getCategoryById(context, ind)?.colorHex;
//     return getColorfromHex(colorHex);
//   }

//   CategoryModel? getCategoryById(BuildContext context, int? categoryId) {
//     return BlocProvider.of<ManageCategoryCubit>(
//       context,
//     ).getCategoryById(categoryId);
//   }
// }

class CategoryPieChart extends StatelessWidget {
  const CategoryPieChart({super.key, required this.transactions});
  final List<FinanceItemModel> transactions;

  @override
  Widget build(BuildContext context) {
    bool _dialogVisible = false;
    Map<int, double> totals = BlocProvider.of<ManagePieChartCubit>(
      context,
    ).getGroupByCategory(transactions);
    final totalAmount = totals.values.fold(0.0, (sum, val) => sum + val);
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
            if (_dialogVisible) return;
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
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            _dialogVisible = false;
                            Navigator.pop(dialogContext);
                          },
                        ),
                      ],
                    ),
                    content: Text('Value: ${value.toStringAsFixed(2)}'),
                  ),
            );
            _dialogVisible = true;
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
    ).getCategoryById(categoryId)!;
  }
}
