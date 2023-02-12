class SellAllModel {
  SellAllModel({
    this.success,
    this.message,
    this.data,
  });
  late final bool? success;
  late final String? message;
  late final List<Data>? data;

  SellAllModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['data'] = data!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.ar_pricee,
    required this.ar_off_price,
    required this.offPrice,
    required this.marketPrice,
  });
  late final int id;
  late final String image;
  late final String name;
  late final String? price;
  late final String? ar_pricee;
  late final String? ar_off_price;
  late final String offPrice;
  late final String marketPrice;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    ar_pricee = json["ar_pricee"];
    ar_off_price = json["ar_off_price"];
    offPrice = json['off_price'];
    marketPrice = json['market_price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['name'] = name;
    _data['ar_pricee'] = ar_pricee;
    _data['ar_off_price'] = ar_off_price;
    _data['price'] = price;
    _data['off_price'] = offPrice;
    _data['market_price'] = marketPrice;
    return _data;
  }
}
