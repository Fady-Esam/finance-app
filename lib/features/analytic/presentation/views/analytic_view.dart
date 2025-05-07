import 'dart:developer';

import 'package:finance_flutter_app/features/analytic/data/repos/analytic_repo_impl.dart';
import 'package:finance_flutter_app/features/analytic/presentation/manager/cubits/manage_bar_chart_cubit/manage_bar_chart_cubit.dart';
import 'package:finance_flutter_app/features/analytic/presentation/manager/cubits/manage_line_cubit/manage_line_chart_cubit.dart';
import 'package:finance_flutter_app/features/home/presentation/manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
import 'package:finance_flutter_app/features/home/presentation/manager/cubits/manage_finance_cubit/manage_finance_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../home/data/models/finance_item_model.dart';
import '../manager/cubits/manage_pie_chart_cubit/manage_pie_chart_cubit.dart';
import 'widgets/cash_flow_line_chart.dart';
import 'widgets/category_pie_chart.dart';
import 'widgets/income_expense_bar_chart.dart';

// Main AnalyticView
class AnalyticView extends StatefulWidget {
  const AnalyticView({super.key});

  @override
  State<AnalyticView> createState() => _AnalyticViewState();
}

class _AnalyticViewState extends State<AnalyticView>
    /*with AutomaticKeepAliveClientMixin */{
  // @override
  // bool get wantKeepAlive => true;
  List<FinanceItemModel> transactions = [];
  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ManageFinanceCubit>(context).getChartsFinances();
    });
  }

  @override
  Widget build(BuildContext context) {
    //super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ManageBarChartCubit(analyticRepo: AnalyticRepoImpl()),
        ),
        BlocProvider(
          create: (_) => ManagePieChartCubit(analyticRepo: AnalyticRepoImpl()),
        ),
        BlocProvider(
          create: (_) => ManageLineChartCubit(analyticRepo: AnalyticRepoImpl()),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: S.of(context).monthly),
                    Tab(text: S.of(context).categories),
                    Tab(text: S.of(context).cashflow),
                  ],
                ),
                Expanded(
                  child: BlocConsumer<ManageFinanceCubit, ManageFinanceState>(
                    listener: (context, state) {
                      if (state is GetChartsFinancesFailureState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(S.of(context).somethingWentWrong),
                          ),
                        );
                        log(state.failureMessage.toString());
                      } else if (state is GetChartsFinancesSuccessState) {
                        transactions = state.financeItems;
                        setState(() {});
                      }
                    },
                    builder: (context, state) {
                      return TabBarView(
                        children: [
                          IncomeExpenseBarChart(transactions: transactions),
                          CategoryPieChart(transactions: transactions),
                          CashFlowLineChart(transactions: transactions),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
