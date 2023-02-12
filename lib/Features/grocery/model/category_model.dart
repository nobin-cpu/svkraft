// To parse this JSON data, do
//
//     final groceryCategory = groceryCategoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GroceryCategory groceryCategoryFromJson(String str) =>
    GroceryCategory.fromJson(json.decode(str));

String groceryCategoryToJson(GroceryCategory data) =>
    json.encode(data.toJson());

class GroceryCategory {
  GroceryCategory({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<GroceryCategoryData> data;

  factory GroceryCategory.fromJson(Map<String, dynamic> json) =>
      GroceryCategory(
        success: json["success"],
        message: json["message"],
        data: List<GroceryCategoryData>.from(
            json["data"].map((x) => GroceryCategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GroceryCategoryData {
  GroceryCategoryData({
    required this.id,
    required this.image,
    required this.name,
  });

  int id;
  dynamic image;
  String name;

  factory GroceryCategoryData.fromJson(Map<String, dynamic> json) =>
      GroceryCategoryData(
        id: json["id"],
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
      };
}
