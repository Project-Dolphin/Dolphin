import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/titlebox/twolineTitle.dart';
import 'package:oceanview/pages/dailyMenu/dailyMenu_controller.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/titlebox/onelineTitle.dart' as oneLine;
import 'package:oceanview/pages/dailyMenu/dailyMenu_repository.dart';
import 'package:oceanview/pages/dailyMenu/widgets/dailyMenu_header.dart';

import 'dailyMenu_menu.dart';
import 'dailyMenu_menu_snack.dart';
import 'infoMenu/menu_information.dart';

class DailyMenuPage extends GetView<DailyMenuController> {
  final List<String> titleList = ['2층', '3층', '5층', '생활관', '승생'];
  final List<String> subtitleList = [
    '2층 학생식당',
    '3층 스낵코너',
    '교직원식당',
    '학생생활관',
    '승선생활관'
  ];

  Future<void> init() async {
    await DailyMenuRepository().getSociety();
    await DailyMenuRepository().getNavy();
  }

  final controller = Get.put(DailyMenuController());

  late final List testPageList = [
    MealCard(
        menu: controller.navyData![0].value,
        menu2: controller.navyData![0].value,
        menu3: controller.navyData![0].value,
        type: 0,
        time: time,
        name: timeName1),
    SnackCard(
        type: 1,
        time: timeCafeteria,
        name: timeName2,
        data: controller.societyData),
    MealCard(
        menu: controller.societyData![5].value,
        menu2: controller.societyData![6].value,
        type: 2,
        time: timeEmployer,
        name: timeName3),
    MealCard(
        menu: controller.societyData![5].value,
        menu2: controller.societyData![6].value,
        type: 3,
        time: timeDorm,
        name: timeName2),
    MealCard(
        menu: controller.navyData![0].value,
        menu2: controller.navyData![0].value,
        menu3: controller.navyData![0].value,
        type: 4,
        time: timeMariDorm,
        name: timeName2),
  ];

  final name = '식단', subname = '0층 식단', more = '이번주 식단 보기';
  var _stat = '운영중';
  int _current = 0;
  final CarouselController _controller = CarouselController();

  var studentStat = statStudent1 || statStudent2;
  var cafeteriaStat = statCafeteria1 || statCafeteria2 || statCafeteria3;
  var employerStat = statEmployer1;
  var dormStat = statDorm1 || statDorm2 || statDorm3;
  var dormWeekendStat = statWeekend1 || statWeekend2 || statWeekend3;

  // if (DateTime.now().weekday == (6 | 7)) {
  //     switch (_current) {
  //       case 0:
  //         {
  //           _stat = "운영종료";
  //           return null;
  //         }
  //       case 1:
  //         {
  //           _stat = "운영종료";
  //           return null;
  //         }
  //       case 2:
  //         {
  //           _stat = "운영종료";
  //           return null;
  //         }
  //       case 3:
  //         {
  //           dormWeekendStat == true ? _stat = "운영중" : _stat = "운영종료";
  //           return null;
  //         }
  //       case 4:
  //         {
  //           _stat = "운영종료";
  //           return null;
  //         }
  //       default:
  //         {
  //           return null;
  //         }
  //     }
  //   } else {
  //     switch (_current) {
  //       case 0:
  //         {
  //           studentStat == true ? _stat = "운영중" : _stat = "운영종료";
  //           return null;
  //         }
  //       case 1:
  //         {
  //           cafeteriaStat == true ? _stat = "운영중" : _stat = "운영종료";
  //           return null;
  //         }
  //       case 2:
  //         {
  //           employerStat == true ? _stat = "운영중" : _stat = "운영종료";
  //           return null;
  //         }
  //       case 3:
  //         {
  //           dormStat == true ? _stat = "운영중" : _stat = "운영종료";
  //           return null;
  //         }
  //       case 4:
  //         {
  //           _stat = "운영종료";
  //           return null;
  //         }
  //       default:
  //         {
  //           return null;
  //         }
  //     }
  //   }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: SizeConfig.blockSizeHorizontal * 90,
        height: SizeConfig.sizeByHeight(46),
        margin: EdgeInsets.symmetric(vertical: SizeConfig.sizeByHeight(20)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConfig.sizeByHeight(46)),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: testPageList.asMap().entries.map(
            (entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: (SizeConfig.blockSizeHorizontal * 90) /
                      testPageList.length,
                  decoration: BoxDecoration(
                      gradient: _current == entry.key
                          ? LinearGradient(
                              colors: <Color>[
                                Color(0xFF3199FF),
                                Color(0xFF0081FF),
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp)
                          : null,
                      boxShadow: _current == entry.key
                          ? [
                              BoxShadow(
                                  color: Color(0xFFB4D5F1),
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                  spreadRadius: 2)
                            ]
                          : null,
                      borderRadius: BorderRadius.circular(_current == entry.key
                          ? SizeConfig.sizeByHeight(46)
                          : 0)),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        titleList[entry.key],
                        style: TextStyle(
                            color: _current == entry.key
                                ? Colors.white
                                : Color(0xFF919191),
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: false,
            snap: false,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.white.withOpacity(0),
            iconTheme: IconThemeData(color: Color(0xFF3199FF)),
            centerTitle: false,
            expandedHeight: SizeConfig.sizeByHeight(90),
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.sizeByHeight(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                              top: SizeConfig.sizeByHeight(14),
                            ),
                            child: oneLine.MainTitle(
                              title: '식단',
                              fontsize: SizeConfig.sizeByHeight(26),
                              fontweight: FontWeight.w700,
                              isGradient: false,
                            )),
                        Container(
                          child: BottomTitle(
                            subname: subtitleList[_current],
                            stat: _stat,
                            more: more,
                            fontsize2: 18,
                            fontsize3: 12,
                            fontsize4: 14,
                            fontweight2: FontWeight.w500,
                            fontweight3: FontWeight.w400,
                            url: menuSites[_current],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                title: MyAppSpace()),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: CarouselSlider(
              items: testPageList
                  .map((item) => Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 15, 60),
                        child: Column(
                          children: [item],
                        ),
                      ))
                  .toList(),
              carouselController: _controller,
              options: CarouselOptions(
                autoPlay: false,
                enableInfiniteScroll: false,
                enlargeCenterPage: false,
                height: SizeConfig.blockSizeVertical * 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
