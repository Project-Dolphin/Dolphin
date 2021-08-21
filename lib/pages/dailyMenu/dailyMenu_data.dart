class MenuData {
  final List<dynamic>? result;

  MenuData({this.result});

  factory MenuData.fromJson(Map<String, dynamic>? json) {
    return MenuData(
      result: json!['data'],
    );
  }
}