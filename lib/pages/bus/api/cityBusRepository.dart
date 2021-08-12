import 'package:get/get.dart';
import 'package:oceanview/api/api.dart';

import 'dart:convert' as convert;
import 'package:oceanview/pages/bus/cityBus/cityBusController.dart';

class CityBusRepository {
  List<dynamic> apiToJson(response) {
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

  Future<List<dynamic>> fetchNextCityBus(bstopid) async {
    return apiToJson(await FetchAPI().fetchCityBusInfo(bstopid));
  }

  Future<List<dynamic>> fetchCityBusList() async {
    return apiToJson(await FetchAPI().fetchCityBusList());
  }

  Future<List<dynamic>> fetchNexthDepartCityBus() async {
    return apiToJson(await FetchAPI().fetchNextDepartCityBus());
  }

  getNextCityBus(bstopid) async {
    Get.put(CityBusController());
    Get.find<CityBusController>().setResponseCityBus([]);
    Get.find<CityBusController>()
        .setResponseCityBus(await fetchNextCityBus(bstopid));
  }

  getNextDepartCityBus() async {
    Get.put(CityBusController());
    Get.find<CityBusController>().setIsLoading(true);
    Get.find<CityBusController>()
        .setDepartCityBus(await fetchNexthDepartCityBus());
    Get.find<CityBusController>().setIsLoading(false);
  }
}
