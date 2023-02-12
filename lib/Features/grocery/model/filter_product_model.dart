// To parse this JSON data, do
//
//     final filterProduct = filterProductFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FilterProduct filterProductFromJson(String str) =>
    FilterProduct.fromJson(json.decode(str));

String filterProductToJson(FilterProduct data) => json.encode(data.toJson());

class FilterProduct {
  FilterProduct({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<FilterProductData> data;

  factory FilterProduct.fromJson(Map<String, dynamic> json) => FilterProduct(
        success: json["success"],
        message: json["message"],
        data: List<FilterProductData>.from(
            json["data"].map((x) => FilterProductData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FilterProductData {
  FilterProductData({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.offPrice,
    required this.marketPrice,
  });

  int id;
  String image;
  String name;
  String description;
  double price;
  int offPrice;
  String marketPrice;

  factory FilterProductData.fromJson(Map<String, dynamic> json) =>
      FilterProductData(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        price: json["price"].toDouble(),
        offPrice: json["off_price"],
        marketPrice: json["market_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "description": description,
        "price": price,
        "off_price": offPrice,
        "market_price": marketPrice,
      };

  @override
  String toString() {
    return 'FilterProductData{id: $id, image: $image, name: $name, description: $description, price: $price, offPrice: $offPrice, marketPrice: $marketPrice}';
  }
}
