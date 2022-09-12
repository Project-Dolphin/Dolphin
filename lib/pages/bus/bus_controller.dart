import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:oceanview/pages/bus/widgets/cityBus.dart';
import 'package:oceanview/pages/bus/widgets/commuterBus.dart';
import 'package:oceanview/pages/bus/widgets/schoolBus.dart';
import 'package:oceanview/pages/bus/widgets/shuttleBus.dart';
import 'package:intl/intl.dart';
import 'package:oceanview/pages/home/dayStatus/dayStatusRepository.dart';

class BusController extends GetxController {
  final String title = 'Home Title';
  String formattedDate = '';
  String stat = ' ';
  final List<String> titleList = ['190번', '셔틀버스', '통근버스', '학교버스'];
  final List<dynamic> testPageList = [
    CityBus(),
    ShuttleBus(),
    CommuterBus(),
    SchoolBus()
  ];

  final Map<int, bool> isNotificationOn = {
    10: false,
    11: false,
    12: false,
    13: false,
    20: false,
    21: false,
    22: false,
    23: false,
    30: false,
    31: false,
    32: false,
    33: false,
    40: false,
    41: false,
    42: false,
    43: false,
  }.obs;
  //앞자리 1 - 190 2번째 , 2 - 190 3번째, 3 - 셔틀 2번째, 4 - 셔틀 3번째
  //1,2 뒷자리 0,1,2,3 - '주변정류장', '해양대구본관', '부산역', '영도대교'
  //3,4 뒷자리 0,1 - '학교종점 (아치나루터)', '하리상가'
  final name = '버스';

  @override
  void onInit() {
    super.onInit();
    setDate(getDate());
    new DayStatusRepository().getDayStatus();
    initNotification();
    Timer.periodic(Duration(seconds: 10), (Timer t) => setDate(getDate()));
  }

  void initNotification() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    pendingNotificationRequests.forEach((element) {
      setNotificationEach(element.id, true);
    });
  }

  set isNotificationOn(notificationList) =>
      this.isNotificationOn = notificationList;

  bool? getIsNotiOn(id) {
    return isNotificationOn[id];
  }

  void setDate(date) {
    formattedDate = date;
    update();
  }

  void setStat(newStat) {
    stat = newStat;
    update();
  }

  void setNotificationEach(int index, bool isOn) {
    if (index > 0) {
      isNotificationOn[index] = isOn;
      update();
    }
  }

  void setNotificationAll(notificationList) {
    isNotificationOn = notificationList;
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
