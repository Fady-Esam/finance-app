import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/category_model.dart';

abstract class CategoryRepo {
  Future<Either<Failure, void>> addCategory(CategoryModel item);
  Future<Either<Failure, void>> deleteCategory(CategoryModel item);
  Future<Either<Failure, void>> updateCategory(CategoryModel item);
  Either<Failure, List<CategoryModel>> getAllCategories();
}
