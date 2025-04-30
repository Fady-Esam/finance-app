import 'package:finance_flutter_app/features/home/data/models/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repos/home_repo.dart';
import 'manage_category_state.dart';

class ManageFinanceCubit extends Cubit<ManageCategoryState> {
  ManageFinanceCubit({required this.homeRepo})
    : super(ManageCategoryInitialState());
  final HomeRepo homeRepo;

  Future<void> addCategory(CategoryModel item) async {
    emit(AddCategoryLoadingState());
    var res = await homeRepo.addCategory(item);
    res.fold(
      (l) => emit(AddCategoryFailureState(failureMessage: l.technicalMessage)),
      (r) {
        getAllCategories();
        emit(AddCategorySuccessState());
      },
    );
  }

  Future<void> deleteFinance(CategoryModel item) async {
    emit(DeleteCategoryLoadingState());
    var res = await homeRepo.deleteCategory(item);
    res.fold(
      (l) =>
          emit(DeleteCategoryFailureState(failureMessage: l.technicalMessage)),
      (r) {
        getAllCategories();
        emit(DeleteCategorySuccessState());
      },
    );
  }

  Future<void> updateFinance(CategoryModel item) async {
    emit(UpdateCategoryLoadingState());
    var res = await homeRepo.updateCategory(item);
    res.fold(
      (l) =>
          emit(UpdateCategoryFailureState(failureMessage: l.technicalMessage)),
      (r) {
        getAllCategories();
        emit(UpdateCategorySuccessState());
      },
    );
  }

  void getAllCategories() {
    emit(GetAllCategoryLoadingState());
    var res = homeRepo.getAllCategories();
    res.fold(
      (l) =>
          emit(GetAllCategoryFailureState(failureMessage: l.technicalMessage)),
      (r) {
        emit(GetAllCategorySuccessState(categoryItems: r));
      },
    );
  }
}
