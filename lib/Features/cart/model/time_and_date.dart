class DateAndTimeModel {
  bool? success;
  String? message;
  Data? data;

  DateAndTimeModel({this.success, this.message, this.data});

  DateAndTimeModel.fromJson(Map<String, dynamic> json) {
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
  List<Dates>? dates;
  List<Times>? times;

  Data({this.dates, this.times});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['dates'] != null) {
      dates = <Dates>[];
      json['dates'].forEach((v) {
        dates!.add(new Dates.fromJson(v));
      });
    }
    if (json['times'] != null) {
      times = <Times>[];
      json['times'].forEach((v) {
        times!.add(new Times.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dates != null) {
      data['dates'] = this.dates!.map((v) => v.toJson()).toList();
    }
    if (this.times != null) {
      data['times'] = this.times!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dates {
  String? nameOfDay;
  String? date;
  String? value;

  Dates({this.nameOfDay, this.date, this.value});

  Dates.fromJson(Map<String, dynamic> json) {
    nameOfDay = json['nameOfDay'];
    date = json['date'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameOfDay'] = this.nameOfDay;
    data['date'] = this.date;
    data['value'] = this.value;
    return data;
  }
}

class Times {
  String? time;
  int? value;

  Times({this.time, this.value});

  Times.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['value'] = this.value;
    return data;
  }
}