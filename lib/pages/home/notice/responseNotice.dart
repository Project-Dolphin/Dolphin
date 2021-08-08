class ResponseNotice {
  List<Data>? data;
  String? path;

  ResponseNotice({this.data, this.path});

  ResponseNotice.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? date;
  String? link;

  Data({this.title, this.date, this.link});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    data['link'] = this.link;
    return data;
  }
}
