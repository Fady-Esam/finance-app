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
      (r) async{
        emit(AddFinanceSuccessState());
        await getAllFinances();
      },
    );
  }

  Future<void> deleteFinance(FinanceItemModel item) async {
    emit(DeleteFinanceLoadingState());
    var res = await homeRepo.deleteFinance(item);
    res.fold(
      (l) => emit(DeleteFinanceFailureState(failureMessage: l.technicalMessage)),
      (r) async {
        emit(DeleteFinanceSuccessState());
        await getAllFinances();
      },
    );
  }

  Future<void> updateFinance(FinanceItemModel item) async {
    emit(UpdateFinanceLoadingState());
    var res = await homeRepo.updateFinance(item);
    res.fold(
      (l) => emit(UpdateFinanceFailureState(failureMessage: l.technicalMessage)),
      (r) {
        emit(UpdateFinanceSuccessState());
        getAllTotalBalance();
        getTodayTotalBalance();
      },
    );
  }

  Future<void> getAllFinances() async {
    emit(GetAllFinanceLoadingState());
    var res = await homeRepo.getAllFinances();
    res.fold(
      (l) => emit(GetAllFinanceFailureState(failureMessage: l.technicalMessage)),
      (r) {
        emit(GetAllFinanceSuccessState(financeItems: r));
        getAllTotalBalance();
        getTodayTotalBalance();
      },
    );
  }
  void getFinancesByDay(DateTime dateTime) async {
    emit(GetFinancesByDayLoadingState());
    var res =  homeRepo.getFinancesByDay(dateTime);
    res.fold(
      (l) => emit(GetFinancesByDayFailureState(failureMessage: l.technicalMessage)),
      (r) => emit(GetFinancesByDaySuccessState(financeItems: r)),
    );
  }
  void getAllTotalBalance()  {
    emit(GetAllTotalBalanceLoadingState());
    var res =  homeRepo.getAllTotalBalance();
    res.fold(
      (l) => emit(GetAllTotalBalanceFailureState(failureMessage: l.technicalMessage)),
      (r) => emit(GetAllTotalBalanceSuccessState(totalBalance: r)),
    );
  }
  void getTodayTotalBalance()  {
    emit(GetTodayTotalBalanceLoadingState());
    var res =  homeRepo.getTodayTotalBalance();
    res.fold(
      (l) => emit(GetTodayTotalBalanceFailureState(failureMessage: l.technicalMessage)),
      (r) => emit(GetTodayTotalBalanceSuccessState(totalBalance: r)),
    );
  }
}
