import 'package:get/get.dart';
import 'package:oceanview/pages/api/api.dart';
import 'package:oceanview/pages/bus/cityBus/responseCityBus.dart';
import 'package:intl/intl.dart';

class CityBusController extends GetxController {
  String nearStation = '';
  var responseCityBus;
  bool isLoading = true;
  List<String> stationList = ['주변정류장', '해양대구본관', '부산역', '영도대교'];
  String selectedStation = '주변정류장';
  List<DateTime>? nextDepartCityBus;

  @override
  void onInit() async {
    super.onInit();
    String today = getDate();
  }

  void setSelectedStation(station) {
    selectedStation = station;
    update();
  }

  void setIsLoading(loading) {
    isLoading = loading;
    update();
  }

  void setStation(station) {
    nearStation = station;
    update();
  }

  void setResponseCityBus(response) {
    responseCityBus = response;
    update();
  }

  void setDepartCityBus(response) {
    var now = DateTime.now();
    List<DateTime> departTimeList = [];
    for (var i = 0; i < response.length; i++) {
      var hour = int.parse(response[i]['time'].substring(0, 2));
      var minute = int.parse(response[i]['time'].substring(2, 4));
      now.hour > hour
          ? departTimeList
              .add(DateTime(now.year, now.month, now.day + 1, hour, minute))
          : departTimeList
              .add(DateTime(now.year, now.month, now.day, hour, minute));
    }
    nextDepartCityBus = departTimeList;
    print(response);
    // nextDepartCityBus = response;
    update();
  }

  String getDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('E');
    return formatter.format(now);
  }
}
