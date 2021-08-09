import 'package:get/get.dart';
import 'dart:convert' as convert;

import 'package:oceanview/pages/api/api.dart';
import 'package:oceanview/pages/bus/api/responseBus.dart';
import 'package:oceanview/pages/bus/shuttleBus/shuttleBusController.dart';

class ShuttleBusRepository {
  List<dynamic> apiToJson(response) {
    if (response.statusCode == 200) {
      final jsonResult =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
      final jsonNextShuttle = jsonResult['data'];
      print(jsonNextShuttle);

      return jsonNextShuttle;
    } else {
      print('error ${response.statusCode}');
      return [];
    }
  }

  Future<List<dynamic>> fetchNextShuttle() async {
    return apiToJson(await FetchAPI().fetchNextShuttle());
  }

  Future<List<dynamic>> fetchShuttleList() async {
    return apiToJson(await FetchAPI().fetchShuttleList());
  }

  getNextShuttle() async {
    Get.put(ShuttleBusController());
    Get.find<ShuttleBusController>().setNextShuttle([]);
    Get.find<ShuttleBusController>().setNextShuttle(await fetchNextShuttle());
  }

  getShuttleList() async {
    Get.put(ShuttleBusController());
    Get.find<ShuttleBusController>().setShuttleList([]);
    Get.find<ShuttleBusController>().setShuttleList(await fetchShuttleList());
  }
}
