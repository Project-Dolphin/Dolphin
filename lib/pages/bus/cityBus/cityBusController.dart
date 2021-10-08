import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oceanview/pages/bus/widgets/cityBus.dart';

class CityBusController extends GetxController {
  List<String> stationList = ['주변정류장', '해양대구본관', '부산역', '영도대교'];
  String selectedStation = '해양대구본관';
  String nearStation = '';
  bool isLoading = true;
  CityBusData? responseCityBus = CityBusData();
  List<CityBusListData>? responseCityBusList = [CityBusListData()];
  List<DateTime>? nextDepartCityBus;
  List<dynamic>? nextDepartCityBusRemainTime;
  Timer? timer;

  var departRemainTime = [];
  var departArriveTime = [];
  var cityBusRemainTime = [];
  var cityBusArriveTime = [];

  @override
  void onInit() async {
    super.onInit();
    setStation(nearStation);
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void setTimer(seconds, function) {
    timer = Timer.periodic(Duration(seconds: seconds), (timer) {
      function();
      update();
    });
  }

  void setSelectedStation(station) {
    selectedStation = station;
    timer?.cancel();
    timer = null;
    update();
  }

  void setIsLoading(loading) {
    isLoading = loading;
    update();
  }

  void setStation(station) {
    nearStation = station;
    update();
  }

  void setResponseCityBus(response) {
    responseCityBus = response;

    update();
  }

  void setResponseCityBusList(response) {
    responseCityBusList = response;
    update();
  }

  void setNextDepartCityBusRemainTime(response) {
    nextDepartCityBusRemainTime = response;
    update();
  }

  void setDepartCityBus(response) {
    var now = DateTime.now();
    List<DateTime> departTimeList = [];
    for (var i = 0; i < response.length; i++) {
      if (response[i]['type'] != 'none') {
        var hour = int.parse(response[i]['time'].substring(0, 2));
        var minute = int.parse(response[i]['time'].substring(2, 4));
        now.hour > hour
            ? departTimeList
                .add(DateTime(now.year, now.month, now.day + 1, hour, minute))
            : departTimeList
                .add(DateTime(now.year, now.month, now.day, hour, minute));
      }
    }
    nextDepartCityBus = departTimeList;
    update();
  }

  void setBusRemainTimes() {
    if (selectedStation == '해양대구본관') {
      for (var i = 0; i < nextDepartCityBus!.length; i++) {
        var differenceMinute =
            nextDepartCityBus![i].difference(DateTime.now()).inMinutes;

        departRemainTime.add(differenceMinute.toString());
        departArriveTime.add(DateFormat('HH:mm').format(nextDepartCityBus![i]));
      }
    } else {
      responseCityBus != null
          ? cityBusRemainTime = [
              responseCityBus!.min1 ?? 9999,
              responseCityBus!.min2 ?? 9999
            ]
          : cityBusRemainTime = [];
      responseCityBus != null
          ? cityBusArriveTime = [
              cityBusRemainTime[0] != 9999
                  ? DateTime.now().add(Duration(minutes: cityBusRemainTime[0]))
                  : '9999',
              cityBusRemainTime[1] != 9999
                  ? DateTime.now().add(Duration(minutes: cityBusRemainTime[1]))
                  : '9999',
            ]
          : cityBusArriveTime = [];
    }

    if (timer == null) {
      if (selectedStation == '해양대구본관') {
        setTimer(30, () {
          departRemainTime = [];

          for (var i = 0; i < nextDepartCityBus!.length; i++) {
            var differenceMinute =
                nextDepartCityBus![i].difference(DateTime.now()).inMinutes;
            print(differenceMinute);
            departRemainTime.add(differenceMinute.toString());
          }
        });
      } else {
        setTimer(5, () {
          cityBusRemainTime = [];

          cityBusArriveTime.forEach((element) {
            cityBusRemainTime.add(element != 9999
                ? element.difference(DateTime.now()).inMinutes
                : '9999');
          });
        });
      }
    }

    selectedStation == '해양대구본관'
        ? departRemainTime.length > 0 &&
            int.parse(departRemainTime[0]) <= 0 &&
            fetchSelectedStation(selectedStation)
        : cityBusArriveTime.length > 0 &&
            cityBusRemainTime[0] <= 0 &&
            fetchSelectedStation(selectedStation);
    Future.delayed(Duration(seconds: 1), () => setIsLoading(false));
    update();
  }
}

class CityBusData {
  int? carNo1;
  int? carNo2;
  int? min1;
  int? min2;
  int? station1;
  int? station2;
  bool? lowplate1; // bool to int 에러 발생으로 타입 bool 로 변경
  bool? lowplate2; // bool to int 에러 발생으로 타입 bool 로 변경

  CityBusData(
      {this.carNo1,
      this.carNo2,
      this.min1,
      this.min2,
      this.station1,
      this.station2,
      this.lowplate1,
      this.lowplate2});

  CityBusData.fromJson(Map<String, dynamic> json) {
    carNo1 = json['carNo1'] == '차량 없음' ? -1 : json['carNo1'];
    carNo2 = json['carNo2'] == '차량 없음' ? -1 : json['carNo2'];
    min1 = json['min1'];
    min2 = json['min2'];
    station1 = json['station1'];
    station2 = json['station2'];
    lowplate1 = json['lowplate1'];
    lowplate2 = json['lowplate2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carNo1'] = this.carNo1;
    data['carNo2'] = this.carNo2;
    data['min1'] = this.min1;
    data['min2'] = this.min2;
    data['station1'] = this.station1;
    data['station2'] = this.station2;
    data['lowplate1'] = this.lowplate1;
    data['lowplate2'] = this.lowplate2;
    return data;
  }
}

class CityBusListData {
  String? carNo;
  int? nodeId;
  double? lat;
  double? lon;
  int? gpsTm;
  String? bstopnm;

  CityBusListData(
      {this.carNo, this.nodeId, this.lat, this.lon, this.gpsTm, this.bstopnm});

  CityBusListData.fromJson(Map<String, dynamic> json) {
    carNo = json['carNo'];
    nodeId = json['nodeId'];
    lat = json['lat'];
    lon = json['lon'];
    gpsTm = json['gpsTm'];
    bstopnm = json['bstopnm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carNo'] = this.carNo;
    data['nodeId'] = this.nodeId;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['gpsTm'] = this.gpsTm;
    data['bstopnm'] = this.bstopnm;
    return data;
  }
}
