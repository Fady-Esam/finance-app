import 'package:hive/hive.dart';


part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel extends HiveObject {
  @HiveField(1)
  String name;

  @HiveField(2)
  String icon;

  @HiveField(3)
  String colorHex;


  CategoryModel({
    required this.name,
    this.icon = 'category',
    this.colorHex = "ff9e9e9e",
  });

}
