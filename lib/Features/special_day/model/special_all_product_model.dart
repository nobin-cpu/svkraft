// To parse this JSON data, do
//
//     final specialAllProduct = specialAllProductFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SpecialAllProduct specialAllProductFromJson(String str) =>
    SpecialAllProduct.fromJson(json.decode(str));

String specialAllProductToJson(SpecialAllProduct data) =>
    json.encode(data.toJson());

class SpecialAllProduct {
  SpecialAllProduct({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<SpecialAllProductData> data;

  factory SpecialAllProduct.fromJson(Map<String, dynamic> json) =>
      SpecialAllProduct(
        success: json["success"],
        message: json["message"],
        data: List<SpecialAllProductData>.from(
            json["data"].map((x) => SpecialAllProductData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'SpecialAllProduct{success: $success, message: $message, data: $data}';
  }
}

class SpecialAllProductData {
  SpecialAllProductData(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.price,
      required this.ar_price,
      required this.category,
      required this.bookmark});

  int id;
  String name;
  String description;
  String image;
  int price;
  String ar_price;

  Category category;
  bool bookmark;

  factory SpecialAllProductData.fromJson(Map<String, dynamic> json) =>
      SpecialAllProductData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        ar_price: json["ar_price"],
        bookmark: json["bookmark"],
        category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "ar_price": ar_price,
        "bookmark": bookmark,
        "category": category.toJson(),
      };

  @override
  String toString() {
    return 'SpecialAllProductData{id: $id, name: $name, description: $description, image: $image, price: $price,bookmark:$bookmark ,category: $category}';
  }
}

class Category {
  Category({
    required this.name,
    required this.id,
  });

  String name;
  int id;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        'id': id,
      };

  @override
  String toString() {
    return 'Category{name: $name}';
  }
}
