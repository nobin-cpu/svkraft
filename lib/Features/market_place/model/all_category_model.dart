import 'dart:convert';

AllCategoryModel allCategoryModelFromJson(String str) => AllCategoryModel.fromJson(json.decode(str));

String allCategoryModelToJson(AllCategoryModel data) => json.encode(data.toJson());

class AllCategoryModel {
  AllCategoryModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<Category>? data;

  factory AllCategoryModel.fromJson(Map<String, dynamic> json) => AllCategoryModel(
    success: json["success"],
    message: json["message"],
    data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.category,
    this.icon,
    this.subcategory,
  });

  int? id;
  String? category;
  String? icon;
  List<Subcategory>? subcategory;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    category: json["category"],
    icon: json["icon"],
    subcategory: List<Subcategory>.from(json["subcategory"].map((x) => Subcategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "icon": icon,
    "subcategory": List<dynamic>.from(subcategory!.map((x) => x.toJson())),
  };
}

class Subcategory {
  Subcategory({
    this.name,
    this.childCategory,
  });

  String? name;
  List<ChildCategory>? childCategory;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    name: json["name"],
    childCategory: List<ChildCategory>.from(json["child_category"].map((x) => ChildCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "child_category": List<dynamic>.from(childCategory!.map((x) => x.toJson())),
  };
}

class ChildCategory {
  ChildCategory({
    this.name,
  });

  String? name;

  factory ChildCategory.fromJson(Map<String, dynamic> json) => ChildCategory(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
