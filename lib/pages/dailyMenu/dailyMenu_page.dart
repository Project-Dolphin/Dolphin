import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/loading/loading.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/common/titlebox/twolineTitle.dart';
import 'package:oceanview/pages/dailyMenu/dailyMenu_controller.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/titlebox/onelineTitle.dart' as oneLine;
import 'package:oceanview/pages/dailyMenu/widgets/dailyMenu_header.dart';
import 'package:oceanview/services/urlUtils.dart';

import 'widgets/dailyMenu_menu.dart';
import 'widgets/dailyMenu_menu_snack.dart';
import 'infoMenu/menu_information.dart';

class DailyMenupage extends StatefulWidget {
  const DailyMenupage({Key? key}) : super(key: key);

  @override
  _DailyMenupageState createState() => _DailyMenupageState();
}

class _DailyMenupageState extends State<DailyMenupage> {
  final List<String> titleList = ['2층', '3층', '5층', '생활관', '승생'];
  final List<String> subtitleList = [
    '2층 학생식당',
    '3층 스낵코너',
    '교직원식당',
    '학생생활관',
    '승선생활관'
  ];

  final name = '식단', subname = '0층 식단', more = '이번주 식단 보기';
  final CarouselController carouselController = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DailyMenuController>(builder: (_) {
      final List<Widget> pageList = [
        MealCard(
            menu: _.societyData, type: 'floor2', time: time, name: timeName1),
        SnackCard(
            type: 1, time: timeCafeteria, name: timeName2, data: _.societyData),
        MealCard(
            menu: _.societyData,
            type: 'staff',
            time: timeEmployer,
            name: timeName3),
        MealCard(
            menu: _.dormData, type: 'dorm', time: timeDorm, name: timeName2),
        InkWell(
          onTap: () => UrlUtils.launchURL(menuSites[4]),
          child: GlassMorphism(
            width: SizeConfig.screenWidth - SizeConfig.sizeByWidth(20.0),
            height: SizeConfig.sizeByHeight(100),
            widget:
                TextBox('여기를 눌러주세요', 16, FontWeight.w700, Color(0xff353b45)),
          ),
        ),
      ];
      return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          width: SizeConfig.blockSizeHorizontal * 90,
          height: SizeConfig.sizeByHeight(46),
          margin: EdgeInsets.only(bottom: SizeConfig.sizeByWidth(20)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeConfig.sizeByHeight(46)),
              color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: pageList.asMap().entries.map(
              (entry) {
                return GestureDetector(
                  onTap: () => carouselController.animateToPage(entry.key),
                  child: Container(
                    width:
                        (SizeConfig.blockSizeHorizontal * 90) / pageList.length,
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
                        borderRadius: BorderRadius.circular(
                            _current == entry.key
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
                                    : Color(0xFFb7b7b7),
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
              expandedHeight: SizeConfig.blockSizeVertical > 7
                  ? SizeConfig.sizeByHeight(95)
                  : SizeConfig.sizeByHeight(110),
              //bottom - flexibleSpace 내부 onTap 안되는 이슈 해결을 위해 가상의 투명 버튼 겹침
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: _.isMoreButtonVisible
                      ? Container(
                          padding: EdgeInsets.only(
                              right: SizeConfig.sizeByHeight(20),
                              bottom: SizeConfig.blockSizeVertical > 7
                                  ? SizeConfig.sizeByHeight(7)
                                  : SizeConfig.sizeByHeight(5)),
                          width: SizeConfig.safeBlockHorizontal * 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Opacity(
                                opacity: 0,
                                child: MoreText(
                                    description: more,
                                    urlName: menuSites[_current]),
                              ),
                            ],
                          ),
                        )
                      : Container()),
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.sizeByHeight(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                          BottomTitle(
                            subname: subtitleList[_current],
                            stat: _.stat,
                            more: more,
                            fontsize2: 18,
                            fontsize3: 12,
                            fontsize4: 14,
                            fontweight2: FontWeight.w500,
                            fontweight3: FontWeight.w400,
                            url: menuSites[_current],
                          ),
                        ],
                      ),
                    ),
                  ),
                  titlePadding: EdgeInsets.zero,
                  title: MyAppSpace(_)),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: _.isLoading
                  ? Loading()
                  : CarouselSlider(
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
                      carouselController: carouselController,
                      options: CarouselOptions(
                        autoPlay: false,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: false,
                        height: SizeConfig.screenHeight * 1.1,
                        onPageChanged: (index, reason) {
                          _.setStat(index);
                          setState(
                            () {
                              _current = index;
                            },
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      );
    });
  }
}
