// To parse this JSON data, do
//
//     final getCartSummary = getCartSummaryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetCartSummary getCartSummaryFromJson(String str) =>
    GetCartSummary.fromJson(json.decode(str));

String getCartSummaryToJson(GetCartSummary data) => json.encode(data.toJson());

class GetCartSummary {
  GetCartSummary({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  CartSummaryData data;

  factory GetCartSummary.fromJson(Map<String, dynamic> json) => GetCartSummary(
        success: json["success"],
        message: json["message"],
        data: CartSummaryData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };

  @override
  String toString() {
    return 'GetCartSummary{success: $success, message: $message, data: $data}';
  }
}

class CartSummaryData {
  CartSummaryData({
    required this.totalItem,
    required this.totalPrice,
    required this.shippingCharge,
  });

  String totalItem;
  String totalPrice;
  String shippingCharge;

  factory CartSummaryData.fromJson(Map<String, dynamic> json) =>
      CartSummaryData(
        totalItem: json["totalItem"],
        totalPrice: json["totalPrice"],
        shippingCharge: json["shippingCharge"],
      );

  Map<String, dynamic> toJson() => {
        "totalItem": totalItem,
        "totalPrice": totalPrice,
        "shippingCharge": shippingCharge,
      };

  @override
  String toString() {
    return 'CartSummaryData{totalItem: $totalItem, totalPrice: $totalPrice, shippingCharge: $shippingCharge}';
  }
}
