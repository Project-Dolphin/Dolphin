import 'dart:async';

import 'package:get/get.dart';
import 'package:oceanview/pages/bus/api/shuttleBusRepository.dart';

class ShuttleBusController extends GetxController {
  bool isLoading = false;
  List<String> stationList = [
    '학교종점 (아치나루터)',
    '하리상가',
  ];
  String selectedStation = '학교종점 (아치나루터)';

  Timer? timer;

  List<dynamic> nextShuttle = [];
  List<dynamic> previousShuttle = [];
  List<dynamic> shuttleList = [];

  List<dynamic> remainTime = [];
  List<dynamic> hariRemainTime = [];
  String previousTime = '';

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void setTimer(seconds, function) {
    timer = Timer.periodic(Duration(seconds: seconds), (timer) {
      function();
    });
    update();
  }

  void setSelectedStation(station) {
    selectedStation = station;
    update();
  }

  void setIsLoading(loading) {
    isLoading = loading;
    update();
  }

  void setNextShuttle(response) {
    var now = DateTime.now();
    List<DateTime> newPreviousShuttle = [];
    List<DateTime> newNextShuttle = [];
    for (var i = 0; i < response[1].length; i++) {
      if (response[1][i]['type'] != 'none') {
        var hour = int.parse(response[1][i]['time'].substring(0, 2));
        var minute = int.parse(response[1][i]['time'].substring(2, 4));
        now.hour > hour
            ? newNextShuttle
                .add(DateTime(now.year, now.month, now.day + 1, hour, minute))
            : newNextShuttle
                .add(DateTime(now.year, now.month, now.day, hour, minute));
      }
    }

    if (response[0].length > 0 && response[0]['type'] != 'none') {
      var hour = int.parse(response[0]['time'].substring(0, 2));
      var minute = int.parse(response[0]['time'].substring(2, 4));
      newPreviousShuttle
          .add(DateTime(now.year, now.month, now.day, hour, minute));
    }
    nextShuttle = newNextShuttle;
    previousShuttle = newPreviousShuttle;

    update();
  }

  void setShuttleList(shuttleList) {
    shuttleList = shuttleList;
    update();
  }

  void setShuttleRemainTimes() {
    previousTime = previousShuttle.length > 0
        ? (previousShuttle[0].difference(DateTime.now()).inMinutes * -1)
            .toString()
        : '';
    for (var i = 0; i < nextShuttle.length; i++) {
      var differenceMinute =
          nextShuttle[i].difference(DateTime.now()).inMinutes;
      hariRemainTime.add((differenceMinute + 6).toString());
      remainTime.add(differenceMinute.toString());
    }

    if (timer == null) {
      setTimer(30, () {
        remainTime = [];
        hariRemainTime = [];

        nextShuttle.forEach((element) {
          var differenceMinute = element.difference(DateTime.now()).inMinutes;
          hariRemainTime.add((differenceMinute + 6).toString());
          remainTime.add(differenceMinute.toString());
        });
        if (nextShuttle.length > 0 && int.parse(remainTime[0]) <= 0) {
          ShuttleBusRepository().getNextShuttle();
        }
      });
    }

    update();
  }
}
