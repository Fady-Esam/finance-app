import 'package:finance_flutter_app/features/category/data/models/category_model.dart';
import 'package:finance_flutter_app/features/category/presentation/manager/cubits/manage_category_cubit/manage_category_cubit.dart';
import 'package:finance_flutter_app/features/category/presentation/views/manage_category_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/color_utils.dart';
import '../../../../../core/utils/icon_utils.dart';

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
                arguments: {'categoryModel': categoryItemModel},
              );
              return false; // <<< DON'T dismiss the item
            } else if (direction == DismissDirection.endToStart) {
              // Swipe from right to left --> DELETE
              await BlocProvider.of<ManageCategoryCubit>(
                context,
              ).deleteCategory(categoryItemModel);
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
            child: CategoryItem(categoryItem: categoryItemModel),
          ),
        );
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.categoryItem});
  final CategoryModel categoryItem;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor:
            categoryItem.colorHex == null
                ? Colors.transparent
                : getColorfromHex(categoryItem.colorHex!),
        child:
            categoryItem.icon == null
                ? const SizedBox()
                : Icon(
                  getIconFromName(categoryItem.icon!),
                  color: Colors.black,
                ),
      ),
      title: Text(categoryItem.name, style: TextStyle(fontSize: 16)),
    );
  }
}
