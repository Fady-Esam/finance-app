


import '../../../../data/models/category_model.dart';

class ManageCategoryState {}

class ManageCategoryInitialState extends ManageCategoryState {}

//! Add
class AddCategoryLoadingState extends ManageCategoryState {}

class AddCategoryFailureState extends ManageCategoryState {
  final String? failureMessage;

  AddCategoryFailureState({required this.failureMessage});
}

class AddCategorySuccessState extends ManageCategoryState {}


//! Get All

class GetAllCategoryLoadingState extends ManageCategoryState {}

class GetAllCategoryFailureState extends ManageCategoryState {
  final String? failureMessage;

  GetAllCategoryFailureState({required this.failureMessage});
}

class GetAllCategorySuccessState extends ManageCategoryState {
  final List<CategoryModel> categoryItems;

  GetAllCategorySuccessState({required this.categoryItems});
}


