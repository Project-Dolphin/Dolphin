import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/loading/loading.dart';
import 'package:oceanview/common/titlebox/twolineTitle.dart';
import 'package:oceanview/pages/dailyMenu/dailyMenu_controller.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/titlebox/onelineTitle.dart' as oneLine;
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

  final name = '식단', subname = '0층 식단', more = '이번주 식단 보기';

  @override
  Widget build(BuildContext context) {
    final List pageList = [
      MealCard(
          menu: controller.navyData![0],
          menu2: controller.navyData![0],
          menu3: controller.navyData![0],
          type: 0,
          time: time,
          name: timeName1),
      SnackCard(
          type: 1,
          time: timeCafeteria,
          name: timeName2,
          data: controller.societyData),
      MealCard(
          menu: controller.societyData![5],
          menu2: controller.societyData![6],
          type: 2,
          time: timeEmployer,
          name: timeName3),
      MealCard(
          menu: controller.societyData![5],
          menu2: controller.societyData![6],
          type: 3,
          time: timeDorm,
          name: timeName2),
      MealCard(
          menu: controller.navyData![0],
          menu2: controller.navyData![0],
          menu3: controller.navyData![0],
          type: 4,
          time: timeMariDorm,
          name: timeName2),
    ];
    return GetBuilder<DailyMenuController>(builder: (_) {
      return controller.isLoading
          ? Loading()
          : Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Container(
                width: SizeConfig.blockSizeHorizontal * 90,
                height: SizeConfig.sizeByHeight(46),
                margin:
                    EdgeInsets.symmetric(vertical: SizeConfig.sizeByHeight(20)),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(SizeConfig.sizeByHeight(46)),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: pageList.asMap().entries.map(
                    (entry) {
                      return GestureDetector(
                        onTap: () {
                          controller.setSubTab(entry.key);
                          controller.carouselController.jumpToPage(entry.key);
                        },
                        child: Container(
                          width: (SizeConfig.blockSizeHorizontal * 90) /
                              pageList.length,
                          decoration: BoxDecoration(
                              // color:
                              //     (Theme.of(context).brightness == Brightness.dark
                              //             ? Colors.white
                              //             : Colors.blue)
                              //         .withOpacity(_current == entry.key ? 0.8 : 0),
                              gradient: controller.current == entry.key
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
                              boxShadow: controller.current == entry.key
                                  ? [
                                      BoxShadow(
                                          color: Color(0xFFB4D5F1),
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                          spreadRadius: 2)
                                    ]
                                  : null,
                              borderRadius: BorderRadius.circular(
                                  controller.current == entry.key
                                      ? SizeConfig.sizeByHeight(46)
                                      : 0)),
                          child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  titleList[entry.key],
                                  style: TextStyle(
                                      color: controller.current == entry.key
                                          ? Colors.white
                                          : Color(0xFF919191),
                                      fontSize: SizeConfig.sizeByWidth(16),
                                      fontWeight: FontWeight.w700),
                                )),
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
                                    subname: subtitleList[controller.current],
                                    stat: controller.stat,
                                    more: more,
                                    fontsize2: 18,
                                    fontsize3: 12,
                                    fontsize4: 14,
                                    fontweight2: FontWeight.w500,
                                    fontweight3: FontWeight.w400,
                                    url: menuSites[controller.current],
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
                      items: pageList
                          .map((item) => Container(
                                margin: EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    SizeConfig.sizeByWidth(15),
                                    SizeConfig.sizeByHeight(60)),
                                child: Column(
                                  children: [item],
                                ),
                              ))
                          .toList(),
                      carouselController: controller.carouselController,
                      options: CarouselOptions(
                        autoPlay: false,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: false,
                        height: SizeConfig.blockSizeVertical * 100,
                        onPageChanged: (index, reason) {
                          controller.setSubTab(index);
                        },
                        // onScrolled: (value) {
                        //   controller.setSubTab(value!.toInt());
                        // },
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
