class ResponseBus {
  List<Data>? data;
  String? path;

  ResponseBus({this.data, this.path});

  ResponseBus.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['path'] = this.path;
    return data;
  }
}

class Data {
  String? type;
  String? time;

  Data({this.type, this.time});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['time'] = this.time;
    return data;
  }
}
