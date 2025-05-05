import 'dart:developer';
import 'package:finance_flutter_app/features/category/data/models/category_model.dart';
import 'package:finance_flutter_app/features/category/presentation/manager/cubits/manage_category_cubit/manage_category_cubit.dart';
import 'package:finance_flutter_app/features/category/presentation/manager/cubits/manage_category_cubit/manage_category_state.dart';
import 'package:finance_flutter_app/features/home/presentation/views/widgets/finance_list_view_builder.dart';
import 'package:finance_flutter_app/features/transaction/presentation/views/widgets/date_range_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../generated/l10n.dart';
import '../../../../home/data/models/finance_item_model.dart';
import '../../../../home/presentation/manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
import '../../../../home/presentation/manager/cubits/manage_finance_cubit/manage_finance_state.dart';
import 'category_filter.dart';
import 'transaction_type_toggle.dart';

class TransactionViewBody extends StatefulWidget {
  const TransactionViewBody({super.key, this.searchedText});
  final String? searchedText;
  @override
  State<TransactionViewBody> createState() => _TransactionViewBodyState();
}

class _TransactionViewBodyState extends State<TransactionViewBody> {
  CategoryModel? selectedCategory;
  DateTime selectedDate = DateTime.now();
  List<FinanceItemModel> financeItems = [];
  List<CategoryModel> categories = [];
  bool? selectedtransactiontypeValue;
  DateTimeRange selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 7)),
    end: DateTime.now(),
  );
  void getFilteredFinances() {
    BlocProvider.of<ManageFinanceCubit>(context).getFilteredFinances(
      selectedDateRange,
      categoryId: selectedCategory?.key,
      isAmountPositive: selectedtransactiontypeValue,
    );
  }

  Future<void> onRefresh() async {
    getFilteredFinances();
    BlocProvider.of<ManageCategoryCubit>(context).getAllCategories();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: DateRangeFilter(
                      onTap: () async {
                        final now = DateTime.now();
                        final picked = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(now.year - 5),
                          lastDate: DateTime(now.year + 1),
                          initialDateRange: selectedDateRange,
                        );
                        if (picked != null) {
                          setState(() {
                            selectedDateRange = picked;
                          });
                          getFilteredFinances();
                        }
                      },
                      selectedDateRange: selectedDateRange,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child:
                        BlocConsumer<ManageCategoryCubit, ManageCategoryState>(
                          listener: (context, state) {
                            if (state is GetAllCategoryFailureState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    S.of(context).somethingWentWrong,
                                  ),
                                ),
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
                                getFilteredFinances();
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
                  setState(() {
                    selectedtransactiontypeValue = value;
                  });
                  getFilteredFinances();
                },
                selectedTransactionType: selectedtransactiontypeValue,
              ),
              const SizedBox(height: 8),
              BlocConsumer<ManageFinanceCubit, ManageFinanceState>(
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
                  final filteredItems =
                      widget.searchedText == null
                          ? financeItems
                          : financeItems.where((item) {
                            if (widget.searchedText!.trim().isEmpty) {
                              return item.title.isEmpty;
                            }
                            final query = widget.searchedText!.toLowerCase();
                            return item.title.toLowerCase().contains(query);
                          }).toList();
                  return FinanceListViewBuilder(
                    financeItems: filteredItems,
                    isFromHomePage: false,
                    currentDateTime: selectedDate,
                    categoryFilterId: selectedCategory?.key,
                    isAmountPositive: selectedtransactiontypeValue,
                    dateTimeRange: selectedDateRange,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
