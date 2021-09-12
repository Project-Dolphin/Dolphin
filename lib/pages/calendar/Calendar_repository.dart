import 'dart:convert';

import 'package:get/get.dart';
import 'package:oceanview/api/api.dart';
import 'package:oceanview/pages/calendar/calendar_controller.dart';

class CalendarReposiory {
  List<CalendarData> calendarToJson(response) {
    try {
      final responseJson = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        final List<CalendarData> result = [
          ...responseJson['data'].map((e) => CalendarData.fromJson(e))
        ];
        return result;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (err) {
      print("calendar error!");
      return [
        CalendarData.fromJson({
          "term": {"startedAt": "1900-01-01", "endedAt": "1900-12-31"},
          "content": "일정 정보 없음",
          "mainPlan": false
        })
      ];
    }
  }

  List<HolidayData> holidayToJson(response) {
    try {
      final responseJson = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        final List<HolidayData> result = [
          ...responseJson['data'].map((e) => HolidayData.fromJson(e))
        ];
        return result;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (err) {
      print("holiday error!");
      return [
        HolidayData.fromJson({
          "startedAt": "1900-1-1",
          "endedAt": "1900-1-1",
          "content": "휴일 정보 없음"
        })
      ];
    }
  }

  Future fetchHoliday() async {
    return holidayToJson(await FetchAPI().fetchHoliday());
  }

  Future fetchCalendar() async {
    return calendarToJson(await FetchAPI().fetchCalendar());
  }

  getCalendar() async {
    Get.put(CalendarController());
    //Get.find<CalendarController>().setIsLoading(true);
    Get.find<CalendarController>().setCalendar(await fetchCalendar());
    //Get.find<CalendarController>().setIsLoading(false);
  }

  // getHoliday() async {
  //   Get.put(CalendarController());
  //   //Get.find<CalendarController>().setIsLoading(true);
  //   Get.find<CalendarController>().setHoliday(await fetchHoliday());
  //   //Get.find<CalendarController>().setIsLoading(false);
  // }
}
