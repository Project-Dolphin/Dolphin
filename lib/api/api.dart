import 'package:http/http.dart' as http;

const BASE_URL = 'x4hvqlt6g5.execute-api.ap-northeast-2.amazonaws.com';
const DEV_URL = 'pxfpulri8j.execute-api.ap-northeast-2.amazonaws.com';

const NEW_DEV_URL = 'ec2-3-34-85-59.ap-northeast-2.compute.amazonaws.com';

const PATH = const {
  'HOME': '/',
  'CALENDAR': '/calendar',
  'LATEST_CALENDAR': '/calendar/latest',
  'NOTICES': '/notices',
  'HOLIDAY': '/holiday',
  'BUS_190': '/businfo',
  'SHUTTLE_NEXT': '/shuttle/next',
  'NEW_SHUTTLE_NEXT': '/bus/nextshuttle',
  'NEW_DEPART_190': '/bus/departbus',
  'WEATHER': '/weather/now',
  'MEAL': '/diet/v2/society/today',
  'MEAL2': '/diet/naval/today',
  'MEAL3': '/diet/dorm/today',
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

  Future fetchNewServerData(path, {queryParameters}) async {
    try {
      var url = Uri.http(NEW_DEV_URL, path, queryParameters);
      var response = await http.get(url);
      return response;
    } catch (error) {
      print('$error');
    }
  }

  Future fetchHomeStatus() async {
    var response = await fetchNewServerData(PATH['HOME']);
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
    var response = await fetchNewServerData(PATH['NEW_DEPART_190']);
    return response;
  }

  Future fetchNextShuttle() async {
    var response = await fetchNewServerData(PATH['NEW_SHUTTLE_NEXT']);
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

  Future fetchSocietyTable() async {
    var response = await fetchData(PATH['MEAL']);
    return response;
  }

  Future fetchNavyTable() async {
    var response = await fetchData(PATH['MEAL2']);
    return response;
  }

  Future fetchDormTable() async {
    var response = await fetchData(PATH['MEAL3']);
    return response;
  }
}
