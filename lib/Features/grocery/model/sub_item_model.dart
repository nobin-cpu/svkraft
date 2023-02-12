// To parse this JSON data, do
//
//     final subItemModel = subItemModelFromJson(jsonString);

import 'dart:convert';

SubItemModel subItemModelFromJson(String str) =>
    SubItemModel.fromJson(json.decode(str));

String subItemModelToJson(SubItemModel data) => json.encode(data.toJson());

class SubItemModel {
  SubItemModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<Datum>? data;

  factory SubItemModel.fromJson(Map<String, dynamic> json) => SubItemModel(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.title,
    required this.lists,
    required this.id,
  });

  String title;
  int id;
  List<ListElement> lists;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        id: json['id'],
        lists: List<ListElement>.from(
            json["lists"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "lists": List<dynamic>.from(lists.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.offPrice,
    this.pricee,
    this.ar_off_price,
    required this.marketPrice,
    this.bookmark,
  });

  int id;
  String image;
  String name;
  String description;
  double price;
  int offPrice;
  String? pricee;
  String? ar_off_price;
  String marketPrice;
  bool? bookmark;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        price: json["price"].toDouble(),
        offPrice: json["off_price"],
        pricee: json["pricee"],
        ar_off_price: json["ar_off_price"],
        marketPrice: json["market_price"],
        bookmark: json["bookmark"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "description": description,
        "price": price,
        "pricee": pricee,
        "off_price": offPrice,
        "ar_off_price": ar_off_price,
        "market_price": marketPrice,
        "bookmark": bookmark,
      };
}
