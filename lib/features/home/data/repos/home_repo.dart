import 'package:dartz/dartz.dart';
import 'package:finance_flutter_app/features/home/data/models/finance_item_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/failure.dart';

abstract class HomeRepo {
  Future<Either<Failure, void>> addFinance(FinanceItemModel item);
  Future<Either<Failure, void>> deleteFinance(FinanceItemModel item);
  Future<Either<Failure, void>> updateFinance(FinanceItemModel item);
  Either<Failure, List<FinanceItemModel>> getAllFinances();
  Either<Failure, List<FinanceItemModel>> getFilteredFinances(
    DateTimeRange dateRange, {
    int? categoryId,
    bool? isAmountPositive,
  });
  Either<Failure, List<FinanceItemModel>> getFinancesByDate(DateTime dateTime);
  Either<Failure, List<FinanceItemModel>> getChartsFinances(

  );

  Either<Failure, double> getTodayTotalBalance();
  Either<Failure, double> getAllTotalBalance();
  Future<Either<Failure, void>> setAllFinancesWithCategoryIdNull(
    int categoryId,
  );
}
