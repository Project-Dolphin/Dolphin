import 'package:get/get.dart';

class ShuttleBusController extends GetxController {
  bool isLoading = true;
  List<String> stationList = [
    '학교종점 (아치나루터)',
    '하리상가',
  ];
  String selectedStation = '학교종점 (아치나루터)';

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
}
