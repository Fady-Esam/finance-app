import 'package:dartz/dartz.dart';
import 'package:finance_flutter_app/features/home/data/models/category_model.dart';
import 'package:finance_flutter_app/features/home/data/models/finance_item_model.dart';

import '../../../../core/errors/failure.dart';

abstract class HomeRepo {
  //! Start Finances
  Future<Either<Failure, void>> addFinance(FinanceItemModel item);
  Future<Either<Failure, void>> deleteFinance(FinanceItemModel item);
  Future<Either<Failure, void>> updateFinance(
  FinanceItemModel item,
  );
  Either<Failure, List<FinanceItemModel>> getAllFinances();
  Either<Failure, List<FinanceItemModel>> getFinancesByDay(DateTime dateTime);
  Either<Failure, double> getTodayTotalBalance();
  Either<Failure, double> getAllTotalBalance();
  //! End Finances
  Future<Either<Failure, void>> addCategory(CategoryModel item);
  Future<Either<Failure, void>> deleteCategory(CategoryModel item);
  Future<Either<Failure, void>> updateCategory(CategoryModel item);
  Either<Failure, List<CategoryModel>> getAllCategories();
}


