// To parse this JSON data, do
//
//     final specialProductDetails = specialProductDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SpecialProductDetails specialProductDetailsFromJson(String str) =>
    SpecialProductDetails.fromJson(json.decode(str));

String specialProductDetailsToJson(SpecialProductDetails data) =>
    json.encode(data.toJson());

class SpecialProductDetails {
  SpecialProductDetails({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  SpecialProductDetailsData data;

  factory SpecialProductDetails.fromJson(Map<String, dynamic> json) =>
      SpecialProductDetails(
        success: json["success"],
        message: json["message"],
        data: SpecialProductDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class SpecialProductDetailsData {
  SpecialProductDetailsData({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.off_price,
    required this.ar_price,
  });

  int id;
  String name;
  String description;
  String image;
  int price;
  double off_price;
  String ar_price;

  factory SpecialProductDetailsData.fromJson(Map<String, dynamic> json) =>
      SpecialProductDetailsData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        off_price: json["off_price"].toDouble(),
        ar_price: json["ar_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "off_price": off_price,
        "ar_price": ar_price,
      };

  @override
  String toString() {
    return 'SpecialProductDetailsData{id: $id, name: $name, description: $description, image: $image, price: $price, off_price:$off_price,ar_price:$ar_price}';
  }
}
