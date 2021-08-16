import 'dart:convert' as convert;

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

const BASE_URL = 'pxfpulri8j.execute-api.ap-northeast-2.amazonaws.com';
const PATH = const {
  'CALENDAR': '/calendar',
  'LATEST_CALENDAR': '/calendar/latest',
  'NOTICES': '/notices',
  'BUS_190': '/businfo',
  'SHUTTLE_NEXT': '/shuttle/next',
  'SHUTTLE_LIST': '/shuttle/today',
  'SHUTTLE_ALL': '/timetable/shuttle',
  'DEPART_190': '/timetable/190',
};

class FetchAPI {
  Future fetchData(path, {queryParameters}) async {
    var url = Uri.https(BASE_URL, '/dev$path', queryParameters);
    var response = await http.get(url);
    return response;
  }

  Future fetchCityBusInfo(bstopid) async {
    var response = await fetchData('${PATH['BUS_190']}/${bstopid.trim()}');
    return response;
  }

  Future fetchCityBusList() async {
    var response = await fetchData(PATH['BUS_190']);
    return response;
  }

  Future fetchNextDepartCityBus() async {
    var response = await fetchData(PATH['DEPART_190']);
    return response;
  }

  Future fetchNextShuttle() async {
    var response = await fetchData(PATH['SHUTTLE_NEXT']);
    return response;
  }

  Future fetchShuttleList() async {
    var response = await fetchData(PATH['SHUTTLE_LIST']);
    return response;
  }

  Future fetchSchoolNotice() async {
    var response = await fetchData(PATH['NOTICES']);
    return response;
  }

  Future fetchLatestCaelndar() async {
    var response = await fetchData(PATH['LATEST_CALENDAR']);
    return response;
  }
}
