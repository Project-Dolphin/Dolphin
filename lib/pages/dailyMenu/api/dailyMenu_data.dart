class MenuData {
  final List<dynamic>? result;

  MenuData({this.result});

  factory MenuData.fromJson(Map<String, dynamic>? json) {
    return MenuData(
      result: json!['data'],
    );
  }
}

class MealData {
  int? type;
  List<String>? value;

  MealData({this.type = 99, this.value = const ["식단 없음"]});

  MealData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'].split('\n');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.value != null) {
      data['value'] = this.value!.join('\n');
    }

    return data;
  }
}
