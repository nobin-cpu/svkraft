// To parse this JSON data, do
//
//     final getSpecialBoomark = getSpecialBoomarkFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetSpecialBoomark getSpecialBoomarkFromJson(String str) =>
    GetSpecialBoomark.fromJson(json.decode(str));

String getSpecialBoomarkToJson(GetSpecialBoomark data) =>
    json.encode(data.toJson());

class GetSpecialBoomark {
  GetSpecialBoomark({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<GetSpecialBoomarkData> data;

  factory GetSpecialBoomark.fromJson(Map<String, dynamic> json) =>
      GetSpecialBoomark(
        success: json["success"],
        message: json["message"],
        data: List<GetSpecialBoomarkData>.from(
            json["data"].map((x) => GetSpecialBoomarkData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetSpecialBoomarkData {
  GetSpecialBoomarkData({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.bookmarkId,
  });

  int id;
  String name;
  int price;
  String image;
  int bookmarkId;

  factory GetSpecialBoomarkData.fromJson(Map<String, dynamic> json) =>
      GetSpecialBoomarkData(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
        bookmarkId: json["bookmark_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image": image,
        "bookmark_id": bookmarkId,
      };
}



 // To parse this JSON data, do
// //
// //     final getMarketBoomark = getMarketBoomarkFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// GetMarketBoomark getMarketBoomarkFromJson(String str) =>
//     GetMarketBoomark.fromJson(json.decode(str));

// String getMarketBoomarkToJson(GetMarketBoomark data) =>
//     json.encode(data.toJson());

// class GetMarketBoomark {
//   GetMarketBoomark({
//   required this.success,
//   required this.message,
//   required this.data,
//   });

//   bool success;
//   String message;
//   List<GetMarketBoomarkDatas> data;

//   factory GetMarketBoomark.fromJson(Map<String, dynamic> json) =>
//       GetMarketBoomark(
//         success: json["success"],
//         message: json["message"],
//         data: List<GetMarketBoomarkDatas>.from(
//             json["data"].map((x) => GetMarketBoomarkDatas.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };

//   @override
//   String toString() {
//     return 'GetMarketBoomark{success: $success, message: $message, data: $data}';
//   }
// }

// class GetMarketBoomarkDatas {
//   GetMarketBoomarkDatas({
//   required this.id,
//   required this.productName,
//   required this.price,
//   required this.image,
//   required this.bookmarkId,
//   });

//   int id;
//   String productName;
//   int price;
//   String image;
//   int bookmarkId;

//   factory GetMarketBoomarkDatas.fromJson(Map<String, dynamic> json) =>
//       GetMarketBoomarkDatas(
//         id: json["id"],
//         productName: json["product_name"],
//         price: json["price"],
//         image: json["image"],
//         bookmarkId: json["bookmark_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "product_name": productName,
//         "price": price,
//         "image": image,
//         "bookmark_id": bookmarkId,
//       };

//   @override
//   String toString() {
//     return 'GetMarketBoomarkDatas{id: $id, productName: $productName, price: $price, image: $image, bookmarkId: $bookmarkId}';
//   }
// }
