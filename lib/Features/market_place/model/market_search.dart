// To parse this JSON data, do
//
//     final marketSearch = marketSearchFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MarketSearch marketSearchFromJson(String str) =>
    MarketSearch.fromJson(json.decode(str));

String marketSearchToJson(MarketSearch data) => json.encode(data.toJson());

class MarketSearch {
  MarketSearch({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<mSearch> data;

  factory MarketSearch.fromJson(Map<String, dynamic> json) => MarketSearch(
        success: json["success"],
        message: json["message"],
        data: List<mSearch>.from(json["data"].map((x) => mSearch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class mSearch {
  mSearch({
    required this.id,
    required this.productName,
    required this.price,
    required this.image,
  });

  int id;
  String productName;
  String price;
  List<mSearchImage> image;

  factory mSearch.fromJson(Map<String, dynamic> json) => mSearch(
        id: json["id"],
        productName: json["product_name"],
        price: json["price"],
        image: List<mSearchImage>.from(
            json["image"].map((x) => mSearchImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "price": price,
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'mSearch{id: $id, productName: $productName, price: $price, image: $image}';
  }
}

class mSearchImage {
  mSearchImage({
    required this.filePath,
  });

  String filePath;

  factory mSearchImage.fromJson(Map<String, dynamic> json) => mSearchImage(
        filePath: json["file_path"],
      );

  Map<String, dynamic> toJson() => {
        "file_path": filePath,
      };

  @override
  String toString() {
    return 'mSearchImage{filePath: $filePath}';
  }
}







// import 'package:meta/meta.dart';
// import 'dart:convert';

// MarketSearch marketSearchFromJson(String str) =>
//     MarketSearch.fromJson(json.decode(str));

// String marketSearchToJson(MarketSearch data) => json.encode(data.toJson());

// class MarketSearch {
//   MarketSearch({
//   required this.success,
//   required this.message,
//   required this.data,
//   });

//   bool success;
//   String message;
//   List<mSearch> data;

//   factory MarketSearch.fromJson(Map<String, dynamic> json) => MarketSearch(
//         success: json["success"],
//         message: json["message"],
//         data: List<mSearch>.from(json["data"].map((x) => mSearch.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class mSearch {
//   mSearch({
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
//   required this.image,
//   required this.category,
//   });

//   int id;
//   String productName;
//   String description;
//   int price;
//   int quantity;
//   dynamic colors;
//   String sizes;
//   String location;
//   String productCode;
//   int inStock;
//   DateTime createdAt;
//   DateTime updatedAt;
//   List<MarketMarketmSearchmSearchImage> image;
//   Category category;

//   factory mSearch.fromJson(Map<String, dynamic> json) => mSearch(
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
//         image: List<MarketMarketmSearchmSearchImage>.from(
//             json["image"].map((x) => MarketMarketmSearchmSearchImage.fromJson(x))),
//         category: Category.fromJson(json["category"]),
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
//         "image": List<dynamic>.from(image.map((x) => x.toJson())),
//         "category": category.toJson(),
//       };
// }

// class Category {
//   Category({
//   required this.id,
//   required this.categoryName,
//   required this.image,
//   });

//   int id;
//   String categoryName;
//   String image;

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         id: json["id"],
//         categoryName: json["category_name"],
//         image: json["image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "category_name": categoryName,
//         "image": image,
//       };
// }

// class MarketMarketmSearchmSearchImage {
//   MarketMarketmSearchmSearchImage({
//   required this.filePath,
//   });

//   String filePath;

//   factory MarketMarketmSearchmSearchImage.fromJson(Map<String, dynamic> json) =>
//       MarketMarketmSearchmSearchImage(
//         filePath: json["file_path"],
//       );

//   Map<String, dynamic> toJson() => {
//         "file_path": filePath,
//       };
// }


// // To parse this JSON data, do
// //
// //     final marketSearch = marketSearchFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// MarketSearch marketSearchFromJson(String str) =>
//     MarketSearch.fromJson(json.decode(str));

// String marketSearchToJson(MarketSearch data) => json.encode(data.toJson());

// class MarketSearch {
//   MarketSearch({
// required this.success,
// required this.message,
// required this.data,
//   });

//   bool success;
//   String message;
//   List<mSearch> data;

//   factory MarketSearch.fromJson(Map<String, dynamic> json) => MarketSearch(
//         success: json["success"],
//         message: json["message"],
//         data: List<mSearch>.from(json["data"].map((x) => mSearch.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class mSearch {
//   mSearch({
// required this.id,
// required this.productName,
// required this.description,
// required this.price,
// required this.quantity,
// required this.colors,
// required this.sizes,
// required this.location,
// required this.productCode,
// required this.inStock,
// required this.createdAt,
// required this.updatedAt,
// required this.category,
// required this.image,
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
//   List<MarketMarketMarketMarketmSearchmSearchImage> image;

//   factory mSearch.fromJson(Map<String, dynamic> json) => mSearch(
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
//         image: List<MarketMarketMarketMarketmSearchmSearchImage>.from(
//             json["image"].map((x) => MarketMarketMarketMarketmSearchmSearchImage.fromJson(x))),
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
//     return 'mSearch{id: $id, productName: $productName, description: $description, price: $price, quantity: $quantity, colors: $colors, sizes: $sizes, location: $location, productCode: $productCode, inStock: $inStock, createdAt: $createdAt, updatedAt: $updatedAt, category: $category, image: $image}';
//   }
// }

// class Category {
//   Category({
// required this.categoryName,
//   });

//   String categoryName;

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         categoryName: json["category_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "category_name": categoryName,
//       };
// }

// class MarketMarketMarketMarketmSearchmSearchImage {
//   MarketMarketMarketMarketmSearchmSearchImage({
// required this.filePath,
//   });

//   String filePath;

//   factory MarketMarketMarketMarketmSearchmSearchImage.fromJson(Map<String, dynamic> json) => MarketMarketMarketMarketmSearchmSearchImage(
//         filePath: json["file_path"],
//       );

//   Map<String, dynamic> toJson() => {
//         "file_path": filePath,
//       };
// }
