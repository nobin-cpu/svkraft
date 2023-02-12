// To parse this JSON data, do
//
//     final specialCategory1 = specialCategory1FromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SpecialCategory1 specialCategory1FromJson(String str) =>
    SpecialCategory1.fromJson(json.decode(str));

String specialCategory1ToJson(SpecialCategory1 data) =>
    json.encode(data.toJson());

class SpecialCategory1 {
  SpecialCategory1({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<SpecialCategory1Datum> data;

  factory SpecialCategory1.fromJson(Map<String, dynamic> json) =>
      SpecialCategory1(
        success: json["success"],
        message: json["message"],
        data: List<SpecialCategory1Datum>.from(
            json["data"].map((x) => SpecialCategory1Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SpecialCategory1Datum {
  SpecialCategory1Datum({
    required this.id,
    required this.name,
    required this.image,
  });

  int id;
  String name;
  dynamic image;

  factory SpecialCategory1Datum.fromJson(Map<String, dynamic> json) =>
      SpecialCategory1Datum(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };

  @override
  String toString() {
    return 'SpecialCategory1Datum{id: $id, name: $name, image: $image}';
  }
}
