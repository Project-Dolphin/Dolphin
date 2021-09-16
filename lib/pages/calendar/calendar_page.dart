import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/loading/loading.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/common/titlebox/onelineTitle.dart' as oneLine;
import 'package:oceanview/pages/calendar/Calendar_repository.dart';
import 'package:oceanview/common/titlebox/iconSet.dart';
import 'package:oceanview/pages/calendar/calendar_widget.dart';
import 'package:oceanview/pages/calendar/calendar_controller.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarPage extends GetView<CalendarController> {
  final name = '학사일정';

  @override
  Widget build(BuildContext context) {
    if (controller.calendarData!.length < 2) {
      () async {
        await CalendarReposiory().getCalendarEvent();
        controller.setCalendarList();
      }();
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GetBuilder<CalendarController>(
            init: CalendarController(),
            builder: (_) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.sizeByHeight(20),
                          vertical: SizeConfig.sizeByHeight(14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            oneLine.MainTitle(
                              title: name,
                              fontsize: SizeConfig.sizeByHeight(26),
                              fontweight: FontWeight.w700,
                              isGradient: false,
                            ),
                            CalendarIcon(),
                          ],
                        ),
                      ),
                      _.isLoading
                          ? Container(
                              height: SizeConfig.sizeByHeight(600),
                              child: Loading())
                          : Container(
                              child: CarouselSlider(
                                  carouselController: _.carouselController,
                                  options: CarouselOptions(
                                    height: SizeConfig.sizeByHeight(600),
                                    autoPlay: false,
                                    enableInfiniteScroll: false,
                                    enlargeCenterPage: false,
                                    initialPage: DateTime.now().month - 2,
                                    aspectRatio: 2.0,
                                    onPageChanged: (index, reason) {},
                                  ),
                                  items: _.calendarList)),
                    ],
                  ),
                  Positioned(
                      bottom: SizeConfig.sizeByHeight(35),
                      right: SizeConfig.sizeByWidth(29),
                      child: ElevatedButton(
                          onPressed: () {
                            _launchURL();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding:
                                EdgeInsets.all(SizeConfig.sizeByHeight(8.5)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextBox('전체일정 보기', 12, FontWeight.w500,
                                  Color(0xFF353B45)),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: SizeConfig.sizeByHeight(12),
                                color: Color(0xFF353B45),
                              )
                            ],
                          ))),
                ],
              );
            }),
      ),
    );
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
