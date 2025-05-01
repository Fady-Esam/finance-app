import 'package:flutter/material.dart';

import '../../../../../core/utils/color_utils.dart';
import '../../../../../core/utils/icon_utils.dart';
import '../../../data/models/category_model.dart';

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
