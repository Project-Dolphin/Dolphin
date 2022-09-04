import 'dart:async';

import 'package:get/get.dart';
import 'package:oceanview/pages/bus/api/shuttleBusRepository.dart';

class ShuttleBusController extends GetxController {
  bool isLoading = false;
  List<NextShuttle> nextShuttle = [];

  Timer? timer;

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

  void setIsLoading(loading) {
    isLoading = loading;
    update();
  }

  void setNextShuttle(response) {
    nextShuttle = response;
    update();
  }

  void setShuttleRemainTimes() {
    if (timer == null) {
      setTimer(5, () {
        for (var i = 0; i < nextShuttle.length; i++) {
          var element = nextShuttle[i];
          DateTime now = DateTime.now();
          var shuttleTime = new DateTime(
              now.year,
              now.month,
              now.day,
              int.parse(element.time?.split(':')[0] ?? ''),
              int.parse(element.time?.split(':')[1] ?? ''));
          var differenceMinute = shuttleTime.difference(now).inMinutes;
          nextShuttle[i].remainMinutes = differenceMinute;
        }

        if (nextShuttle.length > 0 && nextShuttle[0].remainMinutes! < 0) {
          print('next ${nextShuttle[0].remainMinutes}');
          ShuttleBusRepository().getNextShuttle();
        }
      });
    }

    update();
  }
}

class NextShuttleData {
  List<NextShuttle>? nextShuttle;

  NextShuttleData({this.nextShuttle});

  NextShuttleData.fromJson(Map<String, dynamic> json) {
    if (json['nextShuttle'] != null) {
      nextShuttle = <NextShuttle>[];
      json['nextShuttle'].forEach((v) {
        nextShuttle!.add(new NextShuttle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nextShuttle != null) {
      data['nextShuttle'] = this.nextShuttle!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NextShuttle {
  String? destination;
  String? time;
  int? remainMinutes;

  NextShuttle({this.destination, this.time, this.remainMinutes});

  NextShuttle.fromJson(Map<String, dynamic> json) {
    destination = json['destination'];
    time = json['time'];
    remainMinutes = json['remainMinutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['destination'] = this.destination;
    data['time'] = this.time;
    data['remainMinutes'] = this.remainMinutes;
    return data;
  }
}
