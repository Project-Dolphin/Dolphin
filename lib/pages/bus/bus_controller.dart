import 'dart:async';
import 'package:get/get.dart';
import 'package:oceanview/pages/bus/widgets/cityBus.dart';
import 'package:oceanview/pages/bus/widgets/commuterBus.dart';
import 'package:oceanview/pages/bus/widgets/schoolBus.dart';
import 'package:oceanview/pages/bus/widgets/shuttleBus.dart';
import 'package:intl/intl.dart';

class BusController extends GetxController {
  final String title = 'Home Title';
  String formattedDate = '';
  String stat = '';
  final List<String> titleList = ['190번', '셔틀버스', '통근버스', '학교버스'];
  final List<dynamic> testPageList = [
    CityBus(),
    ShuttleBus(),
    CommuterBus(),
    SchoolBus()
  ];
  final name = '버스';

  @override
  void onInit() {
    super.onInit();
    setDate(getDate());
    setStat(getWeekDay());
    Timer.periodic(Duration(seconds: 10), (Timer t) => setDate(getDate()));
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
    var formatter = new DateFormat('M월 d일 E HH:mm');
    return weekdayToKor(formatter.format(now));
  }

  String getWeekDay() {
    var now = new DateTime.now();
    print([6, 7].contains(now.weekday)
        ? '주말'
        : [7, 8, 1, 2].contains(now.month)
            ? '방학'
            : '평일');
    return [6, 7].contains(now.weekday)
        ? '주말'
        : [7, 8, 1, 2].contains(now.month)
            ? '방학'
            : '평일';
  }
}
