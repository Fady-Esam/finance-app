import 'package:flutter/material.dart';
import '../../../../../core/widgets/drop_down_button_form_field_category_items.dart';
import '../../../../../generated/l10n.dart';
import '../../../../category/data/models/category_model.dart';

class CategoryFilter extends StatelessWidget {
  final CategoryModel? selectedCategory;
  final List<CategoryModel> categories;
  final ValueChanged<CategoryModel?> onCategoryChanged;

  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.categories,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormFieldCategoryItems(
      selectedCategory: selectedCategory,
      categories: categories,
      onCategoryChanged: onCategoryChanged,
      noTitle: S.of(context).no_category_filter,
    );
  }
}

