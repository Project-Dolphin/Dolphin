import 'dart:convert';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:getx_app/pages/bus/bus_arrive_Info.dart';
import 'package:http/http.dart' as http;

class ArriveInfoViewModel {
  String url =
      'http://61.43.246.153/openapi-data/service/busanBIMS2/busStopArr';
  String serviceKey =
      '?serviceKey=R3BdsX99pQj7YTLiUWzWoPMqBWqfOMg9alf9pGA88lx3tknpA5uE04cl0nMrXiCt3X%2BlUzTJ1Mwa8qZAxO6eZA%3D%3D';
  String lineInfo = 'lineid=5200190000';
  Future<List<ArriveInfo>> fetchBstop(String bstopid) async {
    //final response = await http.get(Uri.parse(this.url + serviceKey + "&bstopid=" + bstopid + "&" + lineInfo));

    String jsonString = await rootBundle.loadString('assets/json/exam.json');
    List jsonData = json.decode(jsonString);

    return jsonData.map((post) => new ArriveInfo.fromJson(post)).toList();

    /*if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((arriveInfo) => new ArriveInfo.fromJson(arriveInfo)).toList();
    } else {
      throw Exception('Failed to load post');
    } */
  }
}
