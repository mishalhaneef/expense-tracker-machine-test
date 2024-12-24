import 'package:hive_flutter/hive_flutter.dart';
part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? description;

  CategoryModel({
    this.name,
    this.description,
  });

  CategoryModel copyWith({
    String? name,
    String? description,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}

final List<CategoryModel> listOfCategories = [
  CategoryModel(name: "Food", description: "Food expenses"),
  CategoryModel(name: "Shopping", description: "ALl shopping lists"),
  CategoryModel(
      name: "Other", description: "Other expenses such as tea and other stuff"),
];
