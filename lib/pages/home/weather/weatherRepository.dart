import 'package:get/get.dart';
import 'package:oceanview/api/api.dart';
import 'package:oceanview/pages/home/home_controller.dart';
import 'dart:convert' as convert;

import 'package:oceanview/pages/home/weather/responseWeather.dart';

class WeatherRepository {
  Future<Weather> fetchCurrentWeather() async {
    final response = await FetchAPI().fetchWeather();
    if (response.statusCode == 200) {
      final jsonResult =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
      final jsonNotice = jsonResult['data'];
      final weatherResult = Weather.fromJson(jsonNotice);

      return weatherResult;
    } else {
      print('error ${response.statusCode}');
      return Weather();
    }
  }

  getCurrentWeather() async {
    Get.put(HomeController());
    Get.find<HomeController>().setCurrentWeather(await fetchCurrentWeather());
  }
}
