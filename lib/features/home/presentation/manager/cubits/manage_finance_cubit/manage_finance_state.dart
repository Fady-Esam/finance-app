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

//! Delete
class DeleteFinanceLoadingState extends ManageFinanceState {}

class DeleteFinanceFailureState extends ManageFinanceState {
  final String? failureMessage;

  DeleteFinanceFailureState({required this.failureMessage});
}

class DeleteFinanceSuccessState extends ManageFinanceState {}

//! Update
class UpdateFinanceLoadingState extends ManageFinanceState {}

class UpdateFinanceFailureState extends ManageFinanceState {
  final String? failureMessage;

  UpdateFinanceFailureState({required this.failureMessage});
}

class UpdateFinanceSuccessState extends ManageFinanceState {}

//! Get All

class GetAllFinanceLoadingState extends ManageFinanceState {}

class GetAllFinanceFailureState extends ManageFinanceState {
  final String? failureMessage;

  GetAllFinanceFailureState({required this.failureMessage});
}

class GetAllFinanceSuccessState extends ManageFinanceState {
  final List<FinanceItemModel> financeItems;

  GetAllFinanceSuccessState({required this.financeItems});
}


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
class GetTodayFinanceSuccessState extends ManageFinanceState {
  final List<FinanceItemModel> financeItems;

  GetTodayFinanceSuccessState({required this.financeItems});
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





