class SubCategorisModel {
  bool? success;
  String? message;
  List<Data>? data;

  SubCategorisModel({this.success, this.message, this.data});

  SubCategorisModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
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
  String? category;
  String? icon;
  List<Subcategory>? subcategory;

  Data({this.id, this.category, this.icon, this.subcategory});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    icon = json['icon'];
    if (json['subcategory'] != null) {
      subcategory = <Subcategory>[];
      json['subcategory'].forEach((v) {
        subcategory!.add( Subcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['icon'] = this.icon;
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategory {
  String? name;
  List<ChildCategory>? childCategory;

  Subcategory({this.name, this.childCategory});

  Subcategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['child_category'] != null) {
      childCategory = <ChildCategory>[];
      json['child_category'].forEach((v) {
        childCategory!.add(new ChildCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.childCategory != null) {
      data['child_category'] =
          this.childCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildCategory {
  String? name;

  ChildCategory({this.name});

  ChildCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}