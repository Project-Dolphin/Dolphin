import 'package:get/get.dart';
import 'package:oceanview/api/api.dart';

import 'dart:convert' as convert;
import 'package:oceanview/pages/bus/cityBus/cityBusController.dart';

class CityBusRepository {
  List<dynamic> departCityBusApiToJson(response) {
    try {
      final jsonResult =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));

      return jsonResult['nextDepartBus'] ?? [];
    } catch (e) {
      print('error ${e}');
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

  Future<List<DepartCityBus>?> fetchNextDepartCityBus() async {
    var response =
        departCityBusApiToJson(await FetchAPI().fetchNextDepartCityBus());
    return response.map((element) => DepartCityBus.fromJson(element)).toList();
  }

  getNextCityBus(bstopid) async {
    Get.put(CityBusController());

    Get.find<CityBusController>()
        .setResponseCityBus(await fetchNextCityBus(bstopid));
    Get.find<CityBusController>().setFetchTime();
    Get.find<CityBusController>().setBusRemainTimes();
    await Future.delayed(Duration(seconds: 0),
        () => Get.find<CityBusController>().setIsLoading(false));
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
          .setDepartCityBus(await fetchNextDepartCityBus());
      Get.find<CityBusController>().setFetchTime();
      Get.find<CityBusController>().setBusRemainTimes();

      await Future.delayed(Duration(seconds: 0),
          () => Get.find<CityBusController>().setIsLoading(false));
    }
  }

  getCityBusList() async {
    Get.put(CityBusController());
    Get.find<CityBusController>()
        .setResponseCityBusList(await fetchCityBusList());
  }
}
