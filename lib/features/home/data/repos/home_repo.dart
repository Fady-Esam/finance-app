import 'package:dartz/dartz.dart';
import 'package:finance_flutter_app/features/home/data/models/finance_item_model.dart';

import '../../../../core/errors/failure.dart';

abstract class HomeRepo {
  Future<Either<Failure, void>> addFinance(FinanceItemModel item);
  Future<Either<Failure, void>> deleteFinance(FinanceItemModel item);
  Future<Either<Failure, void>> updateFinance(
  FinanceItemModel item,
  );
  Future<Either<Failure, List<FinanceItemModel>>> getAllFinances();
  Either<Failure, List<FinanceItemModel>> getFinancesByDay(DateTime dateTime);
  Either<Failure, double> getTodayTotalBalance();
  Either<Failure, double> getAllTotalBalance();
}


