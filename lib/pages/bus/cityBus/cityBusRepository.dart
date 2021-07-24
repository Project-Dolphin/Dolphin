import 'dart:convert' as convert;

import 'package:getx_app/pages/bus/cityBus/responseCityBus.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class CityBusRepository {
  Future<ResponseCityBus> fetchCityBus(String bstopid) async {
    final originUrl =
        'http://61.43.246.153/openapi-data/service/busanBIMS2/busStopArr?serviceKey=R3BdsX99pQj7YTLiUWzWoPMqBWqfOMg9alf9pGA88lx3tknpA5uE04cl0nMrXiCt3X%2BlUzTJ1Mwa8qZAxO6eZA%3D%3D&bstopid=' +
            bstopid +
            '&lineid=5200190000';
    print('start');
    final response = await http.get(Uri.parse(originUrl));
    if (response.statusCode == 200) {
      final xml = response.body;

      final xml2json = Xml2Json()..parse(xml);
      final json = xml2json.toParker();

      final jsonResult = convert.jsonDecode(json);
      final jsonCityBus = jsonResult['response']['body']['items']['item'];

      return ResponseCityBus.fromJson(jsonCityBus);
    } else {
      print('error ${response.statusCode}');
      return ResponseCityBus();
    }
  }
}
