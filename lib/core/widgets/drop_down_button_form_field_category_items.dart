import 'package:flutter/material.dart';

import '../../features/category/data/models/category_model.dart';
import '../../generated/l10n.dart';
import '../utils/color_utils.dart';
import '../utils/icon_utils.dart';

class DropdownButtonFormFieldCategoryItems extends StatelessWidget {
  const DropdownButtonFormFieldCategoryItems({
    super.key,
    this.selectedCategory,
    required this.categories,
    required this.onCategoryChanged,
    required this.noTitle,
  });
  final CategoryModel? selectedCategory;
  final List<CategoryModel> categories;
  final ValueChanged<CategoryModel?> onCategoryChanged;
  final String noTitle;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CategoryModel>(
      isExpanded: true,
      value: selectedCategory,
      hint: Text(S.of(context).select_category),
      onChanged: onCategoryChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      icon: Icon(Icons.arrow_drop_down),
      items: [
        DropdownMenuItem<CategoryModel>(
          value: null,
          child: Text(noTitle),
        ),
        ...categories.map((category) {
          return DropdownMenuItem<CategoryModel>(
            value: category,
            child: Row(
              children: [
                Icon(
                  getIconFromName(category.icon),
                  color: getColorfromHex(category.colorHex),
                ),
                const SizedBox(width: 8),
                Text(category.name),
              ],
            ),
          );
        }),
      ],
    );
  }
}
