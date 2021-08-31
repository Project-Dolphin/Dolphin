import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarController extends GetxController {
  final String title = '학사 일정';
  String formattedDate = '';
  String stat = '';
  bool isLoading = false;
  DateTime selectedDay = DateTime.now();
  List<CalendarData>? calendarData = [CalendarData()];
  List<HolidayData>? holidayData = [HolidayData()];

  @override
  void onInit() {
    super.onInit();
    setDate(getDate());
    setStat(getWeekDay());
  }

  void setIsLoading(loading) {
    isLoading = loading;
    update();
  }

  void setDay(datetime) {
    selectedDay = datetime;
    update();
  }

  void setCalendar(response) {
    calendarData = response;
    update();
  }

  void setHoliday(response) {
    holidayData = response;
    update();
  }

  void setDate(date) {
    formattedDate = date;
    update();
  }

  void setStat(newStat) {
    stat = newStat;
    update();
  }

  String weekdayToKor(String date) {
    if (date.contains('Mon')) return date.replaceFirst('Mon', '월요일');
    if (date.contains('Tue')) return date.replaceFirst('Tue', '화요일');
    if (date.contains('Wed')) return date.replaceFirst('Wed', '수요일');
    if (date.contains('Thu')) return date.replaceFirst('Thu', '목요일');
    if (date.contains('Fri')) return date.replaceFirst('Fri', '금요일');
    if (date.contains('Sat')) return date.replaceFirst('Sat', '토요일');
    if (date.contains('Sun')) return date.replaceFirst('Sun', '일요일');
    return date;
  }

  String getDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('M.d E HH:mm');
    return weekdayToKor(formatter.format(now));
  }

  String getWeekDay() {
    var now = new DateTime.now();
    return [6, 7].contains(now.weekday)
        ? '주말'
        : [7, 8, 1, 2].contains(now.month)
            ? '방학'
            : '평일';
  }
}

class CalendarData {
  String? content;
  String? startedAt;
  String? endedAt;
  bool? mainPlan;

  CalendarData({this.content, this.startedAt, this.endedAt, this.mainPlan});

  CalendarData.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    startedAt = json['term']['startedAt'];
    endedAt = json['term']['endedAt'];
    mainPlan = json['mainPlan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['term']['startedAt'] = this.startedAt;
    data['term']['endedAt'] = this.endedAt;
    data['mainPlan'] = this.mainPlan;

    return data;
  }
}

class HolidayData {
  String? content;
  String? startedAt;
  String? endedAt;

  HolidayData({this.content, this.startedAt, this.endedAt});

  HolidayData.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    startedAt = json['term']['startedAt'];
    endedAt = json['term']['endedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['term']['startedAt'] = this.startedAt;
    data['term']['endedAt'] = this.endedAt;

    return data;
  }
}
