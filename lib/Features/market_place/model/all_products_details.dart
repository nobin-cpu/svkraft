// To parse this JSON data, do
//
//     final productdetails = productdetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Productdetails productdetailsFromJson(String str) => Productdetails.fromJson(json.decode(str));

String productdetailsToJson(Productdetails data) => json.encode(data.toJson());

class Productdetails {
    Productdetails({
        @required this.success,
        @required this.message,
        @required this.data,
    });

    bool? success;
    String ?message;
    List<Datum> ?data;

    factory Productdetails.fromJson(Map<String, dynamic> json) => Productdetails(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        @required this.id,
        @required this.categoryId,
        @required this.categoryName,
        @required this.productName,
        @required this.description,
        @required this.price,
        @required this.adsType,
        @required this.gearbox,
        @required this.model,
        @required this.milage,
        @required this.cartType,
        @required this.fuel,
        @required this.location,
        @required this.isBookmark,
        @required this.image,
    });

    int? id;
    String? categoryId;
    String? categoryName;
    String? productName;
    String? description;
    String? price;
    String? adsType;
    String? gearbox;
    String? model;
    String? milage;
    String? cartType;
    String? fuel;
    String? location;
    bool? isBookmark;
    List<Image> ?image;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        categoryName: json["category_name"] == null ? null : json["category_name"],
        productName: json["product_name"] == null ? null : json["product_name"],
        description: json["description"] == null ? null : json["description"],
        price: json["price"] == null ? null : json["price"],
        adsType: json["adsType"] == null ? null : json["adsType"],
        gearbox: json["gearbox"] == null ? null : json["gearbox"],
        model: json["model"] == null ? null : json["model"],
        milage: json["milage"] == null ? null : json["milage"],
        cartType: json["cartType"] == null ? null : json["cartType"],
        fuel: json["fuel"] == null ? null : json["fuel"],
        location: json["location"] == null ? null : json["location"],
        isBookmark: json["is_bookmark"] == null ? null : json["is_bookmark"],
        image: json["image"] == null ? null : List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "category_id": categoryId == null ? null : categoryId,
        "category_name": categoryName == null ? null : categoryName,
        "product_name": productName == null ? null : productName,
        "description": description == null ? null : description,
        "price": price == null ? null : price,
        "adsType": adsType == null ? null : adsType,
        "gearbox": gearbox == null ? null : gearbox,
        "model": model == null ? null : model,
        "milage": milage == null ? null : milage,
        "cartType": cartType == null ? null : cartType,
        "fuel": fuel == null ? null : fuel,
        "location": location == null ? null : location,
        "is_bookmark": isBookmark == null ? null : isBookmark,
        "image": image == null ? null : List<dynamic>.from(image!.map((x) => x.toJson())),
    };
}

class Image {
    Image({
        @required this.filePath,
    });

    String ?filePath;

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        filePath: json["file_path"] == null ? null : json["file_path"],
    );

    Map<String, dynamic> toJson() => {
        "file_path": filePath == null ? null : filePath,
    };
}
