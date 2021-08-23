import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:oceanview/pages/bus/api/cityBusRepository.dart';
import 'package:oceanview/pages/bus/cityBus/cityBusController.dart';
import 'package:oceanview/pages/home/home_page.dart';

import 'package:oceanview/pages/home/notice/noticeRepository.dart';

Future<void> findNearStation() async {
  String? nearStation;
  String? nodeId;
  num stationDistance = 100;
  Get.put(CityBusController());
  Get.find<CityBusController>().setIsLoading(true);
  Position? _currentLocation = await _determinePosition();
  bool changeStation = false;
  station_190.forEach((element) {
    var _distance =
        pow((element['gpsX'].toDouble() - _currentLocation.longitude), 2) +
            pow((element['gpsY'].toDouble() - _currentLocation.latitude), 2);
    if (_distance < stationDistance) {
      changeStation = true;
      stationDistance = _distance;
      nearStation = element['nodeName'];
      nodeId = element['nodeId'].toString();
    }
  });

  if (!changeStation) {
    nearStation = '부산역';
    nodeId = '169100201';
  }
  Get.find<CityBusController>().setStation(nearStation);

  await CityBusRepository().getNextCityBus(nodeId);
  await onRefresh();
  Get.find<CityBusController>().setIsLoading(false);
}

Future<void> fetchStation(String nodeId) async {
  Get.put(CityBusController());
  Get.find<CityBusController>().setIsLoading(true);
  await CityBusRepository().getNextCityBus(nodeId);
  Get.find<CityBusController>().setIsLoading(false);
}

Future<Position> _determinePosition() async {
  bool? serviceEnabled;
  LocationPermission? permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

List station_190 = [
  {
    "nodeName": "남부민동",
    "nodeId": 168540201,
    "arsNo": "02189",
    "gpsX": 129.018426586869,
    "gpsY": 35.083028908476
  },
  {
    "nodeName": "해강노인관",
    "nodeId": 168640301,
    "arsNo": "02174",
    "gpsX": 129.0200583333,
    "gpsY": 35.08483
  },
  {
    "nodeName": "남부민동경로당",
    "nodeId": 168640302,
    "arsNo": "02113",
    "gpsX": 129.021815,
    "gpsY": 35.087435
  },
  {
    "nodeName": "동천아파트",
    "nodeId": 168640303,
    "arsNo": "02110",
    "gpsX": 129.021685,
    "gpsY": 35.0900566667
  },
  {
    "nodeName": "대원사",
    "nodeId": 168640304,
    "arsNo": "02101",
    "gpsX": 129.0199616667,
    "gpsY": 35.0916366667
  },
  {
    "nodeName": "초장동",
    "nodeId": 168640305,
    "arsNo": "02099",
    "gpsX": 129.01875,
    "gpsY": 35.09255
  },
  {
    "nodeName": "초장중학교",
    "nodeId": 168750301,
    "arsNo": "02096",
    "gpsX": 129.0190866667,
    "gpsY": 35.094505
  },
  {
    "nodeName": "하동상회",
    "nodeId": 168750302,
    "arsNo": "02094",
    "gpsX": 129.0182383333,
    "gpsY": 35.0962383333
  },
  {
    "nodeName": "아미초등학교",
    "nodeId": 168480201,
    "arsNo": "02079",
    "gpsX": 129.0172216667,
    "gpsY": 35.0978
  },
  {
    "nodeName": "아미치안센터",
    "nodeId": 168490301,
    "arsNo": "02077",
    "gpsX": 129.016805,
    "gpsY": 35.100007
  },
  {
    "nodeName": "토성역.아미동입구",
    "nodeId": 168500101,
    "arsNo": "02067",
    "gpsX": 129.01867,
    "gpsY": 35.0998
  },
  {
    "nodeName": "부산대학병원(토성역)",
    "nodeId": 168380101,
    "arsNo": "02064",
    "gpsX": 129.019925,
    "gpsY": 35.1013433333
  },
  {
    "nodeName": "동아대부민캠퍼스",
    "nodeId": 168360101,
    "arsNo": "02058",
    "gpsX": 129.020309,
    "gpsY": 35.106167
  },
  {
    "nodeName": "서부교회",
    "nodeId": 168350401,
    "arsNo": "02053",
    "gpsX": 129.01924,
    "gpsY": 35.1086766667
  },
  {
    "nodeName": "서대시장(동대신역)",
    "nodeId": 168370301,
    "arsNo": "02048",
    "gpsX": 129.016797275181,
    "gpsY": 35.109864798396
  },
  {
    "nodeName": "서대신역.서부경찰서",
    "nodeId": 168280301,
    "arsNo": "02190",
    "gpsX": 129.0143599,
    "gpsY": 35.10998239
  },
  {
    "nodeName": "서대신역.서대신교차로",
    "nodeId": 168620101,
    "arsNo": "02041",
    "gpsX": 129.013231714115,
    "gpsY": 35.112256686977
  },
  {
    "nodeName": "부경고교",
    "nodeId": 168620102,
    "arsNo": "02042",
    "gpsX": 129.01382,
    "gpsY": 35.11351
  },
  {
    "nodeName": "문화아파트",
    "nodeId": 504570000,
    "arsNo": "02194",
    "gpsX": 129.016121625929,
    "gpsY": 35.115276791618
  },
  {
    "nodeName": "동아대병원입구",
    "nodeId": 168470401,
    "arsNo": "02006",
    "gpsX": 129.01671130109,
    "gpsY": 35.117447299632
  },
  {
    "nodeName": "동아대학교병원",
    "nodeId": 168950101,
    "arsNo": "02057",
    "gpsX": 129.016650163503,
    "gpsY": 35.119427715614
  },
  {
    "nodeName": "경남고등학교",
    "nodeId": 168570501,
    "arsNo": "02170",
    "gpsX": 129.0179916667,
    "gpsY": 35.1191366667
  },
  {
    "nodeName": "동대고개",
    "nodeId": 168410202,
    "arsNo": "02011",
    "gpsX": 129.02175431303,
    "gpsY": 35.116056837623
  },
  {
    "nodeName": "동대신2동",
    "nodeId": 168410201,
    "arsNo": "02163",
    "gpsX": 129.0240933333,
    "gpsY": 35.1149233333
  },
  {
    "nodeName": "대신여중",
    "nodeId": 168410203,
    "arsNo": "02013",
    "gpsX": 129.0257783333,
    "gpsY": 35.1133
  },
  {
    "nodeName": "락서암",
    "nodeId": 168410204,
    "arsNo": "02015",
    "gpsX": 129.0246133333,
    "gpsY": 35.1103566667
  },
  {
    "nodeName": "혜광고교",
    "nodeId": 168410205,
    "arsNo": "01107",
    "gpsX": 129.024225,
    "gpsY": 35.1089233333
  },
  {
    "nodeName": "보수아파트",
    "nodeId": 168410206,
    "arsNo": "01105",
    "gpsX": 129.0261566667,
    "gpsY": 35.1073866667
  },
  {
    "nodeName": "중구종합사회복지관",
    "nodeId": 168250101,
    "arsNo": "01103",
    "gpsX": 129.02863,
    "gpsY": 35.10577
  },
  {
    "nodeName": "부산디지털고",
    "nodeId": 167830101,
    "arsNo": "01020",
    "gpsX": 129.0309883333,
    "gpsY": 35.1080716667
  },
  {
    "nodeName": "청운아파트",
    "nodeId": 167830102,
    "arsNo": "01016",
    "gpsX": 129.0307116667,
    "gpsY": 35.1095733333
  },
  {
    "nodeName": "동주파크맨션",
    "nodeId": 167830103,
    "arsNo": "01012",
    "gpsX": 129.029845,
    "gpsY": 35.1113366667
  },
  {
    "nodeName": "중앙공원 민주공원입구",
    "nodeId": 167840101,
    "arsNo": "01006",
    "gpsX": 129.03008865985,
    "gpsY": 35.114344170943
  },
  {
    "nodeName": "시민아파트",
    "nodeId": 167840102,
    "arsNo": "01004",
    "gpsX": 129.032159888187,
    "gpsY": 35.114921364382
  },
  {
    "nodeName": "영주삼거리",
    "nodeId": 167970102,
    "arsNo": "01001",
    "gpsX": 129.0332616667,
    "gpsY": 35.1153233333
  },
  {
    "nodeName": "동일파크맨션",
    "nodeId": 167970101,
    "arsNo": "03052",
    "gpsX": 129.033728654373,
    "gpsY": 35.117059840336
  },
  {
    "nodeName": "화신아파트",
    "nodeId": 167970103,
    "arsNo": "03050",
    "gpsX": 129.0306366667,
    "gpsY": 35.11845
  },
  {
    "nodeName": "금수사",
    "nodeId": 169310101,
    "arsNo": "03044",
    "gpsX": 129.0307666667,
    "gpsY": 35.1198316667
  },
  {
    "nodeName": "부산컴퓨터과학고교",
    "nodeId": 169310102,
    "arsNo": "03042",
    "gpsX": 129.0338733333,
    "gpsY": 35.1222383333
  },
  {
    "nodeName": "초량6동",
    "nodeId": 169310103,
    "arsNo": "03040",
    "gpsX": 129.0348466667,
    "gpsY": 35.12421
  },
  {
    "nodeName": "아르미나아파트",
    "nodeId": 169170201,
    "arsNo": "03171",
    "gpsX": 129.035788858531,
    "gpsY": 35.125520955754
  },
  {
    "nodeName": "부산서중학교",
    "nodeId": 169170202,
    "arsNo": "03176",
    "gpsX": 129.0378607,
    "gpsY": 35.12547035
  },
  {
    "nodeName": "수정1동 공영주차장",
    "nodeId": 169470101,
    "arsNo": "03172",
    "gpsX": 129.039024117153,
    "gpsY": 35.124840236452
  },
  {
    "nodeName": "한림유치원",
    "nodeId": 169470102,
    "arsNo": "03178",
    "gpsX": 129.0399311,
    "gpsY": 35.12393281
  },
  {
    "nodeName": "걸스카우트회관",
    "nodeId": 169070301,
    "arsNo": "03183",
    "gpsX": 129.039373676377,
    "gpsY": 35.122912590858
  },
  {
    "nodeName": "부산고교",
    "nodeId": 169070302,
    "arsNo": "03184",
    "gpsX": 129.038762522666,
    "gpsY": 35.120615878985
  },
  {
    "nodeName": "초량지구대",
    "nodeId": 169450401,
    "arsNo": "03066",
    "gpsX": 129.037728642867,
    "gpsY": 35.117926224452
  },
  {
    "nodeName": "초량시장입구",
    "nodeId": 169130201,
    "arsNo": "03074",
    "gpsX": 129.040577627837,
    "gpsY": 35.118492523925
  },
  {
    "nodeName": "부산역",
    "nodeId": 169100201,
    "arsNo": "03064",
    "gpsX": 129.040208807805,
    "gpsY": 35.116590670941
  },
  {
    "nodeName": "중부경찰서",
    "nodeId": 167700305,
    "arsNo": "01039",
    "gpsX": 129.0363783333,
    "gpsY": 35.1076833333
  },
  {
    "nodeName": "중앙동(중앙역)",
    "nodeId": 167860202,
    "arsNo": "01042",
    "gpsX": 129.036024663725,
    "gpsY": 35.105432821007
  },
  {
    "nodeName": "중앙동주민센터",
    "nodeId": 167720201,
    "arsNo": "01055",
    "gpsX": 129.036337474608,
    "gpsY": 35.100950218399
  },
  {
    "nodeName": "영도대교",
    "nodeId": 167850202,
    "arsNo": "01064",
    "gpsX": 129.035885,
    "gpsY": 35.0970583333
  },
  {
    "nodeName": "영도경찰서",
    "nodeId": 171630102,
    "arsNo": "04013",
    "gpsX": 129.037628,
    "gpsY": 35.092899
  },
  {
    "nodeName": "영도우체국",
    "nodeId": 170180201,
    "arsNo": "04009",
    "gpsX": 129.0410983333,
    "gpsY": 35.091685
  },
  {
    "nodeName": "해동병원",
    "nodeId": 170300101,
    "arsNo": "04004",
    "gpsX": 129.044298988292,
    "gpsY": 35.091213963098
  },
  {
    "nodeName": "교통순찰대",
    "nodeId": 170350201,
    "arsNo": "04056",
    "gpsX": 129.046431690186,
    "gpsY": 35.093660733793
  },
  {
    "nodeName": "한성맨션",
    "nodeId": 170320101,
    "arsNo": "04060",
    "gpsX": 129.0500233333,
    "gpsY": 35.0945483333
  },
  {
    "nodeName": "한진중공업",
    "nodeId": 170310101,
    "arsNo": "04063",
    "gpsX": 129.05356114847,
    "gpsY": 35.095644168852
  },
  {
    "nodeName": "신도브래뉴아파트",
    "nodeId": 170310102,
    "arsNo": "04065",
    "gpsX": 129.055467565933,
    "gpsY": 35.09727769975
  },
  {
    "nodeName": "청학시장",
    "nodeId": 210810101,
    "arsNo": "04066",
    "gpsX": 129.0598766667,
    "gpsY": 35.09721
  },
  {
    "nodeName": "청학성당",
    "nodeId": 170930101,
    "arsNo": "04069",
    "gpsX": 129.063065,
    "gpsY": 35.0957433333
  },
  {
    "nodeName": "청학주유소",
    "nodeId": 211150101,
    "arsNo": "04071",
    "gpsX": 129.0653716667,
    "gpsY": 35.092985
  },
  {
    "nodeName": "영도구청",
    "nodeId": 170990101,
    "arsNo": "04072",
    "gpsX": 129.068255,
    "gpsY": 35.0894483333
  },
  {
    "nodeName": "동삼주공아파트입구",
    "nodeId": 170990102,
    "arsNo": "04075",
    "gpsX": 129.0716566667,
    "gpsY": 35.0868883333
  },
  {
    "nodeName": "동삼삼거리",
    "nodeId": 171200101,
    "arsNo": "04082",
    "gpsX": 129.072292540617,
    "gpsY": 35.084657800434
  },
  {
    "nodeName": "일동미라주아파트",
    "nodeId": 211100201,
    "arsNo": "04084",
    "gpsX": 129.0708,
    "gpsY": 35.08184
  },
  {
    "nodeName": "동삼주택",
    "nodeId": 209710201,
    "arsNo": "04087",
    "gpsX": 129.0703833333,
    "gpsY": 35.0785666667
  },
  {
    "nodeName": "동삼동국민은행",
    "nodeId": 171190201,
    "arsNo": "04089",
    "gpsX": 129.0726133333,
    "gpsY": 35.0757816667
  },
  {
    "nodeName": "동삼혁신지구입구.동삼교회",
    "nodeId": 171130101,
    "arsNo": "04196",
    "gpsX": 129.074425,
    "gpsY": 35.073838
  },
  {
    "nodeName": "에덴금호아파트",
    "nodeId": 171290101,
    "arsNo": "04092",
    "gpsX": 129.076343127246,
    "gpsY": 35.07150438978
  },
  {
    "nodeName": "해양대입구",
    "nodeId": 171290102,
    "arsNo": "04093",
    "gpsX": 129.07817,
    "gpsY": 35.071358
  }
];
