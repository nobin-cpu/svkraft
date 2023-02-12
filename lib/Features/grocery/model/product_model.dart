// To parse this JSON data, do
//
//     final details = detailsFromJson(jsonString);

import 'dart:convert';

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));

String detailsToJson(Details data) => json.encode(data.toJson());

class Details {
    Details({
        this.success,
        this.message,
        this.data,
    });

    bool ?success;
    String? message;
    List<Datum> ?data;

    factory Details.fromJson(Map<String, dynamic> json) => Details(
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
        this.id,
        this.image,
        this.name,
        this.description,
        this.price,
        this.offPrice,
        this.marketPrice,
        this.bookmark,
    });

    int? id;
    String? image;
    String? name;
    String? description;
    double ?price;
    int? offPrice;
    String? marketPrice;
    bool? bookmark;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        image: json["image"] == null ? null : json["image"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        offPrice: json["off_price"] == null ? null : json["off_price"],
        marketPrice: json["market_price"] == null ? null : json["market_price"],
        bookmark: json["bookmark"] == null ? null : json["bookmark"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "image": image == null ? null : image,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "price": price == null ? null : price,
        "off_price": offPrice == null ? null : offPrice,
        "market_price": marketPrice == null ? null : marketPrice,
        "bookmark": bookmark == null ? null : bookmark,
    };
}
