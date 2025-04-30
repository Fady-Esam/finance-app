import 'package:dartz/dartz.dart';
import 'package:finance_flutter_app/core/errors/failure.dart';
import 'package:finance_flutter_app/features/home/data/models/finance_item_model.dart';
import 'package:finance_flutter_app/features/home/data/repos/home_repo.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HomeRepoImpl implements HomeRepo {
  @override
  Future<Either<Failure, void>> addFinance(FinanceItemModel item) async {
    try {
      var box = Hive.box<FinanceItemModel>('finance');
      await box.add(item);
      return right(null);
    } catch (e) {
      return left(Failure(technicalMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFinance(FinanceItemModel item) async {
    try {
      await item.delete();
      return right(null);
    } catch (e) {
      return left(Failure(technicalMessage: e.toString()));
    }
  }

  @override
  Either<Failure, List<FinanceItemModel>> getAllFinances() {
    try {
      var box = Hive.box<FinanceItemModel>('finance');
      return right(box.values.toList());
    } catch (e) {
      return left(Failure(technicalMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateFinance(FinanceItemModel item) async {
    try {
      await item.save();
      return right(null);
    } catch (e) {
      return left(Failure(technicalMessage: e.toString()));
    }
  }

  @override
  Either<Failure, double> getAllTotalBalance() {
    try {
      var box = Hive.box<FinanceItemModel>('finance');
      double totalBalance = 0.0;
      for (var item in box.values) {
        totalBalance += item.amount;
      }
      return right(totalBalance);
    } catch (e) {
      return left(Failure(technicalMessage: e.toString()));
    }
  }

  @override
  Either<Failure, List<FinanceItemModel>> getFinancesByDay(DateTime dateTime) {
    try {
      var box = Hive.box<FinanceItemModel>('finance');
      return right(
        box.values.where((item) {
          return item.dateTime.year == dateTime.year &&
              item.dateTime.month == dateTime.month &&
              item.dateTime.day == dateTime.day;
        }).toList(),
      );
    } catch (e) {
      return left(Failure(technicalMessage: e.toString()));
    }
  }

  @override
  Either<Failure, double> getTodayTotalBalance() {
    try {
      var box = Hive.box<FinanceItemModel>('finance');
      double totalBalance = 0.0;
      DateTime today = DateTime.now();
      for (var item in box.values) {
        if (item.dateTime.year == today.year &&
            item.dateTime.month == today.month &&
            item.dateTime.day == today.day) {
          totalBalance += item.amount;
        }
      }
      return right(totalBalance);
    } catch (e) {
      return left(Failure(technicalMessage: e.toString()));
    }
  }


}
