// To parse this JSON data, do
//
//     final marketFilter = marketFilterFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MarketFilter marketFilterFromJson(String str) =>
    MarketFilter.fromJson(json.decode(str));

String marketFilterToJson(MarketFilter data) => json.encode(data.toJson());

class MarketFilter {
  MarketFilter({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<MarketFilterData> data;

  factory MarketFilter.fromJson(Map<String, dynamic> json) => MarketFilter(
        success: json["success"],
        message: json["message"],
        data: List<MarketFilterData>.from(
            json["data"].map((x) => MarketFilterData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MarketFilterData {
  MarketFilterData({
    required this.id,
    required this.productName,
    required this.price,
    required this.image,
  });

  int id;
  String productName;
  int price;
  List<MarketFilterImage> image;

  factory MarketFilterData.fromJson(Map<String, dynamic> json) =>
      MarketFilterData(
        id: json["id"],
        productName: json["product_name"],
        price: json["price"],
        image: List<MarketFilterImage>.from(
            json["image"].map((x) => MarketFilterImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "price": price,
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
      };
}

class MarketFilterImage {
  MarketFilterImage({
    required this.filePath,
  });

  String filePath;

  factory MarketFilterImage.fromJson(Map<String, dynamic> json) =>
      MarketFilterImage(
        filePath: json["file_path"],
      );

  Map<String, dynamic> toJson() => {
        "file_path": filePath,
      };
}


// // To parse this JSON data, do
// //
// //     final marketFilter = marketFilterFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// MarketFilter marketFilterFromJson(String str) =>
//     MarketFilter.fromJson(json.decode(str));

// String marketFilterToJson(MarketFilter data) => json.encode(data.toJson());

// class MarketFilter {
//   MarketFilter({
//   required this.success,
//   required this.message,
//   required this.data,
//   });

//   bool success;
//   String message;
//   List<MarketFilterdata> data;

//   factory MarketFilter.fromJson(Map<String, dynamic> json) => MarketFilter(
//         success: json["success"],
//         message: json["message"],
//         data: List<MarketFilterdata>.from(
//             json["data"].map((x) => MarketFilterdata.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class MarketFilterdata {
//   MarketFilterdata({
//   required this.id,
//   required this.productName,
//   required this.description,
//   required this.price,
//   required this.quantity,
//   required this.colors,
//   required this.sizes,
//   required this.location,
//   required this.productCode,
//   required this.inStock,
//   required this.createdAt,
//   required this.updatedAt,
//   required this.category,
//   required this.image,
//   });

//   int id;
//   String productName;
//   String description;
//   int price;
//   int quantity;
//   String colors;
//   String sizes;
//   String location;
//   String productCode;
//   int inStock;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Category category;
//   List<MarketFilterMarketFilterMarketFilterImage> image;

//   factory MarketFilterdata.fromJson(Map<String, dynamic> json) =>
//       MarketFilterdata(
//         id: json["id"],
//         productName: json["product_name"],
//         description: json["description"],
//         price: json["price"],
//         quantity: json["quantity"],
//         colors: json["colors"],
//         sizes: json["sizes"],
//         location: json["location"],
//         productCode: json["product_code"],
//         inStock: json["in_stock"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         category: Category.fromJson(json["category"]),
//         image: List<MarketFilterMarketFilterMarketFilterImage>.from(
//             json["image"].map((x) => MarketFilterMarketFilterMarketFilterImage.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "product_name": productName,
//         "description": description,
//         "price": price,
//         "quantity": quantity,
//         "colors": colors,
//         "sizes": sizes,
//         "location": location,
//         "product_code": productCode,
//         "in_stock": inStock,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "category": category.toJson(),
//         "image": List<dynamic>.from(image.map((x) => x.toJson())),
//       };

//   @override
//   String toString() {
//     return 'MarketFilterdata{id: $id, productName: $productName, description: $description, price: $price, quantity: $quantity, colors: $colors, sizes: $sizes, location: $location, productCode: $productCode, inStock: $inStock, createdAt: $createdAt, updatedAt: $updatedAt, category: $category, image: $image}';
//   }
// }

// class Category {
//   Category({
//   required this.categoryName,
//   });

//   String categoryName;

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         categoryName: json["category_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "category_name": categoryName,
//       };
// }

// class MarketFilterMarketFilterMarketFilterImage {
//   MarketFilterMarketFilterMarketFilterImage({
//   required this.filePath,
//   });

//   String filePath;

//   factory MarketFilterMarketFilterMarketFilterImage.fromJson(Map<String, dynamic> json) =>
//       MarketFilterMarketFilterMarketFilterImage(
//         filePath: json["file_path"],
//       );

//   Map<String, dynamic> toJson() => {
//         "file_path": filePath,
//       };
// }
