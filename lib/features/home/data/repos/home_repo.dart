import 'package:dartz/dartz.dart';
import 'package:finance_flutter_app/features/home/data/models/finance_item_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/failure.dart';
import '../models/balance_summary.dart';

abstract class HomeRepo {
  Future<Either<Failure, void>> addFinance(FinanceItemModel item);
  //Either<Failure, List<FinanceItemModel>> getAllFinances();
  Either<Failure, List<FinanceItemModel>> getFilteredFinances(
    DateTimeRange dateRange, {
    int? categoryId,
    bool? isAmountPositive,
  });
  Either<Failure, List<FinanceItemModel>> getFinancesByDate(DateTime dateTime);
  Either<Failure, List<FinanceItemModel>> getChartsFinances();

  Either<Failure, double> getTodayTotalBalance();
  Either<Failure, double> getAllTotalBalance();
  Either<Failure, BalanceSummary> getTotalBalance(
    DateTimeRange dateRange, {
    int? categoryId,
    bool? isAmountPositive,
    List<FinanceItemModel>? items,
  });
  Future<Either<Failure, void>> setAllFinancesWithCategoryIdNull(
    int categoryId,
  );
}
