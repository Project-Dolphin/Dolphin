import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:OceanView/common/titlebox/twolineTitle.dart';

import 'package:table_calendar/table_calendar.dart';

import 'package:OceanView/common/container/glassMorphism.dart';

import 'package:OceanView/common/carousel/carousel.dart';
import 'package:OceanView/common/sizeConfig.dart';

import 'calendar_controller.dart';
import '../../common/titlebox/iconSet.dart';

class CalendarPage extends GetView<CalendarController> {
  var iconColor = Color(0xFF000000);
  final name = '학사일정', subname = '아치마당', stat = '일반', more = '전체일정 보기';

  final List<dynamic> testPageList = [test2()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          IconSet(
            iconColor: iconColor,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 24.0, 14.0, 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainTitle(
                      name: name,
                      fontsize1: SizeConfig.sizeByWidth(26),
                      fontweight1: FontWeight.w700,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                          child: MoreText(
                            description: more,
                            fontsize: SizeConfig.sizeByWidth(12),
                            fontweight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Text(
                      '2021',
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByWidth(22),
                      ),
                    ),
                  ),
                ),
                Carousel(pageList: testPageList, bar: false),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class test2 extends StatelessWidget {
  const test2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      width: 320,
      height: 319,
      widget: Container(
          // child: TableCalendar(
          //   locale: 'ko_KR',
          // )
          ),
    );
  }
}
