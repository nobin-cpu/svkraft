// To parse this JSON data, do
//
//     final getProfileDetails = getProfileDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetProfileDetails getProfileDetailsFromJson(String str) =>
    GetProfileDetails.fromJson(json.decode(str));

String getProfileDetailsToJson(GetProfileDetails data) =>
    json.encode(data.toJson());

class GetProfileDetails {
  GetProfileDetails({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  GetProfileDetailsData data;

  factory GetProfileDetails.fromJson(Map<String, dynamic> json) =>
      GetProfileDetails(
        success: json["success"],
        message: json["message"],
        data: GetProfileDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };

  @override
  String toString() {
    return 'GetProfileDetails{success: $success, message: $message, data: $data}';
  }
}

class GetProfileDetailsData {
  GetProfileDetailsData(
      {required this.id,
      required this.image,
      required this.name,
      required this.username,
      required this.email,
      required this.phone,
      required this.phoneVerified,
      required this.dateOfBirth,
      required this.gender,
      required this.location,
      required this.coins});

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
  String coins;

  factory GetProfileDetailsData.fromJson(Map<String, dynamic> json) =>
      GetProfileDetailsData(
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
        "coins": coins
      };

  @override
  String toString() {
    return 'GetProfileDetailsData{id: $id, image: $image, name: $name, username: $username, email: $email, phone: $phone, phoneVerified: $phoneVerified, dateOfBirth: $dateOfBirth, gender: $gender,location: $location,coins:$coins';
  }
}
