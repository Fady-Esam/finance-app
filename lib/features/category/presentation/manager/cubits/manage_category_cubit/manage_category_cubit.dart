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

  CategoryModel? getCategoryById(int? categoryId) {
    return homeRepo.getCategoryById(categoryId);

  }

  Map<int, CategoryModel> getCategoriesByIds(Set<int?> categoryIds) {
    return homeRepo.getCategoriesByIds(categoryIds);
  }
}
