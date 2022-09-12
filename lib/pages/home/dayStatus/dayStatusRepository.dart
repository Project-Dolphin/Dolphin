import 'package:get/get.dart';
import 'package:oceanview/api/api.dart';
import 'package:oceanview/pages/bus/bus_controller.dart';
import 'package:oceanview/pages/home/home_controller.dart';
import 'dart:convert' as convert;

import 'package:oceanview/pages/home/weather/responseWeather.dart';

class DayStatusRepository {
  Future<dynamic> fetchDayStatus() async {
    final response = await FetchAPI().fetchHomeStatus();
    try {
      final jsonResult =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
      final dayType = jsonResult['dayType'];

      return dayType;
    } catch (e) {
      print('error ${e}');
      return '에러';
    }
  }

  getDayStatus() async {
    var dayType = await fetchDayStatus();
    Get.put(HomeController());
    Get.find<HomeController>().setStat(dayType);
    Get.put(BusController());
    Get.find<BusController>().setStat(dayType);
  }
}
