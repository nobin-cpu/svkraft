// To parse this JSON data, do
//
//     final marketCities = marketCitiesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MarketCities marketCitiesFromJson(String str) =>
    MarketCities.fromJson(json.decode(str));

String marketCitiesToJson(MarketCities data) => json.encode(data.toJson());

class MarketCities {
  MarketCities({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<MarketCitiesData> data;

  factory MarketCities.fromJson(Map<String, dynamic> json) => MarketCities(
        success: json["success"],
        message: json["message"],
        data: List<MarketCitiesData>.from(
            json["data"].map((x) => MarketCitiesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MarketCitiesData {
  MarketCitiesData({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory MarketCitiesData.fromJson(Map<String, dynamic> json) =>
      MarketCitiesData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
