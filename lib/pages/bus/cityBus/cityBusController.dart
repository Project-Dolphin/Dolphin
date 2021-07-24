import 'package:get/get.dart';
import 'package:getx_app/pages/bus/cityBus/responseCityBus.dart';

class CityBusController extends GetxController {
  String nearStation = '';
  ResponseCityBus? responseCityBus;
  bool isLoading = true;
  List<String> stationList = ['주변정류장', '해양대구본관', '부산역', '영도대교'];
  String selectedStation = '주변정류장';

  @override
  void onInit() {
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

  void setStation(station) {
    nearStation = station;
    update();
  }

  void setResponseCityBus(ResponseCityBus response) {
    responseCityBus = response;
    update();
  }
}
