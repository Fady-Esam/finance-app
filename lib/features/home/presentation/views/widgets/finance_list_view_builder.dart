
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../category/presentation/manager/cubits/manage_category_cubit/manage_category_cubit.dart';
import '../../../../category/presentation/manager/cubits/manage_category_cubit/manage_category_state.dart';
import '../../../data/enums/transaction_type_enum.dart';
import '../../../data/models/finance_item_model.dart';
import '../../manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
import '../manage_finance_view.dart';
import 'finance_item.dart';

class FinanceListViewBuilder extends StatefulWidget {
  const FinanceListViewBuilder({
    super.key,
    required this.financeItems,
    this.isFromHomePage = true,
    required this.currentDateTime,
    this.categoryFilterId,
    this.isAmountPositive,
    this.dateTimeRange,
  });
  final List<FinanceItemModel> financeItems;
  final bool isFromHomePage;
  final DateTime currentDateTime;
  final int? categoryFilterId;
  final bool? isAmountPositive;
  final DateTimeRange? dateTimeRange;

  @override
  State<FinanceListViewBuilder> createState() => _FinanceListViewBuilderState();
}

class _FinanceListViewBuilderState extends State<FinanceListViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageCategoryCubit, ManageCategoryState>(
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.financeItems.length,
          itemBuilder: (context, index) {
            final financeItemModel =
                widget.financeItems.reversed.toList()[index];
            final categoryIds =
                widget.financeItems.map((e) => e.categoryId).toSet();
            final category =
                BlocProvider.of<ManageCategoryCubit>(
                  context,
                ).getCategoriesByIds(categoryIds)[financeItemModel.categoryId];
            return Dismissible(
              key: ValueKey(financeItemModel.key),
              confirmDismiss: (DismissDirection direction) async {
                if (direction == DismissDirection.startToEnd) {
                  // Swipe from left to right --> EDIT
                  Navigator.pushNamed(
                    context,
                    ManageTransactionView.routeName,
                    arguments: {
                      'transactionTypeEnum':
                          financeItemModel.amount < 0
                              ? TransactionTypeEnum.editMinus
                              : TransactionTypeEnum.editPlus,
                      'financeItemModel': financeItemModel,
                      'modelDateTime': financeItemModel.dateTime,
                      'currentDateTime': widget.currentDateTime,
                      'isFromHomePage': widget.isFromHomePage,
                      'categoryFilteredId': widget.categoryFilterId,
                      'isAmountPositive': widget.isAmountPositive,
                      'dateTimeRange': widget.dateTimeRange,
                      'endDate': financeItemModel.recurrenceEndDate,
                      'recurrenceType': financeItemModel.recurrence,
                    },
                  );
                  return false; // <<< DON'T dismiss the item
                } else if (direction == DismissDirection.endToStart) {
                  // Swipe from right to left --> DELETE
                  await financeItemModel.delete();
                  if (widget.isFromHomePage) {
                    BlocProvider.of<ManageFinanceCubit>(
                      context,
                    ).getFinancesByDate(DateTime.now());
                  } else {
                    BlocProvider.of<ManageFinanceCubit>(
                      context,
                    ).getFilteredFinances(
                      widget.dateTimeRange!,
                      categoryId: widget.categoryFilterId,
                      isAmountPositive: widget.isAmountPositive,
                    );
                  }
                  BlocProvider.of<ManageFinanceCubit>(
                    context,
                  ).getChartsFinances();
                  return true; // <<< Allow dismiss
                }
                return false;
              },
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: const Color.fromARGB(255, 131, 187, 234),
                alignment:
                    Directionality.of(context) == TextDirection.ltr
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                child: const Icon(Icons.edit),
              ),
              secondaryBackground: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: const Color.fromARGB(255, 229, 120, 113),
                alignment:
                    Directionality.of(context) == TextDirection.ltr
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                child: const Icon(Icons.delete),
              ),
              child: FinanceItem(
                financeItemModel: financeItemModel,
                categoryItem: category,
              ),
            );
          },
        );
      },
    );
  }
}
