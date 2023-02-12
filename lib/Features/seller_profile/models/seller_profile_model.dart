// To parse this JSON data, do
//
//     final sellerProfile = sellerProfileFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SellerProfile sellerProfileFromJson(String str) =>
    SellerProfile.fromJson(json.decode(str));

String sellerProfileToJson(SellerProfile data) => json.encode(data.toJson());

class SellerProfile {
  SellerProfile({
    this.success,
    this.message,
    this.user,
    this.product,
  });

  bool? success;
  String? message;
  SellerProfileUser? user;
  List<SellerProfileProduct>? product;

  factory SellerProfile.fromJson(Map<String, dynamic> json) => SellerProfile(
        success: json["success"],
        message: json["message"],
        user: SellerProfileUser.fromJson(json["user"]),
        product: List<SellerProfileProduct>.from(
            json["product"].map((x) => SellerProfileProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "user": user!.toJson(),
        "product": List<dynamic>.from(product!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'SellerProfile{success: $success, message: $message, user: $user, product: $product}';
  }
}

class SellerProfileProduct {
  SellerProfileProduct({
    this.id,
    this.productName,
    this.price,
    this.image,
  });

  int? id;
  String? productName;
  String? price;
  List<SellerProfileImage>? image;

  factory SellerProfileProduct.fromJson(Map<String, dynamic> json) =>
      SellerProfileProduct(
        id: json["id"],
        productName: json["product_name"],
        price: json["price"],
        image: List<SellerProfileImage>.from(
            json["image"].map((x) => SellerProfileImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "price": price,
        "image": List<dynamic>.from(image!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'SellerProfileProduct{id: $id, productName: $productName, price: $price, image: $image}';
  }
}

class SellerProfileImage {
  SellerProfileImage({
    required this.filePath,
  });

  String filePath;

  factory SellerProfileImage.fromJson(Map<String, dynamic> json) =>
      SellerProfileImage(
        filePath: json["file_path"],
      );

  Map<String, dynamic> toJson() => {
        "file_path": filePath,
      };

  @override
  String toString() {
    return 'SellerProfileImage{filePath: $filePath}';
  }
}

class SellerProfileUser {
  SellerProfileUser({
    this.image,
    this.name,
    this.email,
    this.phone,
    this.location,
  });

  dynamic image;
  String? name;
  String? email;
  String? phone;
  dynamic location;

  factory SellerProfileUser.fromJson(Map<String, dynamic> json) =>
      SellerProfileUser(
        image: json["image"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "email": email,
        "phone": phone,
        "location": location,
      };

  @override
  String toString() {
    return 'SellerProfileUser{image: $image, name: $name, email: $email, phone: $phone, location: $location}';
  }
}
