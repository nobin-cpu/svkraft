// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  Register({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  SignupUser data;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        success: json["success"],
        message: json["message"],
        data: SignupUser.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };

  @override
  String toString() {
    return 'Register{success: $success, message: $message, data: $data}';
  }
}

class SignupUser {
  SignupUser({
    required this.token,
    required this.user,
  });

  String token;
  User user;

  factory SignupUser.fromJson(Map<String, dynamic> json) => SignupUser(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };

  @override
  String toString() {
    return 'SignupUser{token: $token, user: $user}';
  }
}

class User {
  User({
    required this.username,
    required this.name,
    required this.email,
    required this.phone,
    required this.id,
  });

  String username;
  String name;
  String email;
  String phone;
  int id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "email": email,
        "phone": phone,
        "id": id,
      };

  @override
  String toString() {
    return 'User{username: $username, name: $name, email: $email, phone: $phone, id: $id}';
  }
}
