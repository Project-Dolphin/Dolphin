import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oceanview/pages/home/dayStatus/dayStatusRepository.dart';
import 'package:oceanview/pages/home/weather/responseWeather.dart';

class HomeController extends GetxController {
  String formattedDate = ' ';
  List noticeList = [];
  List latestEventList = [];
  Weather currentWeather = Weather();
  String stat = ' ';

  @override
  void onInit() {
    super.onInit();
    getTodayDate();
  }

  void getTodayDate() {
    new DayStatusRepository().getDayStatus();
    setDate(getDate());
  }

  void setDate(date) {
    formattedDate = date;
    update();
  }

  void setStat(newStat) {
    stat = newStat;
    update();
  }

  void setNoticeList(notice) {
    noticeList = notice;
    update();
  }

  void setLatestEventList(events) {
    latestEventList = events;
    update();
  }

  void setCurrentWeather(Weather weather) {
    currentWeather = weather;
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
    var formatter = new DateFormat('M.d E');
    return weekdayToKor(formatter.format(now));
  }
}
