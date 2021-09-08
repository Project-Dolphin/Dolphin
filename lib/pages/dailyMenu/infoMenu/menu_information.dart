import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:oceanview/pages/dailyMenu/api/dailyMenu_data.dart';

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

Future<List<MealData>> mealParse(response) async {
  final responseJson = json.decode(utf8.decode(response.bodyBytes));

  if (responseJson['data'].length == 1) {
    return [MealData()];
  } else {
    final List<MealData> result = [
      ...responseJson['data'].map((e) => MealData.fromJson(e))
    ];

    return result;
  }
}
