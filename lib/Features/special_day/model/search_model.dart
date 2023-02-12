// To parse this JSON data, do
//
//     final secialSearch = secialSearchFromJson(jsonString);
import 'package:meta/meta.dart';
import 'dart:convert';

SecialSearch secialSearchFromJson(String str) =>
    SecialSearch.fromJson(json.decode(str));

String secialSearchToJson(SecialSearch data) => json.encode(data.toJson());

class SecialSearch {
  SecialSearch({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<SpecialSearchData> data;

  factory SecialSearch.fromJson(Map<String, dynamic> json) => SecialSearch(
        success: json["success"],
        message: json["message"],
        data: List<SpecialSearchData>.from(json["data"].map((x) => SpecialSearchData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SpecialSearchData {
  SpecialSearchData({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  int id;
  String name;
  String description;
  String image;
  int price;

  factory SpecialSearchData.fromJson(Map<String, dynamic> json) => SpecialSearchData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
      };
}
