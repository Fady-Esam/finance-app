import 'dart:developer';
import 'package:finance_flutter_app/features/category/data/models/category_model.dart';
import 'package:finance_flutter_app/features/category/presentation/manager/cubits/manage_category_cubit/manage_category_cubit.dart';
import 'package:finance_flutter_app/features/category/presentation/manager/cubits/manage_category_cubit/manage_category_state.dart';
import 'package:finance_flutter_app/features/home/data/models/balance_summary.dart';
import 'package:finance_flutter_app/features/home/presentation/views/widgets/finance_list_view_builder.dart';
import 'package:finance_flutter_app/features/transaction/presentation/views/widgets/date_range_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../generated/l10n.dart';
import '../../../../home/data/models/finance_item_model.dart';
import '../../../../home/presentation/manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
import '../../../../home/presentation/manager/cubits/manage_finance_cubit/manage_finance_state.dart';
import '../../../../user_setup/data/models/user_setup_model.dart';
import '../../../../user_setup/presentation/manager/cubits/manage_user_setup_cubit/manage_user_setup_cubit.dart';
import 'build_summary_item_custom_widget.dart';
import 'category_filter.dart';
import 'transaction_type_toggle.dart';

class TransactionViewBody extends StatefulWidget {
  const TransactionViewBody({
    super.key,
    this.searchedText,
    this.isSearching = false,
  });
  final String? searchedText;
  final bool isSearching;
  @override
  State<TransactionViewBody> createState() => _TransactionViewBodyState();
}

class _TransactionViewBodyState extends State<TransactionViewBody> {
  CategoryModel? selectedCategory;
  DateTime selectedDate = DateTime.now();
  List<FinanceItemModel> financeItems = [];
  List<CategoryModel> categories = [];
  bool? selectedtransactiontypeValue;
  var balSum = BalanceSummary();
  DateTimeRange selectedDateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime.now(),
  );
  UserSetupModel? userSetupModel;
  Future<void> getUserSetupModelData() async {
    userSetupModel =
        await BlocProvider.of<ManageUserSetupCubit>(
          context,
        ).getUserSetupModel();
    setState(() {});
  }

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
    getUserSetupModelData();
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
                        final picked = await showDateRangePicker(
                          context: context,
                          initialDateRange: selectedDateRange,
                          firstDate: DateTime(
                            userSetupModel!.startDateTime.year - 5,
                            1,
                            1,
                          ),
                          lastDate: DateTime.now(),
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
              //const SizedBox(height: 8),
              BlocConsumer<ManageFinanceCubit, ManageFinanceState>(
                listener: (context, state) {
                  if (state is GetTotalBalanceFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(S.of(context).somethingWentWrong)),
                    );
                  } else if (state is GetTotalBalanceSuccessState) {
                    balSum = state.balanceSummary;
                    setState(() {});
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 8,
                    ),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            BuildSummaryItemCustomWidget(
                              label: S.of(context).total_income,
                              value: balSum.totalIncome,
                              color: Colors.green,
                            ),
                            BuildSummaryItemCustomWidget(
                              label: S.of(context).total_expense,
                              value: balSum.totalExpense,
                              color: Colors.red,
                            ),
                            BuildSummaryItemCustomWidget(
                              label: S.of(context).net_balance,
                              value:
                                  balSum.netBalance + (userSetupModel?.balance?? 0.0),
                              color: Colors.blueAccent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
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
                  if (widget.isSearching) {
                    BlocProvider.of<ManageFinanceCubit>(
                      context,
                    ).getTotalBalance(selectedDateRange, items: filteredItems);
                  }
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
