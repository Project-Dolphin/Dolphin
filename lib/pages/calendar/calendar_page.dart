import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/titlebox/onelineTitle.dart' as oneLine;
import 'package:oceanview/pages/calendar/Calendar_repository.dart';
import 'package:oceanview/common/titlebox/iconSet.dart';
import 'package:oceanview/pages/calendar/calendar_widget.dart';
import 'package:oceanview/pages/calendar/calendar_controller.dart';
import 'package:oceanview/common/sizeConfig.dart';

class CalendarPage extends GetView<CalendarController> {
  final name = '학사일정';

  Future<Null> init() async {
    await CalendarReposiory().getCalendar();
    await CalendarReposiory().getHoliday();
  }

  @override
  Widget build(BuildContext context) {
    init();
    return GetBuilder<CalendarController>(
        init: CalendarController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                CalendarIcon(),
                Positioned(
                    left: SizeConfig.sizeByWidth(20),
                    top: SizeConfig.sizeByHeight(51),
                    child: oneLine.MainTitle(
                      title: name,
                      fontsize: SizeConfig.sizeByHeight(26),
                      fontweight: FontWeight.w700,
                      isGradient: false,
                    )),
                Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.sizeByHeight(98),
                    ),
                    child: CarouselSlider(
                        options: CarouselOptions(
                          height: SizeConfig.sizeByHeight(700),
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: false,
                          initialPage: 4,
                          onPageChanged: (index, reason) {},
                        ),
                        items: [
                          ..._.monthArray.map((e) => Calendar(
                                calendarData: _.calendarData,
                                holidayData: _.holidayData,
                                kFirstDay: e,
                              ))
                        ]))
              ],
            ),
          );
        });
  }
}
