class OfferModel {
  OfferModel({
    this.success,
    this.message,
    this.data,
  });
  late final bool? success;
  late final String? message;
  late final List<Data>? data;

  OfferModel.fromJson(Map<String, dynamic> json) {
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
    required this.ar_price,
    required this.offPrice,
    required this.marketPrice,
  });
  late int id;
  late String image;
  late String name;
  late String price;
  late String ar_price;
  late String offPrice;
  late String marketPrice;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    ar_price = json['ar_price'];
    offPrice = json['off_price'];
    marketPrice = json['market_price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['name'] = name;
    _data['price'] = price;
    _data['ar_price'] = ar_price;
    _data['off_price'] = offPrice;
    _data['market_price'] = marketPrice;
    return _data;
  }
}
