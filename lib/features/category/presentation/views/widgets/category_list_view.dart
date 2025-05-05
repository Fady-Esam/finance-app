import 'package:finance_flutter_app/features/category/data/models/category_model.dart';
import 'package:finance_flutter_app/features/category/presentation/views/manage_category_view.dart';
import 'package:finance_flutter_app/features/home/presentation/manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
import 'package:finance_flutter_app/features/home/presentation/manager/cubits/manage_finance_cubit/manage_finance_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import 'category_item.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key, required this.categories});

  final List<CategoryModel> categories;
  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.categories.length,
      itemBuilder: (context, index) {
        final categoryItemModel = widget.categories[index];
        return Dismissible(
          key: ValueKey(categoryItemModel.key),
          confirmDismiss: (DismissDirection direction) async {
            if (direction == DismissDirection.startToEnd) {
              // Swipe from left to right --> EDIT
              Navigator.pushNamed(
                context,
                ManageCategoryView.routeName,
                arguments: {'categoryModel': categoryItemModel, 'categories' : widget.categories},
              );
              return false; // <<< DON'T dismiss the item
            } else if (direction == DismissDirection.endToStart) {
              // Swipe from right to left --> DELETE
              await BlocProvider.of<ManageFinanceCubit>(
                context,
              ).setAllFinancesWithCategoryIdNull(
                categoryItemModel.key,
              );
              await categoryItemModel.delete();
              // BlocProvider.of<ManageCategoryCubit>(context)
              //     .getAllCategories();
              return true; // <<< Allow dismiss
            }
            return false;
          },
          background: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: const Color.fromARGB(255, 131, 187, 234),
            alignment:
                Directionality.of(context) == TextDirection.ltr
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
            child: const Icon(Icons.edit),
          ),
          secondaryBackground: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: const Color.fromARGB(255, 229, 120, 113),
            alignment:
                Directionality.of(context) == TextDirection.ltr
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
            child: const Icon(Icons.delete),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: BlocListener<ManageFinanceCubit, ManageFinanceState>(
              listener: (context, state) async {
                if (state is SetAllFinancesWithCategoryIdNullFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context).somethingWentWrong)),
                  );
                } /* else if (state
                    is SetAllFinancesWithCategoryIdNullSuccessState) {} */
              },
              child: CategoryItem(categoryItem: categoryItemModel),
            ),
          ),
        );
      },
    );
  }
}
