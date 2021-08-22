import 'package:get/get.dart';
import 'package:oceanview/pages/bus/api/shuttleBusRepository.dart';

class ShuttleBusController extends GetxController {
  bool isLoading = false;
  List<String> stationList = [
    '학교종점 (아치나루터)',
    '하리상가',
  ];
  String selectedStation = '학교종점 (아치나루터)';
  List<dynamic> nextShuttle = [];
  List<dynamic> previousShuttle = [];
  List<dynamic> shuttleList = [];

  @override
  void onInit() async {
    super.onInit();
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
    print(response[0]);
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
}
