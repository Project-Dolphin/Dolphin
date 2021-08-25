import 'dart:convert';
import 'package:http/http.dart' as http;

//식당 운영시간
var time = ["11:30 ~ 13:30", "17:00 ~ 18:30", ""]; //학생식당 (2층)
var timeCafeteria = ["08:00 ~ 09:30", "09:30 ~ 15:00", "16:00 ~ 18:30"]; //스낵코너 (3층)
var timeEmployer = ["11:30 ~ 13:30", "", ""]; //교직원식당 (5층)
var timeDorm = ["08:00 ~ 09:00", "11:40 ~ 13:30", "17:00 ~ 18:30"]; //학생생활관 (평일)
var timeDormWeekend = ["08:00 ~ 09:00", "12:00 ~ 13:00", "17:00 ~ 18:00"]; //학생생활관 (주말/공휴일)
var timeMariDorm = ["", "", ""]; //승선생활관

//식단 종류
var timeName1 = ["중식", "석식", "일품식"]; //학생식당
var timeName2 = ["조식", "중식", "석식"]; //스낵코너, 생활관(학생,승선)
var timeName3 = ["중식", "일품식", ""]; //교직원

//식단 사이트
var mariDorm = "http://badaro.kmou.ac.kr/food"; //승선생활관
var dorm = "https://www.kmou.ac.kr/dorm/dv/dietView/selectDietCalendarView.do"; //학생생활관
var cafeteria = "https://www.kmou.ac.kr/coop/dv/dietView/selectDietDateView.do"; //승선생활관
var menuSites = [cafeteria, cafeteria, cafeteria, dorm, mariDorm];

//식단 메뉴 파싱
var emptyMenu = ['식단이 없어요'];
var snackMenu = [];
var cafeteriaMenu = [];
var cafeteriaSpecialMenu = [];
var employerMenu = [];
var employerSpecialMenu = [];
var dormMenuB = [];
var dormMenuL = [];
var dormMenuD = [];
var mariDormMenuB = [];
var mariDormMenuL = [];
var mariDormMenuD = [];

class Data {
  int type;
  String value;

  Data(this.type, this.value);

  factory Data.fromJson(dynamic json) {
    return Data(json['type'] as int, json['value'] as String);
  }

  @override
  String toString() {
    return '{${this.type}, ${this.value}}';
  }
}

var _text = "Http Example";
List<Data> _datas = [];

void mealParse() async {
  final response = await http.get(Uri.parse(
      "https://pxfpulri8j.execute-api.ap-northeast-2.amazonaws.com/dev/diet/society/today"));
  _text = utf8.decode(response.bodyBytes);
  var dataObjsJson = jsonDecode(_text)['data'] as List;
  final List<Data> parsedResponse =
  dataObjsJson.map((dataJson) => Data.fromJson(dataJson)).toList();
  _datas.clear();
  _datas.addAll(parsedResponse);

  final data0 = _datas[0];
  final data1 = _datas[1];
  final data2 = _datas[2];
  final data3 = _datas[3];
  final data4 = _datas[4];
  final snack = data0.value+"\n"+data1.value+"\n"+data2.value+"\n"+data3.value+"\n"+data4.value+"\n";
  snackMenu = snack.split("\n");
  menuFill(snackMenu);
  employerMenu = (_datas[5].value+"\n").split("\n");
  menuFill(employerMenu);
  employerSpecialMenu = (_datas[6].value+"\n").split("\n");
  menuFill(employerSpecialMenu);
}

void mariDormParse() async {
  final response = await http.get(Uri.parse(
      "https://pxfpulri8j.execute-api.ap-northeast-2.amazonaws.com/dev/diet/naval/today"));
  _text = utf8.decode(response.bodyBytes);
  var dataObjsJson = jsonDecode(_text)['data'] as List;
  final List<Data> parsedResponse =
  dataObjsJson.map((dataJson) => Data.fromJson(dataJson)).toList();
  _datas.clear();
  _datas.addAll(parsedResponse);
  print("되는거니 뭐니 알려주렴" + parsedResponse.toString());
}

void menuFill(List listItem) {
  while(listItem.length < 8){
    listItem.add("");
  }
}