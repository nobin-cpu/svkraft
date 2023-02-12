import 'dart:convert';

class ChatUserModel {
    ChatUserModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final List<Datum> data;

    factory ChatUserModel.fromJson(Map<String, dynamic> json){ 
        return ChatUserModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
    }

}

class Datum {
    Datum({
        required this.userId,
        required this.name,
        required this.image,
        required this.message,
        required this.read,
        required this.time,
        required this.productid,
    });

    final int? userId;
    final String? name;
    final String? image;
    final String? message;
    final int? read;
    final String? time;
    final int ? productid;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
        userId: json["user_id"],
        name: json["name"],
        image: json["image"],
        productid: json["product_id"],

        message: json["message"],
        read: json["read"],
        time: json["time"],
    );
    }

}
