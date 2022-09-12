import 'package:get/get.dart';
import 'dart:async';
import 'package:oceanview/pages/bus/widgets/cityBus.dart';

class CityBusController extends GetxController {
  List<String> stationList = ['주변정류장', '해양대구본관', '부산역.초량시장입구', '영도대교'];
  String selectedStation = '해양대구본관';
  String nearStation = '';
  bool isLoading = true;
  CityBusData? responseCityBus = CityBusData();
  List<CityBusListData>? responseCityBusList = [CityBusListData()];

  Timer? timer;

  DateTime? lastFetchTime;

  List<DepartCityBus> departBus = [];
  List<dynamic> cityBusRemainTime = [];
  List<dynamic> cityBusArriveTime = [];

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

  void setFetchTime() {
    lastFetchTime = DateTime.now();
    update();
  }

  void setDepartCityBus(response) {
    departBus = response;
    update();
  }

  void setBusRemainTimes() {
    if (selectedStation != '해양대구본관') {
      responseCityBus != null
          ? cityBusRemainTime = [
              responseCityBus?.min1 == 999 || responseCityBus?.min1 == null
                  ? 9999
                  : responseCityBus?.min1,
              responseCityBus?.min2 == 999 || responseCityBus?.min2 == null
                  ? 9999
                  : responseCityBus?.min2,
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
        setTimer(5, () {
          for (var i = 0; i < departBus.length; i++) {
            var element = departBus[i];
            DateTime now = DateTime.now();
            var departBusTime = new DateTime(
                now.year,
                now.month,
                now.day,
                int.parse(element.bus?.split(':')[0] ?? ''),
                int.parse(element.bus?.split(':')[1] ?? ''));
            var differenceMinute = departBusTime.difference(now).inMinutes;
            departBus[i].remainMinutes = differenceMinute;
          }

          if (departBus.length > 0 && departBus[0].remainMinutes! < 0) {
            print('next ${departBus[0].remainMinutes}');
            timer?.cancel();
            fetchSelectedStation(selectedStation);
          }
        });
      } else {
        setTimer(30, () {
          cityBusRemainTime = [];

          cityBusArriveTime.forEach((element) {
            cityBusRemainTime.add(element != 9999
                ? element.difference(DateTime.now()).inMinutes
                : '9999');
          });
          if (cityBusArriveTime.length > 0 && cityBusRemainTime[0] <= 0) {
            fetchSelectedStation(selectedStation);
          }
        });
      }
    }

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
    carNo = json['carno'];
    nodeId = json['nodeid'];
    lat = json['lat'];
    lon = json['lin'];
    gpsTm = json['gpsym'];
    bstopnm = json['bstopnm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carno'] = this.carNo;
    data['nodeid'] = this.nodeId;
    data['lat'] = this.lat;
    data['lin'] = this.lon;
    data['gpsym'] = this.gpsTm;
    data['bstopnm'] = this.bstopnm;
    return data;
  }
}

class DepartCityBus {
  String? bus;
  int? remainMinutes;

  DepartCityBus({this.bus, this.remainMinutes});

  DepartCityBus.fromJson(Map<String, dynamic> json) {
    bus = json['bus'];
    remainMinutes = json['remainMinutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bus'] = this.bus;
    data['remainMinutes'] = this.remainMinutes;
    return data;
  }
}
