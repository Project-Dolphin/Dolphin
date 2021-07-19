import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BusController extends GetxController {
  final String title = 'Home Title';
  String formattedDate = '';
  String nearStation = '';

  @override
  void onInit() {
    super.onInit();
    setDate(getDate());
    Timer.periodic(Duration(seconds: 10), (Timer t) => setDate(getDate()));
  }

  void setDate(date) {
    formattedDate = date;
    update();
  }

  void setStation(station) {
    nearStation = station;
    update();
  }

  void setCommuterStation(bus) {}

  String weekdayToKor(String date) {
    if (date.contains('Mon')) return date.replaceFirst('Mon', '월요일');
    if (date.contains('Tue')) return date.replaceFirst('Tue', '화요일');
    if (date.contains('Wed')) return date.replaceFirst('Wed', '수요일');
    if (date.contains('Thr')) return date.replaceFirst('Thr', '목요일');
    if (date.contains('Fri')) return date.replaceFirst('Fri', '금요일');
    if (date.contains('Sat')) return date.replaceFirst('Sat', '토요일');
    if (date.contains('Sun')) return date.replaceFirst('Sun', '일요일');
    return date;
  }

  String getDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('M월 d일 E HH:mm');
    return weekdayToKor(formatter.format(now));
  }
}

List<String> stationList_1 = [
  '풍년혼수마트',
  '롯데캐슬 상가 앞',
  '장전동 기아자동차',
  '장전동 놀이터',
  '온천장 홈플러스',
  '롯데백화점 정류장',
  '삼성프라자(온천점)',
  '교대역',
  '연산동, 연제초교',
  '양정역',
  '부전역',
  '서면역',
  '범일역 5번출구',
  '부산진역 7번출구',
  '부산역 3번출구',
  '영도대교 대궁한정식',
  '학교도착',
];

List<String> stationList_2 = [
  '서면역',
  '범일역 5번출구',
  '부산진역 7번출구',
  '부산역 3번출구',
  '영도대교 대궁한정식',
  '관사',
  '학교도착',
];

List<String> stationList_3 = [
  '연산9동 안락뜨란채',
  '망미동 주공아파트',
  '수영국민은행',
  '수영역 10번출구',
  '한서병원',
  'KBS방송국',
  '남천역 버스정류장',
  '봄봄카페',
  '더맛한우',
  '대연자이아파트 후문',
  '한라아파트',
  '동삼동 농협',
  '부산항대교',
  '학교도착',
];
