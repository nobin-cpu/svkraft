import '../../cart/model/show_cart_model.dart';

class HistoryModel {
  bool? success;
  String? message;
  List<Data>? data;

  HistoryModel({this.success, this.message, this.data});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? orderCode;
  String? price;
  String? status;
  String? createdAt;
  OrderDetails? orderDetails;

  Data(
      {this.id,
      this.orderCode,
      this.price,
      this.status,
      this.createdAt,
      this.orderDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderCode = json['order_code'];
    price = json['price'];
    status = json['status'];
    createdAt = json['created_at'];
    orderDetails = json['order_details'] != null
        ? new OrderDetails.fromJson(json['order_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_code'] = this.orderCode;
    data['price'] = this.price;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails!.toJson();
    }
    return data;
  }
}

class OrderDetails {
  List<Grocery>? grocery;
  List<SpecialDay>? specialDay;

  OrderDetails({this.grocery, this.specialDay});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    if (json['grocery'] != null) {
      grocery = <Grocery>[];
      json['grocery'].forEach((v) {
        grocery!.add(new Grocery.fromJson(v));
      });
    }
    if (json['special_day'] != null) {
      specialDay = <SpecialDay>[];
      json['special_day'].forEach((v) {
        specialDay!.add(SpecialDay.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.grocery != null) {
      data['grocery'] = this.grocery!.map((v) => v.toJson()).toList();
    }
    if (this.specialDay != null) {
      data['special_day'] = this.specialDay!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Grocery {
  int? id;
  String? name;
  String? image;
  int? price;
  int? quantity;

  Grocery({this.id, this.name, this.image, this.price, this.quantity});

  Grocery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}
