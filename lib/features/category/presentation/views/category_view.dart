import 'dart:developer';

import 'package:finance_flutter_app/features/category/data/models/category_model.dart';
import 'package:finance_flutter_app/features/category/presentation/manager/cubits/manage_category_cubit/manage_category_cubit.dart';
import 'package:finance_flutter_app/features/category/presentation/manager/cubits/manage_category_cubit/manage_category_state.dart';
import 'package:finance_flutter_app/features/category/presentation/views/manage_category_view.dart';
import 'package:finance_flutter_app/features/category/presentation/views/widgets/category_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<CategoryModel> categories = [];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ManageCategoryCubit>(context).getAllCategories();
    });
  }

  Future<void> _onRefresh() async {
    BlocProvider.of<ManageCategoryCubit>(context).getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).categories)),
        body: BlocConsumer<ManageCategoryCubit, ManageCategoryState>(
          listener: (context, state) {
            if (state is GetAllCategoryFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(S.of(context).somethingWentWrong)),
              );
              log(state.failureMessage.toString());
            } else if (state is GetAllCategorySuccessState) {
              categories = state.categoryItems;
            }
          },
          builder: (context, state) {
            return CategoryListView(categories: categories);
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              ManageCategoryView.routeName,
              arguments: {'categoryModel': null},
            );
          },
          child: const Icon(Icons.add, color: Color(0xFF262626)),
        ),
      ),
    );
  }
}
