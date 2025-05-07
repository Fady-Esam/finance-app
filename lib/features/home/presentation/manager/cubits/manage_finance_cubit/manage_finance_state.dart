import 'package:finance_flutter_app/features/home/data/models/balance_summary.dart';

import '../../../../data/models/finance_item_model.dart';

class ManageFinanceState {}

class ManageFinanceInitialState extends ManageFinanceState {}

//! Add
class AddFinanceLoadingState extends ManageFinanceState {}

class AddFinanceFailureState extends ManageFinanceState {
  final String? failureMessage;

  AddFinanceFailureState({required this.failureMessage});
}

class AddFinanceSuccessState extends ManageFinanceState {}


//! Get Filtered Finances

class GetFilteredFinancesLoadingState extends ManageFinanceState {}

class GetFilteredFinancesFailureState extends ManageFinanceState {
  final String? failureMessage;

  GetFilteredFinancesFailureState({required this.failureMessage});
}

class GetFilteredFinancesSuccessState extends ManageFinanceState {
  final List<FinanceItemModel> financeItems;

  GetFilteredFinancesSuccessState({required this.financeItems});
}
//! Get Finances By Date

class GetFinancesByDateLoadingState extends ManageFinanceState {}

class GetFinancesByDateFailureState extends ManageFinanceState {
  final String? failureMessage;

  GetFinancesByDateFailureState({required this.failureMessage});
}

class GetFinancesByDateSuccessState extends ManageFinanceState {
  final List<FinanceItemModel> financeItems;

  GetFinancesByDateSuccessState({required this.financeItems});
}

//! Get Charts Finances
class GetChartsFinancesLoadingState extends ManageFinanceState {}

class GetChartsFinancesFailureState extends ManageFinanceState {
  final String? failureMessage;

  GetChartsFinancesFailureState({required this.failureMessage});
}

class GetChartsFinancesSuccessState extends ManageFinanceState {
  final List<FinanceItemModel> financeItems;

  GetChartsFinancesSuccessState({required this.financeItems});
}


//! Get Today Total Balance

class GetTodayTotalBalanceLoadingState extends ManageFinanceState {}

class GetTodayTotalBalanceFailureState extends ManageFinanceState {
  final String? failureMessage;

  GetTodayTotalBalanceFailureState({required this.failureMessage});
}

class GetTodayTotalBalanceSuccessState extends ManageFinanceState {
  final double totalBalance;

  GetTodayTotalBalanceSuccessState({required this.totalBalance});
}

//! Get All Total Balance
class GetAllTotalBalanceLoadingState extends ManageFinanceState {}

class GetAllTotalBalanceFailureState extends ManageFinanceState {
  final String? failureMessage;

  GetAllTotalBalanceFailureState({required this.failureMessage});
}

class GetAllTotalBalanceSuccessState extends ManageFinanceState {
  final double totalBalance;

  GetAllTotalBalanceSuccessState({required this.totalBalance});
}
//! Get Total Balance
class GetTotalBalanceLoadingState extends ManageFinanceState {}

class GetTotalBalanceFailureState extends ManageFinanceState {
  final String? failureMessage;

  GetTotalBalanceFailureState({required this.failureMessage});
}

class GetTotalBalanceSuccessState extends ManageFinanceState {
  final BalanceSummary balanceSummary;

  GetTotalBalanceSuccessState({required this.balanceSummary});
}



//! Clear All Finances With Category Id

class SetAllFinancesWithCategoryIdNulloadingState extends ManageFinanceState {}

class SetAllFinancesWithCategoryIdNullFailureState extends ManageFinanceState {
  final String? failureMessage;

  SetAllFinancesWithCategoryIdNullFailureState({required this.failureMessage});
}

class SetAllFinancesWithCategoryIdNullSuccessState extends ManageFinanceState {
  SetAllFinancesWithCategoryIdNullSuccessState();
}
