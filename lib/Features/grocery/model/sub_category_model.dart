// To parse this JSON data, do
//
//     final grocerySubCategory = grocerySubCategoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GrocerySubCategory grocerySubCategoryFromJson(String str) =>
    GrocerySubCategory.fromJson(json.decode(str));

String grocerySubCategoryToJson(GrocerySubCategory data) =>
    json.encode(data.toJson());

class GrocerySubCategory {
  GrocerySubCategory({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<GrocerySubCategoryData> data;

  factory GrocerySubCategory.fromJson(Map<String, dynamic> json) =>
      GrocerySubCategory(
        success: json["success"],
        message: json["message"],
        data: List<GrocerySubCategoryData>.from(
            json["data"].map((x) => GrocerySubCategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GrocerySubCategoryData {
  GrocerySubCategoryData({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory GrocerySubCategoryData.fromJson(Map<String, dynamic> json) =>
      GrocerySubCategoryData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
