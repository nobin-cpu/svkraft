// To parse this JSON data, do
//
//     final getMarketBoomark = getMarketBoomarkFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetMarketBoomark getMarketBoomarkFromJson(String str) =>
    GetMarketBoomark.fromJson(json.decode(str));

String getMarketBoomarkToJson(GetMarketBoomark data) =>
    json.encode(data.toJson());

class GetMarketBoomark {
  GetMarketBoomark({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<GetMarketBoomarkData> data;

  factory GetMarketBoomark.fromJson(Map<String, dynamic> json) =>
      GetMarketBoomark(
        success: json["success"],
        message: json["message"],
        data: List<GetMarketBoomarkData>.from(
            json["data"].map((x) => GetMarketBoomarkData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'GetMarketBoomark{success: $success, message: $message, data: $data}';
  }
}

class GetMarketBoomarkData {
  GetMarketBoomarkData({
    required this.id,
    required this.productName,
    required this.price,
    required this.image,
    required this.bookmarkId,
  });

  int id;
  String productName;
  String price;
  String image;
  int bookmarkId;

  factory GetMarketBoomarkData.fromJson(Map<String, dynamic> json) =>
      GetMarketBoomarkData(
        id: json["id"],
        productName: json["product_name"],
        price: json["price"],
        image: json["image"],
        bookmarkId: json["bookmark_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "price": price,
        "image": image,
        "bookmark_id": bookmarkId,
      };

  @override
  String toString() {
    return 'GetMarketBoomarkData{id: $id, productName: $productName, price: $price, image: $image, bookmarkId: $bookmarkId}';
  }
}
