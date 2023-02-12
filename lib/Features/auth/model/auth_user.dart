// To parse this JSON data, do
//
//     final authUser = authUserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AuthUser authUserFromJson(String str) => AuthUser.fromJson(json.decode(str));

String authUserToJson(AuthUser data) => json.encode(data.toJson());

class AuthUser {
  AuthUser({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.token,
    required this.user,
  });

  String token;
  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.image,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.phoneVerified,
    required this.dateOfBirth,
    required this.gender,
    required this.location,
  });

  int id;
  dynamic image;
  String name;
  String username;
  String email;
  String phone;
  int phoneVerified;
  dynamic dateOfBirth;
  dynamic gender;
  dynamic location;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        phoneVerified: json["phone_verified"],
        dateOfBirth: json["date_of_birth"],
        gender: json["gender"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "username": username,
        "email": email,
        "phone": phone,
        "phone_verified": phoneVerified,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "location": location,
      };
}
