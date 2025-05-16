import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:finance_flutter_app/core/errors/failure.dart';
import 'package:finance_flutter_app/features/home/data/models/finance_item_model.dart';
import 'package:finance_flutter_app/features/home/data/repos/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/funcs/calculate_next_occurence.dart';
import '../../../../core/funcs/get_next_monthly_date.dart';
import '../enums/recurrence_type_enum.dart';
import '../models/balance_summary.dart';

class HomeRepoImpl implements HomeRepo {
  @override
  Future<Either<Failure, void>> addFinance(FinanceItemModel item) async {
    try {
      final box = Hive.box<FinanceItemModel>('finance');
      box.add(item);
      log("Counter: ${item.recurrenceCount}");
      return right(null);

      // int count = 1;
      // DateTime currentDate = item.dateTime;
      // DateTime nextDate = calculateNextOccurrence(currentDate, item.recurrence);
      // final DateTime finalEndDate =
      //     item.recurrenceEndDate ?? getNextMonthlyDate(nextDate);
      // while (nextDate.isBefore(finalEndDate) ||
      //     nextDate.isAtSameMomentAs(finalEndDate)) {
      //   count++;
      //   nextDate = calculateNextOccurrence(nextDate, item.recurrence);
      // }
      // return right(null);
      // DateTime nextDate = item.dateTime;
      // final DateTime finalEndDate =
      //     item.recurrenceEndDate ?? getNextMonthlyDate(nextDate);
      // while (nextDate.isBefore(finalEndDate) ||
      //     nextDate.isAtSameMomentAs(finalEndDate)) {
      //   final newItem = FinanceItemModel(
      //     amount: item.amount,
      //     dateTime: nextDate,
      //     title: item.title,
      //     categoryId: item.categoryId,
      //     recurrence: item.recurrence,
      //     recurrenceEndDate: item.recurrenceEndDate,
      //   );
      //   box.add(newItem);
      //   nextDate = calculateNextOccurrence(nextDate, item.recurrence);
      // }
      // return right(null);
    } catch (e) {
      return left(Failure(technicalMessage: e.toString()));
    }
  }

  // @override
  // Either<Failure, List<FinanceItemModel>> getAllFinances() {
  //   try {
  //     var box = Hive.box<FinanceItemModel>('finance');
  //     return right(box.values.toList());
  //   } catch (e) {
  //     return left(Failure(technicalMessage: e.toString()));
  //   }
  // }

  @override
  Either<Failure, List<FinanceItemModel>> getFinancesByDate(DateTime dateTime) {
    try {
      // var box = Hive.box<FinanceItemModel>('finance');
      // final filteredItems =
      //     box.values.where((item) {
      //       return item.dateTime.year == dateTime.year &&
      //           item.dateTime.month == dateTime.month &&
      //           item.dateTime.day == dateTime.day;
      //     }).toList();
      return right(getFilteredFinancesByDate(singleDate: dateTime));
    } catch (e) {
      return left(Failure(technicalMessage: e.toString()));
    }
  }

  List<FinanceItemModel> getFilteredFinancesByDate({
    DateTimeRange? dateRange,
    DateTime? singleDate,
  }) {
    // Validate inputs
    final box = Hive.box<FinanceItemModel>('finance');
    if (dateRange == null && singleDate == null) {
      return box.values.toList();
    }
    if (dateRange != null && singleDate != null) {
      return [];
      //throw ArgumentError('Provide only one of dateRange or singleDate');
    }

    // Normalize start and end dates
    late DateTime start;
    late DateTime end;
    bool isSingleDayForDateTimeRange = false;

    if (singleDate != null) {
      // Single day: set start and end to cover the entire day
      start = DateTime(singleDate.year, singleDate.month, singleDate.day);
      end = DateTime(
        singleDate.year,
        singleDate.month,
        singleDate.day,
        23,
        59,
        59,
        999,
      );
    } else {
      // Date range: normalize start and end
      start = DateTime(
        dateRange!.start.year,
        dateRange.start.month,
        dateRange.start.day,
      );
      end = DateTime(
        dateRange.end.year,
        dateRange.end.month,
        dateRange.end.day,
        23,
        59,
        59,
        999,
      );
      isSingleDayForDateTimeRange =
          start.year == end.year &&
          start.month == end.month &&
          start.day == end.day;
    }

    // Filter items
    // final filteredItems =
    //     box.values.where((item) {
    //       final date = item.dateTime;

    //       // Check if date falls within the range (inclusive)
    //       final matchesDate =
    //           isSingleDayForDateTimeRange
    //               ? date.year == start.year &&
    //                   date.month == start.month &&
    //                   date.day == start.day
    //               : !date.isBefore(start) && !date.isAfter(end);
    //       return matchesDate;
    //     }).toList();
    final filteredItems = <FinanceItemModel>[];
    for (final item in box.values) {
      if (item.recurrence != RecurrenceType.none) {
        final count = _calculateRecurrenceCount(
          item.dateTime,
          item.recurrence,
          item.recurrenceEndDate,
          start,
          end,
        );
        item.recurrenceCount = count;
      }
      //if (item.recurrence == RecurrenceType.none) {
      final date = item.dateTime;
      final matchesDate =
          isSingleDayForDateTimeRange
              ? date.year == start.year &&
                  date.month == start.month &&
                  date.day == start.day
              : !date.isBefore(start) && !date.isAfter(end);
      if (matchesDate) {
        filteredItems.add(item);
      }
      // }
      // else {
      //   final count = _calculateRecurrenceCount(
      //     item.dateTime,
      //     item.recurrence,
      //     item.recurrenceEndDate,
      //     start,
      //     end,
      //   );
      //   if (count > 0) {
      //     item.recurrenceCount = count;
      //     filteredItems.add(item);
        //  // log('count: $count');
      //   }
      // }
    }
    return filteredItems;
  }

  int _calculateRecurrenceCount(
    DateTime startDate,
    RecurrenceType recurrence,
    DateTime? recurrenceEndDate,
    DateTime rangeStart,
    DateTime rangeEnd,
  ) {
    final finalEndDate = recurrenceEndDate ?? getNextMonthlyDate(startDate);
    int count = 0;
    DateTime current = startDate;
    while (!current.isAfter(finalEndDate)) {
      if (!current.isBefore(rangeStart) && !current.isAfter(rangeEnd)) {
        count++;
      }
      current = calculateNextOccurrence(current, recurrence);

      // Optimization: stop if next recurrence is after both rangeEnd and recurrenceEndDate
      if (current.isAfter(rangeEnd) || current.isAfter(finalEndDate)) {
        break;
      }
    }

    return count;

    // int count = 0;
    // DateTime current = startDate;
    // while (current.isBefore(effectiveEnd) ||
    //     current.isAtSameMomentAs(effectiveEnd)) {
    //   if (rangeStart != null && rangeEnd != null) {
    //     final matches =
    //         !current.isBefore(rangeStart) && !current.isAfter(rangeEnd);
    //     if (matches) {
    //       count++;
    //     }
    //   }
    //   current = calculateNextOccurrence(current, recurrence);
    //   if (rangeEnd != null && current.isAfter(rangeEnd)) {
    //     break;
    //   }
    // }
    // return count;
  }

  //! Get FilteredByDateRange
  // List<FinanceItemModel> getFilteredFinancesByDateRange(
  //   DateTimeRange dateRange,
  // ) {
  //   final box = Hive.box<FinanceItemModel>('finance');
  //   final start = DateTime(
  //     dateRange.start.year,
  //     dateRange.start.month,
  //     dateRange.start.day,
  //   );
  //   final end = DateTime(
  //     dateRange.end.year,
  //     dateRange.end.month,
  //     dateRange.end.day,
  //     23,
  //     59,
  //     59,
  //     999,
  //   );
  //   final isSingleDay =
  //       start.year == end.year &&
  //       start.month == end.month &&
  //       start.day == end.day;
  //   final filteredItems =
  //       box.values.where((item) {
  //         final date = item.dateTime;
  //         // Handle date filtering
  //         final matchesDate =
  //             isSingleDay
  //                 ? date.year == start.year &&
  //                     date.month == start.month &&
  //                     date.day == start.day
  //                 : !date.isBefore(start) && !date.isAfter(end);
  //         return matchesDate;
  //       }).toList();
  //   return filteredItems;
  // }
  //!

  List<FinanceItemModel> getFilteredFinancesByDateRangeAndCategory(
    DateTimeRange dateRange, {
    int? categoryId,
  }) {
    final filteredItems =
        getFilteredFinancesByDate(dateRange: dateRange).where((item) {
          final matchesCategory =
              categoryId == null || item.categoryId == categoryId;
          return matchesCategory;
        }).toList();

    return filteredItems;
  }

  List<FinanceItemModel> getFilteredFinancesByDateRangeAndCategoryAndAmountSign(
    DateTimeRange dateRange, {
    int? categoryId,
    bool? isAmountPositive,
  }) {
    final filteredItems =
        getFilteredFinancesByDateRangeAndCategory(
          dateRange,
          categoryId: categoryId,
        ).where((item) {
          final matchesAmountSign =
              isAmountPositive == null
                  ? true
                  : isAmountPositive
                  ? item.amount >= 0
                  : item.amount < 0;
          return matchesAmountSign;
        }).toList();

    return filteredItems;
  }

  @override
  Either<Failure, List<FinanceItemModel>> getFilteredFinances(
    DateTimeRange dateRange, {
    int? categoryId,
    bool? isAmountPositive,
  }) {
    try {
      final filteredItems =
          getFilteredFinancesByDateRangeAndCategoryAndAmountSign(
            dateRange,
            categoryId: categoryId,
            isAmountPositive: isAmountPositive,
          );

      return right(filteredItems);
    } catch (e) {
      return left(Failure(technicalMessage: e.toString()));
    }
  }

  @override
  Either<Failure, double> getAllTotalBalance() {
    try {
      double totalBalance = 0.0;
      getFilteredFinancesByDate(
        dateRange: DateTimeRange(
          start: DateTime(DateTime.now().year - 5, 1, 1),
          end: DateTime.now(),
        ),
      ).forEach((item) {
        totalBalance +=
            item.amount *
            (item.recurrenceCount == 0 ? 1 : item.recurrenceCount);
      });
      // var box = Hive.box<FinanceItemModel>('finance');
      // double totalBalance = 0.0;
      // for (var item in box.values) {
      //   totalBalance += item.amount;
      // }
      return right(totalBalance);
    } catch (e) {
      return left(Failure(technicalMessage: e.toString()));
    }
  }

  @override
  Either<Failure, double> getTodayTotalBalance() {
    try {
      double totalBalance = 0.0;
      getFilteredFinancesByDate(singleDate: DateTime.now()).forEach((item) {
        totalBalance +=
            item.amount *
            (item.recurrenceCount == 0 ? 1 : item.recurrenceCount);
      });
      // var box = Hive.box<FinanceItemModel>('finance');
      // double totalBalance = 0.0;
      // DateTime today = DateTime.now();
      // for (var item in box.values) {
      //   if (item.dateTime.year == today.year &&
      //       item.dateTime.month == today.month &&
      //       item.dateTime.day == today.day) {
      //     totalBalance += item.amount;
      //   }
      // }
      return right(totalBalance);
    } catch (e) {
      return left(Failure(technicalMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setAllFinancesWithCategoryIdNull(
    int categoryId,
  ) async {
    try {
      var box = Hive.box<FinanceItemModel>('finance');
      for (var item in box.values) {
        if (item.categoryId == categoryId) {
          item.categoryId = null;
          await item.save();
        }
      }
      return right(null);
    } catch (e) {
      return left(Failure(technicalMessage: e.toString()));
    }
  }

  @override
  Either<Failure, List<FinanceItemModel>> getChartsFinances() {
    try {
      final DateTimeRange dateRange = DateTimeRange(
        start: DateTime(DateTime.now().year, 1, 1),
        end: DateTime.now(),
      );
      final filteredItems = getFilteredFinancesByDate(dateRange: dateRange);

      filteredItems.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      return right(filteredItems);
    } catch (e) {
      return left(Failure(technicalMessage: e.toString()));
    }
  }

  @override
  Either<Failure, BalanceSummary> getTotalBalance(
    DateTimeRange dateRange, {
    int? categoryId,
    bool? isAmountPositive,
    List<FinanceItemModel>? items,
  }) {
    try {
      var balSum = BalanceSummary();
      List<FinanceItemModel> filteredItems =
          items ??
          getFilteredFinancesByDateRangeAndCategoryAndAmountSign(
            dateRange,
            categoryId: categoryId,
            isAmountPositive: isAmountPositive,
          );
      for (var item in filteredItems) {
        balSum.totalIncome +=
            item.amount > 0
                ? item.amount *
                    (item.recurrenceCount == 0 ? 1 : item.recurrenceCount)
                : 0;
        balSum.totalExpense +=
            item.amount < 0
                ? item.amount.abs() *
                    (item.recurrenceCount == 0 ? 1 : item.recurrenceCount)
                : 0;
      }
      return right(balSum);
    } catch (e) {
      return left(Failure(technicalMessage: e.toString()));
    }
  }
}
