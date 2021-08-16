class LatestEvent {
  List<Data>? data;
  String? path;

  LatestEvent({this.data, this.path});

  LatestEvent.fromJson(Map<String, dynamic> json) {
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
  Term? term;
  bool? mainPlan;
  String? content;
  int? dDay;

  Data({this.term, this.mainPlan, this.content, this.dDay});

  Data.fromJson(Map<String, dynamic> json) {
    term = json['term'] != null ? new Term.fromJson(json['term']) : null;
    mainPlan = json['mainPlan'];
    content = json['content'];
    dDay = json['dDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.term != null) {
      data['term'] = this.term!.toJson();
    }
    data['mainPlan'] = this.mainPlan;
    data['content'] = this.content;
    data['dDay'] = this.dDay;
    return data;
  }
}

class Term {
  String? startedAt;
  String? endedAt;

  Term({this.startedAt, this.endedAt});

  Term.fromJson(Map<String, dynamic> json) {
    startedAt = json['startedAt'];
    endedAt = json['endedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startedAt'] = this.startedAt;
    data['endedAt'] = this.endedAt;
    return data;
  }
}
