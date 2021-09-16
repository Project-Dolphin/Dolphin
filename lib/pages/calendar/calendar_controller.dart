import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oceanview/pages/calendar/calendar_widget.dart';

class CalendarController extends GetxController {
  final String title = '학사 일정';

  CarouselController carouselController = new CarouselController();
  String formattedDate = '';
  String stat = '';
  bool isLoading = false;
  DateTime selectedDay = DateTime.now();
  DateTime calendarCenter =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  List<CalendarData>? calendarData = [CalendarData()];
  List<HolidayData>? holidayData = [HolidayData()];

  final List monthArray = DateTime.now().month <= 2
      ? [
          ...[
            for (int i = 2; i <= 12; i++)
              DateTime(DateTime.now().year - 1, i, 1)
          ],
          DateTime(DateTime.now().year, 1, 1),
          DateTime(DateTime.now().year, 2, 1)
        ]
      : [
          ...[
            for (int i = 2; i <= 12; i++) DateTime(DateTime.now().year, i, 1)
          ],
          DateTime(DateTime.now().year + 1, 1, 1),
          DateTime(DateTime.now().year + 1, 2, 1)
        ];

  List<Calendar> calendarList = [];

  @override
  void onInit() {
    super.onInit();
    setDate(getDate());
    setStat(getWeekDay());
  }

  void setCalendarList() {
    calendarList = monthArray.map((e) {
      DateTime _focusedDay;
      if (e.month == DateTime.now().month) {
        _focusedDay = DateTime.now();
      } else {
        _focusedDay = e;
      }
      return new Calendar(
        calendarData: calendarData,
        holidayData: holidayData,
        specificFocusedDay: _focusedDay,
        kFirstDay: e,
      );
    }).toList();
  }

  void setFocusedDay(index, day) {
    calendarList[index] = Calendar(
      calendarData: calendarData,
      holidayData: holidayData,
      specificFocusedDay: day,
      kFirstDay: monthArray[index],
    );
    update();
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
  Term? term;
  String? content;
  bool? mainPlan;

  CalendarData({this.term, this.content, this.mainPlan});

  CalendarData.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    term = json['term'] != null ? new Term.fromJson(json['term']) : null;
    mainPlan = json['mainPlan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    if (this.term != null) {
      data['term'] = this.term!.toJson();
    }
    data['mainPlan'] = this.mainPlan;

    return data;
  }
}

class HolidayData {
  Term? term;
  String? content;

  HolidayData({this.term, this.content});

  HolidayData.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    term = json['term'] != null ? new Term.fromJson(json['term']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    if (this.term != null) {
      data['term'] = this.term!.toJson();
    }
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
