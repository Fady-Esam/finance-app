import 'package:finance_flutter_app/features/home/data/repos/home_repo.dart';
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
        getFinancesByDay(DateTime.now()); //! Now
        emit(AddFinanceSuccessState());
      },
    );
  }



  // bool isSameDate(DateTime d1, DateTime d2) {
  //   return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  // }

  void getFinancesByDay(DateTime dateTime) {
    emit(GetFinancesByDayLoadingState());
    var res = homeRepo.getFinancesByDay(dateTime);
    res.fold(
      (l) => emit(
        GetFinancesByDayFailureState(failureMessage: l.technicalMessage),
      ),
      (r) {
        // if (isSameDate(dateTime, DateTime.now())) {
        //   emit(GetTodayFinanceSuccessState(financeItems: r));
        // } else {
        //   emit(GetFinancesByDaySuccessState(financeItems: r));
        // }
        emit(GetFinancesByDaySuccessState(financeItems: r));
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

  Future<void> setAllFinancesWithCategoryIdNull(String categoryId) async {
    emit(SetAllFinancesWithCategoryIdNulloadingState());
    var res = await homeRepo.setAllFinancesWithCategoryIdNull(categoryId);
    res.fold(
      (l) => emit(
        SetAllFinancesWithCategoryIdNullFailureState(failureMessage: l.technicalMessage),
      ),
      (r) {
        emit(SetAllFinancesWithCategoryIdNullSuccessState());
      },
    );
  }
}



