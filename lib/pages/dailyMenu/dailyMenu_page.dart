import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:OceanView/pages/dailyMenu/dailyMenu_controller.dart';
import '../../common/titlebox/twolineTitle.dart';
import 'package:OceanView/common/carousel/carousel.dart';
import 'package:OceanView/common/sizeConfig.dart';
import 'package:OceanView/common/container/glassMorphism.dart';

class DailyMenuPage extends GetView<DailyMenuController> {
  final List<String> titleList = ['2층', '3층', '5층', '생활관', '승생'];
  final List<dynamic> testPageList = [
    CityBus(),
    CityBus(),
    CityBus(),
    CityBus(),
    CityBus()
  ];
  final name = '식단', subname = '0층 식단', stat = '운영중', more = '이번주 식단 보기';
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TwolineTitle(
          name: name,
          subname: titleList[index] + " 식단",
          stat: stat,
          more: more,
          fontsize1: 26.0,
          fontsize2: 20.0,
          fontsize3: 12.0,
          fontweight1: FontWeight.w700,
          fontweight2: FontWeight.w500,
          fontweight3: FontWeight.w400,
        ),
        Carousel(pageList: testPageList, titleList: titleList, bar: true),
      ],
    );
  }
}

class CityBus extends StatefulWidget {
  @override
  _CityBusState createState() => _CityBusState();
}

class _CityBusState extends State<CityBus> {
  var mealTime = ["Time ~ Time", "Time ~ Time", "Time ~ Time"];
  var mealMenu = [
    "잡곡밥",
    "양배추샐러드",
    "배추김치",
    "제육볶음",
    "순대찜",
    "깍두기",
    "야쿠르트",
    "아이스크림"
  ];
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      width: SizeConfig.sizeByWidth(310),
      height: SizeConfig.sizeByHeight(500),
      widget: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(
            SizeConfig.sizeByWidth(12.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: SizeConfig.sizeByWidth(29.0),
                ),
                child: MealContentColumn(
                  mealName: "점심",
                  mealTime: mealTime[0],
                  mealMenu: mealMenu,
                  iconColor: 0xffF2994A,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: SizeConfig.sizeByWidth(29.0),
                ),
                child: MealContentColumn(
                  mealName: "저녁",
                  mealTime: mealTime[1],
                  mealMenu: mealMenu,
                  iconColor: 0xffEB5757,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: SizeConfig.sizeByWidth(29.0),
                ),
                child: MealContentColumn(
                  mealName: "일품식",
                  mealTime: mealTime[2],
                  mealMenu: mealMenu,
                  iconColor: 0xff9B51E0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MealContentColumn extends StatelessWidget {
  const MealContentColumn({
    Key? key,
    @required this.mealName,
    @required this.mealTime,
    @required this.mealMenu,
    @required this.iconColor,
  }) : super(key: key);

  final mealName;
  final mealTime;
  final mealMenu;
  final iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.food_bank_rounded,
                  color: Color(iconColor),
                  size: SizeConfig.sizeByHeight(24.0),
                ),
                Text(
                  mealName,
                  style: TextStyle(
                    fontSize: SizeConfig.sizeByHeight(24.0),
                  ),
                ),
              ],
            ),
            Text(
              mealTime,
              style: TextStyle(
                fontSize: SizeConfig.sizeByHeight(18.0),
              ),
            ),
          ],
        ),
        Divider(
          color: Color(0xffE0E0E0),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: SizeConfig.sizeByWidth(98.0),
                  child: Text(
                    mealMenu[0],
                    style: TextStyle(
                      fontSize: SizeConfig.sizeByHeight(16.0),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.sizeByWidth(98.0),
                  child: Text(
                    mealMenu[1],
                    style: TextStyle(
                      fontSize: SizeConfig.sizeByHeight(16.0),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: SizeConfig.sizeByWidth(98.0),
                  child: Text(
                    mealMenu[2],
                    style: TextStyle(
                      fontSize: SizeConfig.sizeByHeight(16.0),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.sizeByWidth(98.0),
                  child: Text(
                    mealMenu[3],
                    style: TextStyle(
                      fontSize: SizeConfig.sizeByHeight(16.0),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: SizeConfig.sizeByWidth(98.0),
                  child: Text(
                    mealMenu[4],
                    style: TextStyle(
                      fontSize: SizeConfig.sizeByHeight(16.0),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.sizeByWidth(98.0),
                  child: Text(
                    mealMenu[5],
                    style: TextStyle(
                      fontSize: SizeConfig.sizeByHeight(16.0),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: SizeConfig.sizeByWidth(98.0),
                  child: Text(
                    mealMenu[6],
                    style: TextStyle(
                      fontSize: SizeConfig.sizeByHeight(16.0),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.sizeByWidth(98.0),
                  child: Text(
                    mealMenu[7],
                    style: TextStyle(
                      fontSize: SizeConfig.sizeByHeight(16.0),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
