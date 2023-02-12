// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

class UserProfileModel {
  UserProfileModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data(
      {this.id,
      this.image,
      this.name,
      this.username,
      this.email,
      this.phone,
      this.phoneVerified,
      this.dateOfBirth,
      this.gender,
      this.location,
      this.postLimit,
      this.coins});

  int? id;
  dynamic? image;
  String? name;
  String? username;
  String? email;
  String? phone;
  int? phoneVerified;
  dynamic dateOfBirth;
  dynamic? gender;
  dynamic location;
  int? postLimit;
  String? coins;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        postLimit: json["post_limit"],
        coins: json["coins"],
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
        "post_limit": postLimit,
        " coins": coins,
      };
}
