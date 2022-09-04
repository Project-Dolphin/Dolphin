import 'package:get/get.dart';
import 'package:oceanview/api/api.dart';
import 'dart:convert' as convert;

import 'package:oceanview/pages/bus/shuttleBus/shuttleBusController.dart';

class ShuttleBusRepository {
  List<dynamic> apiToJson(response) {
    try {
      final jsonResult =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));

      return jsonResult['nextShuttle'] ?? [];
    } catch (e) {
      print('error ${e}');
      return [];
    }
  }

  Future<List<NextShuttle>?> fetchNextShuttle() async {
    var response = await FetchAPI().fetchNextShuttle();
    if (response != null) {
      return apiToJson(response)
          .map((element) => NextShuttle.fromJson(element))
          .toList();
    } else {
      return [];
    }
  }

  getNextShuttle() async {
    Get.put(ShuttleBusController());
    Get.find<ShuttleBusController>().setIsLoading(true);
    Get.find<ShuttleBusController>().setNextShuttle(await fetchNextShuttle());
    Get.find<ShuttleBusController>().setShuttleRemainTimes();
    await Future.delayed(Duration(seconds: 0),
        () => Get.find<ShuttleBusController>().setIsLoading(false));
  }
}
