class MarketPlaceModel {
  bool? success;
  String? message;
  Data? data;

  MarketPlaceModel({this.success, this.message, this.data});

  MarketPlaceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? phone;
  String? name;
  Details? details;

  Data({this.phone, this.name, this.details});

  Data.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    name = json['name'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['name'] = this.name;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    return data;
  }
}

class Details {
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
  List<Image>? image;

  Details(
      {this.categoryId,
      this.categoryName,
      this.productName,
      this.description,
      this.price,
      this.adsType,
      this.gearbox,
      this.model,
      this.milage,
      this.cartType,
      this.fuel,
      this.location,
      this.image});

  Details.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    productName = json['product_name'];
    description = json['description'];
    price = json['price'];
    adsType = json['adsType'];
    gearbox = json['gearbox'];
    model = json['model'];
    milage = json['milage'];
    cartType = json['cartType'];
    fuel = json['fuel'];
    location = json['location'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(Image.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['product_name'] = this.productName;
    data['description'] = this.description;
    data['price'] = this.price;
    data['adsType'] = this.adsType;
    data['gearbox'] = this.gearbox;
    data['model'] = this.model;
    data['milage'] = this.milage;
    data['cartType'] = this.cartType;
    data['fuel'] = this.fuel;
    data['location'] = this.location;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Image {
  String? filePath;

  Image({this.filePath});

  Image.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_path'] = this.filePath;
    return data;
  }
}
