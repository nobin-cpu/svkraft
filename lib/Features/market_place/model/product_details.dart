// To parse this JSON data, do
//
//     final productDetails = productDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductDetails productDetailsFromJson(String str) =>
    ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
  ProductDetails({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  ProductDetailsData data;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        success: json["success"],
        message: json["message"],
        data: ProductDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class ProductDetailsData {
  ProductDetailsData({
    required this.id,
    required this.userId,
    required this.productName,
    required this.description,
    required this.price,
    required this.quantity,
    required this.location,
    required this.brand,
    required this.condition,
    required this.productCode,
    required this.inStock,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.phone,
    required this.image,
  });

  int id;
  int userId;
  String productName;
  String description;
  int price;
  int quantity;
  String location;
  String brand;
  String condition;
  String name;
  String productCode;
  int inStock;
  DateTime createdAt;
  DateTime updatedAt;
  String phone;
  List<ProductDetailsImage> image;

  factory ProductDetailsData.fromJson(Map<String, dynamic> json) =>
      ProductDetailsData(
        id: json["id"],
        name: json['name'],
        userId: json["user_id"],
        productName: json["product_name"],
        description: json["description"],
        price: json["price"],
        quantity: json["quantity"],
        location: json["location"],
        brand: json["brand"],
        condition: json["condition"],
        productCode: json["product_code"],
        inStock: json["in_stock"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        phone: json["phone"],
        image: List<ProductDetailsImage>.from(
            json["image"].map((x) => ProductDetailsImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_name": productName,
        "name": name,
        "description": description,
        "price": price,
        "quantity": quantity,
        "location": location,
        "brand": brand,
        "condition": condition,
        "product_code": productCode,
        "in_stock": inStock,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "phone": phone,
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'ProductDetailsData{id: $id, userId: $userId, productName: $productName, description: $description, price: $price, quantity: $quantity, location: $location, brand: $brand, condition: $condition, productCode: $productCode, inStock: $inStock, createdAt: $createdAt, updatedAt: $updatedAt,phone : $phone , image: $image}';
  }
}

class ProductDetailsImage {
  ProductDetailsImage({
    required this.filePath,
  });

  String filePath;

  factory ProductDetailsImage.fromJson(Map<String, dynamic> json) =>
      ProductDetailsImage(
        filePath: json["file_path"],
      );

  Map<String, dynamic> toJson() => {
        "file_path": filePath,
      };

  @override
  String toString() {
    return 'ProductDetailsImage{filePath: $filePath}';
  }
}





// // To parse this JSON data, do
// //
// //     final productDetails = productDetailsFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// ProductDetails productDetailsFromJson(String str) =>
//     ProductDetails.fromJson(json.decode(str));

// String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

// class ProductDetails {
//   ProductDetails({
//    required this.success,
//    required this.message,
//    required this.data,
//   });

//   bool success;
//   String message;
//   ProductDetailsProductDetailsData data;

//   factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
//         success: json["success"],
//         message: json["message"],
//         data: ProductDetailsProductDetailsData.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": data.toJson(),
//       };
// }

// class ProductDetailsProductDetailsData {
//   ProductDetailsProductDetailsData({
//    required this.id,
//    required this.userId,
//    required this.productName,
//    required this.description,
//    required this.price,
//    required this.quantity,
//    required this.location,
//    required this.brand,
//    required this.condition,
//    required this.productCode,
//    required this.inStock,
//    required this.createdAt,
//    required this.updatedAt,
//    required this.image,
//   });

//   int id;
//   int userId;
//   String productName;
//   String description;
//   int price;
//   int quantity;
//   String location;
//   String brand;
//   String condition;
//   String productCode;
//   int inStock;
//   DateTime createdAt;
//   DateTime updatedAt;
//   List<ProductDetailsProductDetailsImage> image;

//   factory ProductDetailsProductDetailsData.fromJson(Map<String, dynamic> json) =>
//       ProductDetailsProductDetailsData(
//         id: json["id"],
//         userId: json["user_id"],
//         productName: json["product_name"],
//         description: json["description"],
//         price: json["price"],
//         quantity: json["quantity"],
//         location: json["location"],
//         brand: json["brand"],
//         condition: json["condition"],
//         productCode: json["product_code"],
//         inStock: json["in_stock"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         image: List<ProductDetailsProductDetailsImage>.from(
//             json["image"].map((x) => ProductDetailsProductDetailsImage.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "product_name": productName,
//         "description": description,
//         "price": price,
//         "quantity": quantity,
//         "location": location,
//         "brand": brand,
//         "condition": condition,
//         "product_code": productCode,
//         "in_stock": inStock,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "image": List<dynamic>.from(image.map((x) => x.toJson())),
//       };
// }

// class ProductDetailsProductDetailsImage {
//   ProductDetailsProductDetailsImage({
//    required this.filePath,
//   });

//   String filePath;

//   factory ProductDetailsProductDetailsImage.fromJson(Map<String, dynamic> json) =>
//       ProductDetailsProductDetailsImage(
//         filePath: json["file_path"],
//       );

//   Map<String, dynamic> toJson() => {
//         "file_path": filePath,
//       };
// }


