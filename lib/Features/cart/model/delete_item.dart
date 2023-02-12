// To parse this JSON data, do
//
//     final deleteCartItem = deleteCartItemFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DeleteCartItem deleteCartItemFromJson(String str) =>
    DeleteCartItem.fromJson(json.decode(str));

String deleteCartItemToJson(DeleteCartItem data) => json.encode(data.toJson());

class DeleteCartItem {
  DeleteCartItem({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory DeleteCartItem.fromJson(Map<String, dynamic> json) => DeleteCartItem(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };

  @override
  String toString() {
    return 'DeleteCartItem{success: $success, message: $message}';
  }
}
