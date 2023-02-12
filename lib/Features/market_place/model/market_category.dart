// To parse this JSON data, do
//
//     final marketCategory = marketCategoryFromJson(jsonString);

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

MarketCategory marketCategoryFromJson(String str) =>
    MarketCategory.fromJson(json.decode(str));

String marketCategoryToJson(MarketCategory data) => json.encode(data.toJson());

class MarketCategory {
  MarketCategory({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<mCategory> data;

  factory MarketCategory.fromJson(Map<String, dynamic> json) => MarketCategory(
        success: json["success"],
        message: json["message"],
        data: List<mCategory>.from(
            json["data"].map((x) => mCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'MarketCategory{success: $success, message: $message, data: $data}';
  }
}

class mCategory {
  mCategory({
    this.id,
    required this.categoryName,
    this.image,
    this.icon,
  });
  int? id;
  String categoryName;
  String? image;
  IconData? icon;

  factory mCategory.fromJson(Map<String, dynamic> json) => mCategory(
        id: json["id"],
        categoryName: json["category_name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "image": image,
      };

  @override
  String toString() {
    return 'mCategory{id:$id categoryName: $categoryName, image: $image}';
  }
}

// // To parse this JSON data, do
// //
// //     final marketCategory = marketCategoryFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// MarketCategory marketCategoryFromJson(String str) =>
//     MarketCategory.fromJson(json.decode(str));

// String marketCategoryToJson(MarketCategory data) => json.encode(data.toJson());

// class MarketCategory {
//   MarketCategory({
//    required this.success,
//    required this.message,
//    required this.data,
//   });

//   bool success;
//   String message;
//   List<mCategory> data;

//   factory MarketCategory.fromJson(Map<String, dynamic> json) => MarketCategory(
//         success: json["success"],
//         message: json["message"],
//         data: List<mCategory>.from(
//             json["data"].map((x) => mCategory.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };

//   @override
//   String toString() {
//     return 'MarketCategory{success: $success, message: $message, data: $data}';
//   }
// }

// class mCategory {
//   mCategory({
//    required this.categoryName,
//   });

//   String categoryName;

//   factory mCategory.fromJson(Map<String, dynamic> json) => mCategory(
//         categoryName: json["category_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "category_name": categoryName,
//       };
// }
