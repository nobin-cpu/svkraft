// To parse this JSON data, do
//
//     final bookmarkCategory = bookmarkCategoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BookmarkCategory bookmarkCategoryFromJson(String str) =>
    BookmarkCategory.fromJson(json.decode(str));

String bookmarkCategoryToJson(BookmarkCategory data) =>
    json.encode(data.toJson());

class BookmarkCategory {
  BookmarkCategory({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<BookmarkCategoryData> data;

  factory BookmarkCategory.fromJson(Map<String, dynamic> json) =>
      BookmarkCategory(
        success: json["success"],
        message: json["message"],
        data: List<BookmarkCategoryData>.from(
            json["data"].map((x) => BookmarkCategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'BookmarkCategory{success: $success, message: $message, data: $data}';
  }
}

class BookmarkCategoryData {
  BookmarkCategoryData({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory BookmarkCategoryData.fromJson(Map<String, dynamic> json) =>
      BookmarkCategoryData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  String toString() {
    return 'BookmarkCategoryData{id: $id, name: $name}';
  }
}
