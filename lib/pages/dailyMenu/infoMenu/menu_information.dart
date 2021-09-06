import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//식당 운영시간
const time = [
  "11:30 ~ 13:30",
  "17:00 ~ 18:30",
  "",
]; //학생식당 (2층)
const timeCafeteria = [
  "08:00 ~ 09:30",
  "09:30 ~ 15:00",
  "16:00 ~ 18:30"
]; //스낵코너 (3층)
const timeEmployer = [
  "11:30 ~ 13:30",
  "",
  "",
]; //교직원식당 (5층)
const timeDorm = [
  "08:00 ~ 09:00",
  "11:40 ~ 13:30",
  "17:00 ~ 18:30"
]; //학생생활관 (평일)
const timeDormWeekend = [
  "08:00 ~ 09:00",
  "12:00 ~ 13:00",
  "17:00 ~ 18:00"
]; //학생생활관 (주말/공휴일)
const timeMariDorm = ["", "", ""]; //승선생활관

//식당 운영상태
const breakfastOpen = [
  TimeOfDay(hour: 8, minute: 0),
];
const breakfastClose = [
  TimeOfDay(hour: 9, minute: 30),
  TimeOfDay(hour: 9, minute: 0),
];
const lunchOpen = [
  TimeOfDay(hour: 11, minute: 30),
  TimeOfDay(hour: 9, minute: 30),
  TimeOfDay(hour: 11, minute: 40),
  TimeOfDay(hour: 12, minute: 0),
];
const lunchClose = [
  TimeOfDay(hour: 13, minute: 30),
  TimeOfDay(hour: 15, minute: 0),
  TimeOfDay(hour: 13, minute: 0),
];
const dinnerOpen = [
  TimeOfDay(hour: 17, minute: 0),
  TimeOfDay(hour: 16, minute: 0),
];
const dinnerClose = [
  TimeOfDay(hour: 18, minute: 30),
  TimeOfDay(hour: 18, minute: 0),
];

bool status(TimeOfDay start, TimeOfDay end) {
  TimeOfDay now = TimeOfDay.now();
  // print(now.toString());
  // print(start.toString());
  // print(end.toString());
  if (now.hour >= start.hour && now.hour <= end.hour) {
    if ((now.hour >= start.hour && now.minute >= start.minute) &&
        (now.hour <= end.hour)) {
      if ((now.hour == end.hour && now.minute <= end.minute)) {
        return true;
      } else if (now.hour < end.hour) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } else {
    return false;
  }
}

var statStudent1 = status(lunchOpen[0], lunchClose[0]);
var statStudent2 = status(dinnerOpen[0], dinnerClose[0]);

var statCafeteria1 = status(breakfastOpen[0], breakfastClose[0]);
var statCafeteria2 = status(lunchOpen[1], lunchClose[1]);
var statCafeteria3 = status(dinnerOpen[1], dinnerClose[0]);

var statEmployer1 = status(lunchOpen[0], lunchClose[0]);

var statDorm1 = status(breakfastOpen[0], breakfastClose[1]);
var statDorm2 = status(lunchOpen[2], lunchClose[0]);
var statDorm3 = status(dinnerOpen[0], dinnerClose[0]);

var statWeekend1 = status(breakfastOpen[0], breakfastClose[1]);
var statWeekend2 = status(lunchOpen[3], lunchClose[2]);
var statWeekend3 = status(dinnerOpen[0], dinnerClose[1]);

//식단 종류
const timeName1 = ["중식", "석식", "일품식"]; //학생식당
const timeName2 = ["조식", "중식", "석식"]; //스낵코너, 생활관(학생,승선)
const timeName3 = ["중식", "일품식", ""]; //교직원

//식단 사이트
const mariDorm = "http://badaro.kmou.ac.kr/food"; //승선생활관
const dorm =
    "https://www.kmou.ac.kr/dorm/dv/dietView/selectDietCalendarView.do"; //학생생활관
const cafeteria =
    "https://www.kmou.ac.kr/coop/dv/dietView/selectDietDateView.do"; //승선생활관
const menuSites = [cafeteria, cafeteria, cafeteria, dorm, mariDorm];

//식단 메뉴 파싱
var emptyMenu = ['식단이 없어요'];

var snackMenu = [];
var cafeteriaMenu = [];
var cafeteriaSpecialMenu = [];

var employerMenu = [];
var employerSpecialMenu = [];

var americanMenu = [];
var breakfastMenu = [];
var bunsikMenu = [];
var ramenMenu = [];
var riceMenu = [];

var mariDormMenuB = [];
var mariDormMenuL = [];
var mariDormMenuD = [];

var dormMenuB = [];
var dormMenuL = [];
var dormMenuD = [];

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

Future<void> mealParse() async {
  try {
    final response = await http.get(Uri.parse(
        "https://x4hvqlt6g5.execute-api.ap-northeast-2.amazonaws.com/prod/diet/society/today"));
    final _text = json.decode(utf8.decode(response.bodyBytes));

    if (!_text['data'].contains('diet')) {
      var dataObjsJson = jsonDecode(_text)['data'] as List;
      final List<Data> parsedResponse =
          dataObjsJson.map((dataJson) => Data.fromJson(dataJson)).toList();
      _datas.clear();
      _datas.addAll(parsedResponse);

      americanMenu = (_datas[0].value + "\n").split("\n");
      menuFill(americanMenu, 2);
      breakfastMenu = (_datas[1].value + "\n").split("\n");
      menuFill(breakfastMenu, 2);
      ramenMenu = (_datas[2].value + "\n").split("\n");
      menuFill(ramenMenu, 2);
      bunsikMenu = (_datas[3].value + "\n").split("\n");
      menuFill(bunsikMenu, 2);
      riceMenu = (_datas[4].value + "\n").split("\n");
      menuFill(riceMenu, 2);
      employerMenu = (_datas[5].value + "\n").split("\n");
      menuFill(employerMenu, 8);
      employerSpecialMenu = (_datas[6].value + "\n").split("\n");
      menuFill(employerSpecialMenu, 8);
    }
  } catch (err) {
    print(err);
  }
}

// Future<List> american() async {
//   var americanMenu2 = [];
//   try {
//     final response = await http.get(Uri.parse(
//         "https://pxfpulri8j.execute-api.ap-northeast-2.amazonaws.com/dev/diet/society/today"));
//     _text = utf8.decode(response.bodyBytes);
//     var dataObjsJson = jsonDecode(_text)['data'] as List;
//     final List<Data> parsedResponse =
//     dataObjsJson.map((dataJson) => new Data.fromJson(dataJson)).toList();
//     _datas.clear();
//     _datas.addAll(parsedResponse);
//
//     americanMenu2 = (_datas[0].value + "\n").split("\n");
//     menuFill(americanMenu2, 2);
//
//     return americanMenu2;
//   }
//   catch (err) {
//     throw Exception("Failed to load data");
//   }
// }

List breakfast() {
  Future.delayed(Duration(seconds: 0)).then((_) => mealParse());
  return breakfastMenu;
}

Future<void> mariDormParse() async {
  final response = await http.get(Uri.parse(
      "https://x4hvqlt6g5.execute-api.ap-northeast-2.amazonaws.com/prod/diet/naval/today"));
  _text = utf8.decode(response.bodyBytes);
  if (_text.contains('no any diet')) {
    _datas.clear();
  } else {
    var dataObjsJson = jsonDecode(_text)['data'] as List;
    final List<Data> parsedResponse =
        dataObjsJson.map((dataJson) => Data.fromJson(dataJson)).toList();
    _datas.clear();
    _datas.addAll(parsedResponse);
  }
}

void menuFill(List listItem, int size) {
  while (listItem.length < size) {
    listItem.add("");
  }
}

// class MealMenu extends StatelessWidget {
//   MealMenu({Key ? key}) : super(key:key);
//
//   @override
//   return
// }