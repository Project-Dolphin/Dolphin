class DepartCityBus {
  Weekday? weekday;
  Weekday? weekend;
  Weekday? holiday;

  DepartCityBus({this.weekday, this.weekend, this.holiday});

  DepartCityBus.fromJson(Map<String, dynamic> json) {
    weekday =
        json['weekday'] != null ? new Weekday.fromJson(json['weekday']) : null;
    weekend =
        json['weekend'] != null ? new Weekday.fromJson(json['weekend']) : null;
    holiday =
        json['holiday'] != null ? new Weekday.fromJson(json['holiday']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.weekday != null) {
      data['weekday'] = this.weekday!.toJson();
    }
    if (this.weekend != null) {
      data['weekend'] = this.weekend!.toJson();
    }
    if (this.holiday != null) {
      data['holiday'] = this.holiday!.toJson();
    }
    return data;
  }
}

class Weekday {
  List<String>? data;

  Weekday({this.data});

  Weekday.fromJson(Map<String, dynamic> json) {
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    return data;
  }
}
