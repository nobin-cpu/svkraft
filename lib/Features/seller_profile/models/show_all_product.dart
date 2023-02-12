// To parse this JSON data, do
//
//     final showAllProduct = showAllProductFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ShowAllProduct showAllProductFromJson(String str) =>
    ShowAllProduct.fromJson(json.decode(str));

String showAllProductToJson(ShowAllProduct data) => json.encode(data.toJson());

class ShowAllProduct {
  ShowAllProduct({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<ShowAllProductData> data;

  factory ShowAllProduct.fromJson(Map<String, dynamic> json) => ShowAllProduct(
        success: json["success"],
        message: json["message"],
        data: List<ShowAllProductData>.from(
            json["data"].map((x) => ShowAllProductData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'ShowAllProduct{success: $success, message: $message, data: $data}';
  }
}

class ShowAllProductData {
  ShowAllProductData({
    required this.id,
    required this.location,
    required this.productName,
    required this.price,
    required this.image,
    required this.category,
  });

  int id;
  String location;
  String productName;
  int price;
  List<SellerImage> image;
  Category category;

  factory ShowAllProductData.fromJson(Map<String, dynamic> json) =>
      ShowAllProductData(
        id: json["id"],
        location: json["location"],
        productName: json["product_name"],
        price: json["price"],
        image: List<SellerImage>.from(
            json["image"].map((x) => SellerImage.fromJson(x))),
        category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location": location,
        "product_name": productName,
        "price": price,
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "category": category.toJson(),
      };

  @override
  String toString() {
    return 'ShowAllProductData{id: $id, location: $location, productName: $productName, price: $price, image: $image, category: $category}';
  }
}

class Category {
  Category({
    required this.id,
    required this.categoryName,
    required this.image,
  });

  int id;
  String categoryName;
  String image;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
    return 'Category{id: $id, categoryName: $categoryName, image: $image}';
  }
}

class SellerImage {
  SellerImage({
    required this.filePath,
  });

  String filePath;

  factory SellerImage.fromJson(Map<String, dynamic> json) => SellerImage(
        filePath: json["file_path"],
      );

  Map<String, dynamic> toJson() => {
        "file_path": filePath,
      };
}
