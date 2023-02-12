// To parse this JSON data, do
//
//     final getBookmarkProduct = getBookmarkProductFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetBookmarkProduct getBookmarkProductFromJson(String str) =>
    GetBookmarkProduct.fromJson(json.decode(str));

String getBookmarkProductToJson(GetBookmarkProduct data) =>
    json.encode(data.toJson());

class GetBookmarkProduct {
  GetBookmarkProduct({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<GetBookmarkProductData> data;

  factory GetBookmarkProduct.fromJson(Map<String, dynamic> json) =>
      GetBookmarkProduct(
        success: json["success"],
        message: json["message"],
        data: List<GetBookmarkProductData>.from(
            json["data"].map((x) => GetBookmarkProductData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetBookmarkProductData {
  GetBookmarkProductData({
    required this.bookmarkId,
    required this.groceryItem,
  });

  int bookmarkId;
  GroceryItem groceryItem;

  factory GetBookmarkProductData.fromJson(Map<String, dynamic> json) =>
      GetBookmarkProductData(
        bookmarkId: json["bookmark_id"],
        groceryItem: GroceryItem.fromJson(json["grocery_item"]),
      );

  Map<String, dynamic> toJson() => {
        "bookmark_id": bookmarkId,
        "grocery_item": groceryItem.toJson(),
      };

  @override
  String toString() {
    return 'GetBookmarkProductData{bookmarkId: $bookmarkId, groceryItem: $groceryItem}';
  }
}

class GroceryItem {
  GroceryItem({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    this.ar_price,
    this.ar_off_price,
    required this.offPrice,
    required this.marketPrice,
  });

  int id;
  String image;
  String name;
  String description;
  double price;
  String? ar_price;
  String? ar_off_price;
  int offPrice;
  String marketPrice;

  factory GroceryItem.fromJson(Map<String, dynamic> json) => GroceryItem(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        price: json["price"].toDouble(),
        offPrice: json["off_price"],
        ar_price: json["ar_price"],
        ar_off_price: json["ar_off_price"],
        marketPrice: json["market_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "description": description,
        "price": price,
        "ar_price": ar_price,
        "ar_off_price": ar_off_price,
        "off_price": offPrice,
        "market_price": marketPrice,
      };

  @override
  String toString() {
    return 'GroceryItem{id: $id, image: $image, name: $name, description: $description, price: $price,ar_price:$ar_price,ar_off_price:$ar_off_price, offPrice: $offPrice, marketPrice: $marketPrice}';
  }
}




// // To parse this JSON data, do
// //
// //     final getBookmarkProduct = getBookmarkProductFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// GetBookmarkProduct getBookmarkProductFromJson(String str) =>
//     GetBookmarkProduct.fromJson(json.decode(str));

// String getBookmarkProductToJson(GetBookmarkProduct data) =>
//     json.encode(data.toJson());

// class GetBookmarkProduct {
//   GetBookmarkProduct({
//    required this.success,
//    required this.message,
//    required this.data,
//   });

//   bool success;
//   String message;
//   List<GetBookmarkProductData> data;

//   factory GetBookmarkProduct.fromJson(Map<String, dynamic> json) =>
//       GetBookmarkProduct(
//         success: json["success"],
//         message: json["message"],
//         data: List<GetBookmarkProductData>.from(
//             json["data"].map((x) => GetBookmarkProductData.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };

//   @override
//   String toString() {
//     return 'GetBookmarkProduct{success: $success, message: $message, data: $data}';
//   }
// }

// class GetBookmarkProductData {
//   GetBookmarkProductData({
//    required this.bookmarkId,
//    required this.groceryItem,
//   });

//   int bookmarkId;
//   GroceryItem groceryItem;

//   factory GetBookmarkProductData.fromJson(Map<String, dynamic> json) =>
//       GetBookmarkProductData(
//         bookmarkId: json["bookmark_id"],
//         groceryItem: GroceryItem.fromJson(json["grocery_item"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "bookmark_id": bookmarkId,
//         "grocery_item": groceryItem.toJson(),
//       };

//   @override
//   String toString() {
//     return 'GetBookmarkProductData{bookmarkId: $bookmarkId, groceryItem: $groceryItem}';
//   }
// }

// class GroceryItem {
//   GroceryItem({
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
//   int price;
//   int offPrice;
//   String marketPrice;

//   factory GroceryItem.fromJson(Map<String, dynamic> json) => GroceryItem(
//         id: json["id"],
//         image: json["image"],
//         name: json["name"],
//         description: json["description"],
//         price: json["price"],
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
//     return 'GroceryItem{id: $id, image: $image, name: $name, description: $description, price: $price, offPrice: $offPrice, marketPrice: $marketPrice}';
//   }
// }
