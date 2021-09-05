import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/titlebox/onelineTitle.dart' as oneLine;
import 'package:oceanview/pages/calendar/Calendar_repository.dart';
import 'package:oceanview/common/titlebox/iconSet.dart';
import 'package:oceanview/pages/calendar/calendar_widget.dart';
import 'package:oceanview/pages/calendar/calendar_controller.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    top: SizeConfig.sizeByHeight(14),
                    child: oneLine.MainTitle(
                      title: name,
                      fontsize: SizeConfig.sizeByHeight(26),
                      fontweight: FontWeight.w700,
                      isGradient: false,
                    )),
                Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.sizeByHeight(68),
                    ),
                    child: CarouselSlider(
                        options: CarouselOptions(
                          height: SizeConfig.sizeByHeight(600),
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: false,
                          initialPage: 5,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {},
                        ),
                        items: [
                          ..._.monthArray.map((e) => Calendar(
                                calendarData: _.calendarData,
                                holidayData: _.holidayData,
                                kFirstDay: e,
                              ))
                        ])),
                Positioned(
                    bottom: SizeConfig.sizeByHeight(35),
                    right: SizeConfig.sizeByWidth(29),
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '전체일정 보기',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff353B45)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 1),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Color(0xff353B45),
                            ),
                          ),
                        ],
                      ),
                      onPressed: _launchURL,
                    )),
              ],
            ),
          );
        });
  }
}

_launchURL() async {
  const url =
      'https://www.kmou.ac.kr/onestop/cm/cntnts/cntntsView.do?mi=74&cntntsId=1755';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
