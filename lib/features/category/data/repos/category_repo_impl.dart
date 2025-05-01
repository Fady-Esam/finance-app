import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:finance_flutter_app/features/category/data/repos/category_repo.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/errors/failure.dart';
import '../models/category_model.dart';

class CategoryRepoImpl implements CategoryRepo {
  @override
  Future<Either<Failure, void>> addCategory(CategoryModel item) async {
    try {
      var box = Hive.box<CategoryModel>('category');
      await box.add(item);
      return right(null);
    } catch (e) {
      return left(Failure(technicalMessage: e.toString()));
    }
  }


  @override
  Either<Failure, List<CategoryModel>> getAllCategories() {
    try {
      var box = Hive.box<CategoryModel>('category');
      List<CategoryModel> categories = box.values.toList();
      for(var c in categories){
        log(c.name);
      }
      return right(box.values.toList());
    } catch (e) {
      return left(Failure(technicalMessage: e.toString()));
    }
  }


}
