import 'package:get/get.dart';
import 'package:oceanview/pages/bus/cityBus/cityBusRepository.dart';
import 'package:oceanview/pages/bus/cityBus/responseCityBus.dart';
import 'package:intl/intl.dart';

class CityBusController extends GetxController {
  String nearStation = '';
  ResponseCityBus? responseCityBus;
  bool isLoading = true;
  List<String> stationList = ['주변정류장', '해양대구본관', '부산역', '영도대교'];
  String selectedStation = '주변정류장';
  List<String>? departSchoolBusData;
  List<DateTime>? nextDepartCityBus;

  @override
  void onInit() async {
    super.onInit();
    String today = getDate();
    departSchoolBusData = await CityBusRepository().fetchDepartCityBus(
        today == 'Sat' || today == 'Sun' ? 'weekend' : 'weekday');
    findNextDepartCityBus();
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

  void setResponseCityBus(ResponseCityBus response) {
    responseCityBus = response;
    update();
  }

  String getDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('E');
    return formatter.format(now);
  }

  void findNextDepartCityBus() {
    var now = new DateTime.now();
    List<DateTime> result = [];
    var check3 = 0;
    for (final element in departSchoolBusData!) {
      int hour = int.parse(element.split(":")[0]);
      int minute = int.parse(element.split(":")[1]);
      DateTime elementTime =
          DateTime(now.year, now.month, now.day, hour, minute);
      if (elementTime.isAfter(now)) {
        result.add(elementTime);
        check3++;
      }
      if (check3 == 3) break;
    }
    nextDepartCityBus = result;
    update();
  }
}
