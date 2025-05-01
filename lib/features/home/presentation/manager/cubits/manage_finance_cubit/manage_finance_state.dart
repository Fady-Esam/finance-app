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


//! Get By Day

class GetFinancesByDayLoadingState extends ManageFinanceState {}

class GetFinancesByDayFailureState extends ManageFinanceState {
  final String? failureMessage;

  GetFinancesByDayFailureState({required this.failureMessage});
}

class GetFinancesByDaySuccessState extends ManageFinanceState {
  final List<FinanceItemModel> financeItems;

  GetFinancesByDaySuccessState({required this.financeItems});
}

// class GetTodayFinanceSuccessState extends ManageFinanceState {
//   final List<FinanceItemModel> financeItems;

//   GetTodayFinanceSuccessState({required this.financeItems});
// }

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
//! Clear All Finances With Category Id

class SetAllFinancesWithCategoryIdNulloadingState extends ManageFinanceState {}

class SetAllFinancesWithCategoryIdNullFailureState extends ManageFinanceState {
  final String? failureMessage;

  SetAllFinancesWithCategoryIdNullFailureState({required this.failureMessage});
}

class SetAllFinancesWithCategoryIdNullSuccessState extends ManageFinanceState {
  SetAllFinancesWithCategoryIdNullSuccessState();
}
