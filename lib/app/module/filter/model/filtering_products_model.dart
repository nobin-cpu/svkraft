import 'dart:convert';

FilteringProductsModel filteringProductsModelFromJson(String str) =>
    FilteringProductsModel.fromJson(json.decode(str));

String filteringProductsModelToJson(FilteringProductsModel data) =>
    json.encode(data.toJson());

class FilteringProductsModel {
  FilteringProductsModel({
    this.success,
    this.message,
    this.itemsFound,
    this.data,
  });

  bool? success;
  String? message;
  int? itemsFound;
  List<RealData>? data;

  factory FilteringProductsModel.fromJson(Map<String, dynamic> json) =>
      FilteringProductsModel(
        success: json["success"],
        message: json["message"],
        itemsFound: json["items_found"],
        data:
            List<RealData>.from(json["data"].map((x) => RealData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "items_found": itemsFound,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class RealData {
  RealData({
    this.productId,
    this.productName,
    this.sellerName,
    this.selleremail,
    this.sellerphone,
    this.bookmark,
    this.categoryId,
    this.categoryName,
    this.description,
    this.adsType,
    this.gearbox,
    this.model,
    this.milage,
    this.carType,
    this.fuel,
    this.brand,
    this.speeds,
    this.c_c,
    this.color,
    this.location,
    this.sellerid,
    this.price,
    this.image,
  });

  int? productId;
  String? productName;
  String? sellerName;
  String? selleremail;
  String? sellerphone;
  bool? bookmark;
  String? categoryId;
  String? categoryName;
  String? description;
  String? adsType;
  String? gearbox;
  String? model;
  String? milage;
  String? carType;
  String? fuel;
  String? brand;
  String? speeds;
  String? c_c;
  String? color;
  String? location;
  int? sellerid;
  int? price;
  String? image;

  factory RealData.fromJson(Map<String, dynamic> json) => RealData(
        productId: json["product_id"],
        productName: json["product_name"],
        sellerName: json["seller_name"],
        selleremail: json["seller_email"],
        sellerphone: json["seller_phone"],
        bookmark: json["bookmark"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        description: json["description"],
        adsType: json["ads Type"],
        gearbox: json["gearbox"],
        model: json["model"],
        milage: json["milage"],
        carType: json["cartType"],
        fuel: json["fuel"],
        brand: json["brand"],
        speeds: json["speeds"],
        color: json["color"],
        c_c: json["c_c"],
        location: json["location"],
        sellerid: json["seller_id"],
        price: json["price"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "seller_name": sellerName,
        "seller_email": selleremail,
        "seller_phone": sellerphone,
        "bookmark": bookmark,
        "category_id": categoryId,
        "category_name": categoryName,
        "description": description,
        "ads Type": adsType,
        "gearbox": gearbox,
        "model": model,
        "milage": milage,
        "cartType": carType,
        "fuel": fuel,
        "brand": brand,
        "speeds": speeds,
        "color": color,
        "c_c": c_c,
        "location": location,
        "seller_id": sellerid,
        "price": price,
        "image": image,
      };
}
