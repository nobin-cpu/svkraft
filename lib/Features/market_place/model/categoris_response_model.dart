class CategorisResponseModel {
  bool? success;
  String? message;
  int? itemsFound;
  List<Data>? data;

  CategorisResponseModel(
      {this.success, this.message, this.itemsFound, this.data});

  CategorisResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    itemsFound = json['items_found'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['items_found'] = this.itemsFound;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? productId;
  String? productName;
  String? image;
  int? price;

  Data({this.productId, this.productName, this.price});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['image'] = this.image;
    data['price'] = this.price;
    return data;
  }
}
