import 'package:get/get.dart';
import 'package:oceanview/pages/home/home_controller.dart';
import 'package:oceanview/pages/home/notice/responseNotice.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NoticeRepository {
  Future<List<dynamic>> fetchNotice() async {
    final originUrl =
        'https://pxfpulri8j.execute-api.ap-northeast-2.amazonaws.com/dev/notices';
    final response = await http.get(Uri.parse(originUrl));
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
