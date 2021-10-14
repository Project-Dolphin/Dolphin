import 'package:get/get.dart';
import 'package:oceanview/api/api.dart';

import 'dart:convert' as convert;
import 'package:oceanview/pages/bus/cityBus/cityBusController.dart';

class CityBusRepository {
  List<dynamic> shuttleApiToJson(response) {
    if (response.statusCode == 200) {
      final jsonResult =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
      final jsonNextShuttle = jsonResult['data'];

      return jsonNextShuttle;
    } else {
      print('error ${response.statusCode}');
      return [];
    }
  }

  CityBusData cityBusApiToJson(response) {
    if (response.statusCode == 200) {
      final jsonResult =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
      final jsonNextShuttle = CityBusData.fromJson(jsonResult['data']);

      return jsonNextShuttle;
    } else {
      print('error ${response.statusCode}');
      return CityBusData();
    }
  }

  List<CityBusListData> cityBusListApiToJson(response) {
    if (response.statusCode == 200) {
      final jsonResult =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
      final List<CityBusListData> jsonCityBusList = [
        ...jsonResult['data'].map((e) => CityBusListData.fromJson(e))
      ];

      return jsonCityBusList;
    } else {
      print('error ${response.statusCode}');
      return [CityBusListData()];
    }
  }

  Future<dynamic> fetchNextCityBus(bstopid) async {
    return cityBusApiToJson(await FetchAPI().fetchCityBusInfo(bstopid));
  }

  Future<List<CityBusListData>> fetchCityBusList() async {
    return cityBusListApiToJson(await FetchAPI().fetchCityBusList());
  }

  Future<List<dynamic>> fetchNexthDepartCityBus() async {
    return shuttleApiToJson(await FetchAPI().fetchNextDepartCityBus());
  }

  getNextCityBus(bstopid) async {
    Get.put(CityBusController());

    Get.find<CityBusController>()
        .setResponseCityBus(await fetchNextCityBus(bstopid));
    Get.find<CityBusController>().setFetchTime();
    Get.find<CityBusController>().setBusRemainTimes();
  }

  getNextDepartCityBus() async {
    Get.put(CityBusController());
    if (Get.find<CityBusController>().lastFetchTime == null ||
        Get.find<CityBusController>()
                .lastFetchTime!
                .difference(DateTime.now())
                .inSeconds <
            -5) {
      Get.find<CityBusController>().setIsLoading(true);
      Get.find<CityBusController>()
          .setDepartCityBus(await fetchNexthDepartCityBus());
      Get.find<CityBusController>().setFetchTime();
      Get.find<CityBusController>().setBusRemainTimes();

      // Get.find<CityBusController>().setIsLoading(false);
    }
  }

  getCityBusList() async {
    Get.put(CityBusController());
    Get.find<CityBusController>()
        .setResponseCityBusList(await fetchCityBusList());
    Get.find<CityBusController>().setBusRemainTimes();
  }
}
