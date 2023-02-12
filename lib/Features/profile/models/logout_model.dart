// To parse this JSON data, do
//
//     final logout = logoutFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Logout logoutFromJson(String str) => Logout.fromJson(json.decode(str));

String logoutToJson(Logout data) => json.encode(data.toJson());

class Logout {
  Logout({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory Logout.fromJson(Map<String, dynamic> json) => Logout(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };

  @override
  String toString() {
    return 'Logout{success: $success, message: $message}';
  }
}
