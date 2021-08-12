import 'package:get/get.dart';
import 'package:oceanview/pages/bus/api/shuttleBusRepository.dart';

class ShuttleBusController extends GetxController {
  bool isLoading = false;
  List<String> stationList = [
    '학교종점 (아치나루터)',
    '하리상가',
  ];
  String selectedStation = '학교종점 (아치나루터)';
  List<DateTime> nextShuttle = [];
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
    List<DateTime> newNextShuttle = [];
    for (var i = 0; i < response.length; i++) {
      var hour = int.parse(response[i]['time'].substring(0, 2));
      var minute = int.parse(response[i]['time'].substring(2, 4));
      now.hour > hour
          ? newNextShuttle
              .add(DateTime(now.year, now.month, now.day + 1, hour, minute))
          : newNextShuttle
              .add(DateTime(now.year, now.month, now.day, hour, minute));
    }
    nextShuttle = newNextShuttle;

    update();
  }

  void setShuttleList(shuttleList) {
    shuttleList = shuttleList;
    update();
  }
}
