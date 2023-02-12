class SpecialRemainderModel {
  bool? success;
  String? message;
  List<Data>? data;

  SpecialRemainderModel({this.success, this.message, this.data});

  SpecialRemainderModel.fromJson(Map<String, dynamic> json) {
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
  int? reminderId;
  String? title;
  String? time;
  String? image;

  Data({this.reminderId, this.title, this.time, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    reminderId = json['reminder_id'];
    title = json['title'];
    time = json['time'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reminder_id'] = this.reminderId;
    data['title'] = this.title;
    data['time'] = this.time;
    data['image'] = this.image;
    return data;
  }
}