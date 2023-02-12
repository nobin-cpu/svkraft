// To parse this JSON data, do
//
//     final getAddress = getAddressFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetAddress getAddressFromJson(String str) =>
    GetAddress.fromJson(json.decode(str));

String getAddressToJson(GetAddress data) => json.encode(data.toJson());

class GetAddress {
  GetAddress({
    required this.success,
    required this.messgae,
    required this.data,
  });

  bool success;
  String messgae;
  Address data;

  factory GetAddress.fromJson(Map<String, dynamic> json) => GetAddress(
        success: json["success"],
        messgae: json["messgae"],
        data: Address.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "messgae": messgae,
        "data": data.toJson(),
      };

  @override
  String toString() {
    return 'GetAddress{success: $success, messgae: $messgae, data: $data}';
  }
}

class Address {
  Address({
    required this.userId,
    required this.name,
    required this.phone,
    required this.house,
    required this.colony,
    required this.city,
    required this.area,
    required this.address,
  });

  int userId;
  String name;
  String phone;
  dynamic house;
  dynamic colony;
  dynamic city;
  dynamic area;
  dynamic address;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        userId: json["user_id"],
        name: json["name"],
        phone: json["phone"],
        house: json["house"],
        colony: json["colony"],
        city: json["city"],
        area: json["area"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "phone": phone,
        "house": house,
        "colony": colony,
        "city": city,
        "area": area,
        "address": address,
      };

  @override
  String toString() {
    return 'Address{userId: $userId, name: $name, phone: $phone, house: $house, colony: $colony, city: $city, area: $area, address: $address}';
  }
}











// import 'package:meta/meta.dart';
// import 'dart:convert';

// GetAddress getAddressFromJson(String str) =>
//     GetAddress.fromJson(json.decode(str));

// String getAddressToJson(GetAddress data) => json.encode(data.toJson());

// class GetAddress {
//   GetAddress({
//    required this.success,
//    required this.messgae,
//    required this.data,
//   });

//   bool success;
//   String messgae;
//   Address data;

//   factory GetAddress.fromJson(Map<String, dynamic> json) => GetAddress(
//         success: json["success"],
//         messgae: json["messgae"],
//         data: Address.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "messgae": messgae,
//         "data": data.toJson(),
//       };

//   @override
//   String toString() {
//     return 'GetAddress{success: $success, messgae: $messgae, data: $data}';
//   }
// }

// class Address {
//   Address({
//    required this.userId,
//    required this.name,
//    required this.phone,
//    required this.house,
//    required this.colony,
//    required this.city,
//    required this.area,
//    required this.address,
//   });

//   int userId;
//   String name;
//   String phone;
//   String house;
//   String colony;
//   String city;
//   String area;
//   String address;

//   factory Address.fromJson(Map<String, dynamic> json) => Address(
//         userId: json["user_id"],
//         name: json["name"],
//         phone: json["phone"],
//         house: json["house"],
//         colony: json["colony"],
//         city: json["city"],
//         area: json["area"],
//         address: json["address"],
//       );

//   Map<String, dynamic> toJson() => {
//         "user_id": userId,
//         "name": name,
//         "phone": phone,
//         "house": house,
//         "colony": colony,
//         "city": city,
//         "area": area,
//         "address": address,
//       };

//   @override
//   String toString() {
//     return 'Address{userId: $userId, name: $name, phone: $phone, house: $house, colony: $colony, city: $city, area: $area, address: $address}';
//   }
// }
