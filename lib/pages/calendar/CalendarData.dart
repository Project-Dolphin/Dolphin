class CalendarData {
  final List<dynamic>? result;

  CalendarData({this.result});

  factory CalendarData.fromJson(Map<String, dynamic>? json) {
    return CalendarData(
      result: json!['data'],
    );
  }
}