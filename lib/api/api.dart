import 'package:http/http.dart' as http;

// const BASE_URL = 'pxfpulri8j.execute-api.ap-northeast-2.amazonaws.com';

const BASE_URL = 'x4hvqlt6g5.execute-api.ap-northeast-2.amazonaws.com';

const PATH = const {
  'CALENDAR': '/calendar',
  'LATEST_CALENDAR': '/calendar/latest',
  'NOTICES': '/notices',
  'HOLIDAY': '/holiday',
  'BUS_190': '/businfo',
  'SHUTTLE_NEXT': '/shuttle/next',
  'SHUTTLE_LIST': '/shuttle/today',
  'SHUTTLE_ALL': '/timetable/shuttle',
  'DEPART_190': '/timetable/190',
  'WEATHER': '/weather/now',
};

class FetchAPI {
  Future fetchData(path, {queryParameters}) async {
    try {
      var url = Uri.https(BASE_URL, '/prod$path', queryParameters);
      var response = await http.get(url);
      return response;
    } catch (error) {
      print('$error');
    }
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

  Future fetchHoliday() async {
    var response = await fetchData(PATH['HOLIDAY']);
    return response;
  }

  Future fetchCalendar() async {
    var response = await fetchData(PATH['CALENDAR']);
    return response;
  }

  Future fetchLatestCalendar() async {
    var response = await fetchData(PATH['LATEST_CALENDAR']);
    return response;
  }

  Future fetchWeather() async {
    var response = await fetchData(PATH['WEATHER']);
    return response;
  }
}
