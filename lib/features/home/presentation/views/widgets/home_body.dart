import 'dart:developer';
import 'package:finance_flutter_app/features/home/data/models/finance_item_model.dart';
import 'package:finance_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/enums/transaction_type_enum.dart';
import '../../manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
import '../../manager/cubits/manage_finance_cubit/manage_finance_state.dart';
import '../all_activities_view.dart';
import '../manage_transaction_view.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ManageFinanceCubit>(
        context,
      ).getFinancesByDay(DateTime.now());
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
      //log((formattedValue + suffix).toString());
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
    BlocProvider.of<ManageFinanceCubit>(
      context,
    ).getFinancesByDay(DateTime.now());
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).activity,
                    style: const TextStyle(fontSize: 22),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AllActivitiesView.routeName);
                    },
                    child: Text(
                      S.of(context).see_all,
                      style: const TextStyle(fontSize: 19),
                    ),
                  ),
                ],
              ),
            ),
            BlocConsumer<ManageFinanceCubit, ManageFinanceState>(
              listener: (context, state) {
                if (state is GetFinancesByDayFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context).somethingWentWrong)),
                  );
                  log(state.failureMessage.toString());
                } else if (state is GetTodayFinanceSuccessState) {
                  financeItems = state.financeItems;
                } else if (state is DeleteFinanceFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context).somethingWentWrong)),
                  );
                  log(state.failureMessage.toString());
                } /*else if (state is DeleteFinanceSuccessState) {}*/
              },
              builder: (context, state) {
                return FinanceListViewBuilder(
                  financeItems: financeItems,
                  currentDateTime: DateTime.now(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
