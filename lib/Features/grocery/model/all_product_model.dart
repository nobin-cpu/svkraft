// To parse this JSON data, do
//
//     final groceryAllProduct = groceryAllProductFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GroceryAllProduct groceryAllProductFromJson(String str) =>
    GroceryAllProduct.fromJson(json.decode(str));

String groceryAllProductToJson(GroceryAllProduct data) =>
    json.encode(data.toJson());

class GroceryAllProduct {
  GroceryAllProduct({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<GroceryAllProductData> data;

  factory GroceryAllProduct.fromJson(Map<String, dynamic> json) =>
      GroceryAllProduct(
        success: json["success"],
        message: json["message"],
        data: List<GroceryAllProductData>.from(
            json["data"].map((x) => GroceryAllProductData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'GroceryAllProduct{success: $success, message: $message, data: $data}';
  }
}

class GroceryAllProductData {
  GroceryAllProductData({
    required this.id,
    required this.image,
    required this.name,
  });

  int id;
  String image;
  String name;

  factory GroceryAllProductData.fromJson(Map<String, dynamic> json) =>
      GroceryAllProductData(
        id: json["id"] ?? null,
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
      };

  @override
  String toString() {
    return 'GroceryAllProductData{id: $id, image: $image, name: $name, }';
  }
}









// // To parse this JSON data, do
// //
// //     final groceryAllProduct = groceryAllProductFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// GroceryAllProduct groceryAllProductFromJson(String str) =>
//     GroceryAllProduct.fromJson(json.decode(str));

// String groceryAllProductToJson(GroceryAllProduct data) =>
//     json.encode(data.toJson());

// class GroceryAllProduct {
//   GroceryAllProduct({
//    required this.success,
//    required this.message,
//    required this.data,
//   });

//   bool success;
//   String message;
//   List<GroceryAllProductData> data;

//   factory GroceryAllProduct.fromJson(Map<String, dynamic> json) =>
//       GroceryAllProduct(
//         success: json["success"],
//         message: json["message"],
//         data: List<GroceryAllProductData>.from(
//             json["data"].map((x) => GroceryAllProductData.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class GroceryAllProductData {
//   GroceryAllProductData({
//    required this.id,
//    required this.image,
//    required this.name,
//    required this.description,
//    required this.price,
//    required this.offPrice,
//    required this.marketPrice,
//   });

//   int id;
//   String image;
//   String name;
//   String description;
//   double price;
//   int offPrice;
//   String marketPrice;

//   factory GroceryAllProductData.fromJson(Map<String, dynamic> json) =>
//       GroceryAllProductData(
//         id: json["id"],
//         image: json["image"],
//         name: json["name"],
//         description: json["description"],
//         price: json["price"].toDouble(),
//         offPrice: json["off_price"],
//         marketPrice: json["market_price"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "image": image,
//         "name": name,
//         "description": description,
//         "price": price,
//         "off_price": offPrice,
//         "market_price": marketPrice,
//       };

//   @override
//   String toString() {
//     return 'GroceryAllProductData{id: $id, image: $image, name: $name, description: $description, price: $price, offPrice: $offPrice, marketPrice: $marketPrice}';
//   }
// }



