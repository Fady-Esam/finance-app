import 'dart:developer';
import 'package:finance_flutter_app/features/home/data/models/finance_item_model.dart';
import 'package:finance_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../category/data/models/category_model.dart';
import '../../../data/enums/transaction_type_enum.dart';
import '../../manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
import '../../manager/cubits/manage_finance_cubit/manage_finance_state.dart';
import '../manage_finance_view.dart';
import 'custom_home_container.dart';
import 'finance_list_view_builder.dart';
import 'transaction_button.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<FinanceItemModel> financeItems = [];
  double allTotalBalance = 0.0;
  double todayTotalBalance = 0.0;
  Map<int, CategoryModel> categoryMap = {};
  void getFinancesByDay() {
    BlocProvider.of<ManageFinanceCubit>(
      context,
    ).getFinancesByDate(DateTime.now());
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getFinancesByDay();
    });
  }

  String formatAmount(double value) {
    double absValue = value.abs();
    String format(double val, String suffix) {
      String formattedValue =
          val == 0 ? '0.0' : val.toStringAsFixed(val == val.toInt() ? 1 : 2);
      if (formattedValue.endsWith('.00')) {
        formattedValue = formattedValue.substring(0, formattedValue.length - 3);
      }
      return formattedValue + suffix;
    }

    if (absValue >= 1000000000) {
      return format(value / 1000000000, 'B');
    } else if (absValue >= 1000000) {
      return format(value / 1000000, 'M');
    } else if (absValue >= 1000) {
      return format(value / 1000, 'K');
    } else {
      return format(value, '');
    }
  }

  Future<void> _onRefresh() async {
    getFinancesByDay();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            BlocConsumer<ManageFinanceCubit, ManageFinanceState>(
              listener: (context, state) {
                if (state is GetAllTotalBalanceSuccessState) {
                  allTotalBalance = state.totalBalance;
                } else if (state is GetAllTotalBalanceFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context).somethingWentWrong)),
                  );
                  log(state.failureMessage.toString());
                }
              },
              builder: (context, state) {
                return CustomHomeContainer(
                  title: S.of(context).my_balance,
                  balance: formatAmount(allTotalBalance),
                  color: Colors.pink,
                );
              },
            ),
            const SizedBox(height: 10),
            BlocConsumer<ManageFinanceCubit, ManageFinanceState>(
              listener: (context, state) {
                if (state is GetTodayTotalBalanceSuccessState) {
                  todayTotalBalance = state.totalBalance;
                } else if (state is GetTodayTotalBalanceFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context).somethingWentWrong)),
                  );
                  log(state.failureMessage.toString());
                }
              },
              builder: (context, state) {
                return CustomHomeContainer(
                  title: S.of(context).today_total_balance,
                  balance: formatAmount(todayTotalBalance),
                  color: const Color.fromARGB(255, 241, 234, 53),
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ManageTransactionView.routeName,
                      arguments: {
                        'transactionTypeEnum': TransactionTypeEnum.plus,
                      },
                    );
                  },
                  child: TransactionButton(
                    title: S.of(context).plus,
                    icon: const Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 60, 58, 58),
                    ),
                    color: Colors.green,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ManageTransactionView.routeName,
                      arguments: {
                        'transactionTypeEnum': TransactionTypeEnum.minus,
                      },
                    );
                  },
                  child: TransactionButton(
                    title: S.of(context).minus,
                    icon: const Icon(
                      Icons.remove,
                      color: Color.fromARGB(255, 60, 58, 58),
                    ),
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 16),
              child: Align(
                alignment:
                    Directionality.of(context) == TextDirection.ltr
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                child: Text(
                  S.of(context).todya_activity,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),

            BlocConsumer<ManageFinanceCubit, ManageFinanceState>(
              listener: (context, state) {
                if (state is GetFinancesByDateFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context).somethingWentWrong)),
                  );
                  log(state.failureMessage.toString());
                } else if (state is GetFinancesByDateSuccessState) {
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
                        'currentDateTime': DateTime.now(),
                        "categoryId": financeItemModel.categoryId,
                        'filterTransactionModel' : null,
                      },
                    );
                  },
                  onDelete: (financeItemModel) async {
                    await financeItemModel.delete();
                    BlocProvider.of<ManageFinanceCubit>(
                      context,
                    ).getFinancesByDate(DateTime.now());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
