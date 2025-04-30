import 'package:finance_flutter_app/features/category/data/repos/category_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/category_model.dart';
import 'manage_category_state.dart';

class ManageCategoryCubit extends Cubit<ManageCategoryState> {
  ManageCategoryCubit({required this.homeRepo})
    : super(ManageCategoryInitialState());
  final CategoryRepo homeRepo;

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
