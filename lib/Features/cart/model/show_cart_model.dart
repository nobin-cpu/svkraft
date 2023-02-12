// To parse this JSON data, do
//
//     final checkout = checkoutFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Checkout checkoutFromJson(String str) => Checkout.fromJson(json.decode(str));

String checkoutToJson(Checkout data) => json.encode(data.toJson());

class Checkout {
  Checkout({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory Checkout.fromJson(Map<String, dynamic> json) => Checkout(
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
    required this.user,
    required this.grocery,
    required this.special_day,
    required this.totalPrice,
  });

  User user;
  List<Grocery> grocery;
  List<SpecialDay> special_day;
  int totalPrice;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        grocery:
            List<Grocery>.from(json["grocery"].map((x) => Grocery.fromJson(x))),
        special_day: List<SpecialDay>.from(
            json["special_day"].map((x) => SpecialDay.fromJson(x))),
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "grocery": List<dynamic>.from(grocery.map((x) => x.toJson())),
        "special_day": List<dynamic>.from(special_day.map((x) => x.toJson())),
        "total_price": totalPrice,
      };
}

class Grocery {
  Grocery({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  int id;
  String name;
  String image;
  int price;
  int quantity;

  factory Grocery.fromJson(Map<String, dynamic> json) => Grocery(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "quantity": quantity,
      };

  @override
  String toString() {
    return 'Grocery{id: $id, name: $name, image: $image, price: $price, quantity: $quantity}';
  }
}

class SpecialDay {
  SpecialDay({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  int id;
  String name;
  String image;
  int price;
  int quantity;

  factory SpecialDay.fromJson(Map<String, dynamic> json) => SpecialDay(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "quantity": quantity,
      };
}

class User {
  User({
    required this.name,
  });

  String name;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
