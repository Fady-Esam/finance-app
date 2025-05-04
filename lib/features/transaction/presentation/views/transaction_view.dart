import 'dart:developer';

import 'package:finance_flutter_app/core/funcs/is_same_date.dart';
import 'package:finance_flutter_app/features/category/data/models/category_model.dart';
import 'package:finance_flutter_app/features/category/presentation/manager/cubits/manage_category_cubit/manage_category_cubit.dart';
import 'package:finance_flutter_app/features/category/presentation/manager/cubits/manage_category_cubit/manage_category_state.dart';
import 'package:finance_flutter_app/features/home/presentation/views/widgets/finance_list_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../home/data/enums/transaction_type_enum.dart';
import '../../../home/data/models/finance_item_model.dart';
import '../../../home/presentation/manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
import '../../../home/presentation/manager/cubits/manage_finance_cubit/manage_finance_state.dart';
import '../../../home/presentation/views/manage_finance_view.dart';
import 'widgets/category_filter.dart';
import 'widgets/date_filter.dart';
import 'widgets/transaction_type_toggle.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).transactions)),
      body: FilterBar(),
    );
  }
}

class FilterBar extends StatefulWidget {
  const FilterBar({super.key});

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  CategoryModel? selectedCategory;
  DateTime selectedDate = DateTime.now();
  List<FinanceItemModel> financeItems = [];
  List<CategoryModel> categories = [];
  bool? selectedtransactiontypeValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ManageFinanceCubit>(
        context,
      ).getFilteredFinances(selectedDate);
      BlocProvider.of<ManageCategoryCubit>(context).getAllCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: DateFilter(
                selectedDate: selectedDate,
                onDateChanged: (pickedDate) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                  BlocProvider.of<ManageFinanceCubit>(
                    context,
                  ).getFilteredFinances(
                    selectedDate,
                    categoryId: selectedCategory?.key,
                  );
                  if(isSameDate(DateTime.now(), selectedDate)) {
                    BlocProvider.of<ManageFinanceCubit>(
                      context,
                    ).getFinancesByDate(DateTime.now());
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: BlocConsumer<ManageCategoryCubit, ManageCategoryState>(
                listener: (context, state) {
                  if (state is GetAllCategoryFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(S.of(context).somethingWentWrong)),
                    );
                    log(state.failureMessage.toString());
                  } else if (state is GetAllCategorySuccessState) {
                    categories = state.categoryItems;
                    setState(() {});
                  }
                },
                builder: (context, state) {
                  return CategoryFilter(
                    selectedCategory: selectedCategory,
                    categories: categories,
                    onCategoryChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                      BlocProvider.of<ManageFinanceCubit>(
                        context,
                      ).getFilteredFinances(
                        selectedDate,
                        categoryId: selectedCategory?.key,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TransactionTypeToggle(
          onTransactionTypeChanged: (value) {
            BlocProvider.of<ManageFinanceCubit>(context).getFilteredFinances(
              selectedDate,
              categoryId: selectedCategory?.key,
              isAmountPositive: value,
            );
            setState(() {
              selectedtransactiontypeValue = value;
            });
          },
          selectedTransactionType: selectedtransactiontypeValue,
        ),
        const SizedBox(height: 8),
        Expanded(
          child: BlocConsumer<ManageFinanceCubit, ManageFinanceState>(
            listener: (context, state) {
              if (state is GetFilteredFinancesFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(S.of(context).somethingWentWrong)),
                );
                log(state.failureMessage.toString());
              } else if (state is GetFilteredFinancesSuccessState) {
                financeItems = state.financeItems;
              }
            },
            builder: (context, state) {
              return FinanceListViewBuilder(
                financeItems: financeItems,
                onEdit: (financeItemModel) {
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
                      'currentDateTime': selectedDate,
                      "categoryId": financeItemModel.categoryId,
                    },
                  );
                },
                onDelete: (financeItemModel) async {
                  await financeItemModel.delete();
                  BlocProvider.of<ManageFinanceCubit>(
                    context,
                  ).getFilteredFinances(
                    selectedDate,
                    categoryId: selectedCategory?.key,
                    isAmountPositive: selectedtransactiontypeValue,
                  );
                  if (isSameDate(DateTime.now(), selectedDate)) {
                    BlocProvider.of<ManageFinanceCubit>(
                      context,
                    ).getFinancesByDate(DateTime.now());
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
