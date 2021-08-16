import 'package:get/get.dart';
import 'package:oceanview/api/api.dart';
import 'package:oceanview/pages/home/home_controller.dart';
import 'dart:convert' as convert;

class NoticeRepository {
  Future<List<dynamic>> fetchNotice() async {
    final response = await FetchAPI().fetchSchoolNotice();
    if (response.statusCode == 200) {
      final jsonResult =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
      final jsonNotice = jsonResult['data'];

      return jsonNotice;
    } else {
      print('error ${response.statusCode}');
      return [];
    }
  }

  getNotice() async {
    Get.put(HomeController());
    Get.find<HomeController>().setNoticeList([]);
    Get.find<HomeController>().setNoticeList(await fetchNotice());
  }
}
