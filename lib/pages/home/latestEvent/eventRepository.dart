import 'package:get/get.dart';
import 'package:oceanview/api/api.dart';
import 'dart:convert' as convert;

import 'package:oceanview/pages/home/home_controller.dart';
import 'package:oceanview/pages/home/latestEvent/responseEvent.dart';

class EventRespository {
  Future<List<dynamic>> fetchLatestEvent() async {
    final response = await FetchAPI().fetchLatestCaelndar();
    if (response.statusCode == 200) {
      final jsonResult =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
      final jsonEvent = jsonResult['data'];

      return jsonEvent;
    } else {
      print('error ${response.statusCode}');
      return [];
    }
  }

  getLatestEventList() async {
    Get.put(HomeController());
    Get.find<HomeController>().setLatestEventList([]);
    Get.find<HomeController>().setLatestEventList(await fetchLatestEvent());
  }
}
