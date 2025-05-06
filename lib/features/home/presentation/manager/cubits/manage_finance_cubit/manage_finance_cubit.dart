import 'package:finance_flutter_app/features/home/data/repos/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/finance_item_model.dart';
import 'manage_finance_state.dart';

class ManageFinanceCubit extends Cubit<ManageFinanceState> {
  ManageFinanceCubit({required this.homeRepo})
    : super(ManageFinanceInitialState());
  final HomeRepo homeRepo;

  Future<void> addFinance(FinanceItemModel item) async {
    emit(AddFinanceLoadingState());
    var res = await homeRepo.addFinance(item);
    res.fold(
      (l) => emit(AddFinanceFailureState(failureMessage: l.technicalMessage)),
      (r) {
        getFinancesByDate(DateTime.now()); //! Now
        getChartsFinances();
        emit(AddFinanceSuccessState());
      },
    );
  }

  void getFilteredFinances(
    DateTimeRange dateRange, {
    int? categoryId,
    bool? isAmountPositive,
  }) {
    emit(GetFilteredFinancesLoadingState());
    var res = homeRepo.getFilteredFinances(
      dateRange,
      categoryId: categoryId,
      isAmountPositive: isAmountPositive,
    );
    res.fold(
      (l) => emit(
        GetFilteredFinancesFailureState(failureMessage: l.technicalMessage),
      ),
      (r) {
        emit(GetFilteredFinancesSuccessState(financeItems: r));
      },
    );
  }

  void getChartsFinances() {
    emit(GetChartsFinancesLoadingState());
    var res = homeRepo.getChartsFinances();
    res.fold(
      (l) => emit(
        GetChartsFinancesFailureState(failureMessage: l.technicalMessage),
      ),
      (r) {
        emit(GetChartsFinancesSuccessState(financeItems: r));
      },
    );
  }

  void getFinancesByDate(DateTime dateTime) {
    emit(GetFinancesByDateLoadingState());
    var res = homeRepo.getFinancesByDate(dateTime);
    res.fold(
      (l) => emit(
        GetFinancesByDateFailureState(failureMessage: l.technicalMessage),
      ),
      (r) {
        emit(GetFinancesByDateSuccessState(financeItems: r));
        getAllTotalBalance();
        getTodayTotalBalance();
      },
    );
  }

  void getAllTotalBalance() {
    emit(GetAllTotalBalanceLoadingState());
    var res = homeRepo.getAllTotalBalance();
    res.fold(
      (l) => emit(
        GetAllTotalBalanceFailureState(failureMessage: l.technicalMessage),
      ),
      (r) => emit(GetAllTotalBalanceSuccessState(totalBalance: r)),
    );
  }

  void getTodayTotalBalance() {
    emit(GetTodayTotalBalanceLoadingState());
    var res = homeRepo.getTodayTotalBalance();
    res.fold(
      (l) => emit(
        GetTodayTotalBalanceFailureState(failureMessage: l.technicalMessage),
      ),
      (r) => emit(GetTodayTotalBalanceSuccessState(totalBalance: r)),
    );
  }

  Future<void> setAllFinancesWithCategoryIdNull(int categoryId) async {
    emit(SetAllFinancesWithCategoryIdNulloadingState());
    var res = await homeRepo.setAllFinancesWithCategoryIdNull(categoryId);
    res.fold(
      (l) => emit(
        SetAllFinancesWithCategoryIdNullFailureState(
          failureMessage: l.technicalMessage,
        ),
      ),
      (r) {
        emit(SetAllFinancesWithCategoryIdNullSuccessState());
      },
    );
  }
}
