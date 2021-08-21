import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/titlebox/twolineTitle.dart';
import 'package:oceanview/pages/dailyMenu/dailyMenu_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'dailyMenu_contents.dart';
import 'dailyMenu_header.dart';
import 'dailyMenu_menu.dart';

var time = ["11:30 ~ 13:30", "17:00 ~ 18:30", ""];
var timeCafeteria = ["08:00 ~ 09:30", "09:30 ~ 15:00", "16:00 ~ 18:30"];
var timeEmployer = ["", "11:30 ~ 13:30", ""];
var timeDorm = ["08:00 ~ 09:00", "11:40 ~ 13:30", "17:00 ~ 18:30"];
var timeDormWeekend = ["08:00 ~ 09:00", "12:00 ~ 13:00", "17:00 ~ 18:00"];
var timeMariDorm = ["", "", ""];

int _current = 0;
final CarouselController _controller = CarouselController();
final List<String> titleList = ['2층', '3층', '5층', '생활관', '승생'];
final List<dynamic> testPageList = [
  MealCard(type: 0, time: time),
  MealCard(type: 1, time: time),
  MealCard(type: 2, time: time),
  MealCard(type: 3, time: time),
  MealCard(type: 4, time: time),
];

class DailyMenuPage extends GetView<DailyMenuController> {
  final name = '식단', subname = '0층 식단', stat = '운영종료', more = '이번주 식단 보기';
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: <Widget>[
            new SliverAppBar(
              backgroundColor: Colors.transparent,
              forceElevated: true,
              floating: true,
              elevation: 0.0,
              pinned: true,
              expandedHeight: 110.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Header(
                  maxHeight: 90,
                  minHeight: 60,
                ),
                background: Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.sizeByWidth(22),
                    right: SizeConfig.sizeByWidth(25),
                    top: SizeConfig.sizeByHeight(25),
                  ),
                  child: BottomTitle(
                    subname: titleList[index] + " 식단",
                    stat: stat,
                    more: more,
                    fontsize2: SizeConfig.sizeByHeight(18),
                    fontsize3: SizeConfig.sizeByHeight(12),
                    fontweight2: FontWeight.w500,
                    fontweight3: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: MenuCarousel(),
            ),
          ],
        ),
        MenuCarouselController(),
      ],
    );
  }
}

class MenuCarouselController extends StatefulWidget {
  @override
  _MenuStateButton createState() => _MenuStateButton();
}

class _MenuStateButton extends State<MenuCarouselController> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 90,
        height: SizeConfig.sizeByHeight(46),
        margin: EdgeInsets.all(SizeConfig.sizeByWidth(20)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                SizeConfig.sizeByHeight(46)),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: testPageList.asMap().entries.map(
                (entry) {
              return GestureDetector(
                onTap: () =>
                    _controller.animateToPage(entry.key),
                child: Container(
                  width: (SizeConfig.blockSizeHorizontal *
                      90) /
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
                                  : Color(0xFF919191),
                              fontSize:
                              SizeConfig.sizeByWidth(
                                  16),
                              fontWeight: FontWeight.w700),
                        )),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }

}

class MenuCarousel extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<MenuCarousel> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.transparent,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
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
                  onPageChanged: (index, reason) {
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
      ),
    );
  }
}
