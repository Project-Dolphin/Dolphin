import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/pages/dailyMenu/dailyMenu_controller.dart';
import '../../common/titlebox/twolineTitle.dart';
import 'package:oceanview/common/carousel/carousel.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/container/glassMorphism.dart';

var time = ["11:30 ~ 13:30", "17:00 ~ 18:30", ""];

class DailyMenuPage extends GetView<DailyMenuController> {
  final List<String> titleList = ['2층', '3층', '5층', '생활관', '승생'];
  final List<dynamic> testPageList = [
    MealCard(),
    MealCard(),
    MealCard(),
    MealCard(),
    MealCard(),
  ];
  final name = '식단', subname = '0층 식단', stat = '운영중', more = '이번주 식단 보기';
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                top: SizeConfig.sizeByWidth(65),
              ),
              child: BottomTitle(
                subname: titleList[index] + " 식단",
                stat: stat,
                more: more,
                fontsize2: 20.0,
                fontsize3: 12.0,
                fontweight2: FontWeight.w500,
                fontweight3: FontWeight.w400,
              ),
            ),
          ),
        ),
        SliverFillRemaining(
          child:
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.sizeByHeight(10)),
                child: Carousel(pageList: testPageList, titleList: titleList, bar: true),
              ),
        ),
      ],
    );
  }
}

class MealCard extends StatefulWidget {
  @override
  _MealCard createState() => _MealCard();
}

class _MealCard extends State<MealCard> {
  List mealTime = time;
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

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      width: SizeConfig.sizeByWidth(310),
      height: SizeConfig.screenHeight,
      widget: Container(
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
                imageName: "cutlery_orange.png",
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
                imageName: "cutlery_red.png",
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
                imageName: "cutlery_purple.png",
              ),
            ),
          ],
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
    @required this.imageName,
  }) : super(key: key);

  final mealName;
  final mealTime;
  final mealMenu;
  final imageName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Image(
                  width: SizeConfig.sizeByHeight(30.0),
                  image: AssetImage('assets/images/mealPage/' + imageName),
                ),
                Text(
                  mealName,
                  style: TextStyle(
                    fontSize: SizeConfig.sizeByHeight(16.0),
                  ),
                ),
              ],
            ),
            Text(
              mealTime,
              style: TextStyle(
                fontSize: SizeConfig.sizeByHeight(12.0),
              ),
            ),
          ],
        ),
        Divider(
          color: Color(0xffE0E0E0),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: SizeConfig.sizeByWidth(7.0),
              ),
              child: Row(
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
                    width: SizeConfig.sizeByWidth(118.0),
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
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: SizeConfig.sizeByWidth(7.0),
              ),
              child: Row(
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
                    width: SizeConfig.sizeByWidth(118.0),
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
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: SizeConfig.sizeByWidth(7.0),
              ),
              child: Row(
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
                    width: SizeConfig.sizeByWidth(118.0),
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
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: SizeConfig.sizeByWidth(7.0),
              ),
              child: Row(
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
                    width: SizeConfig.sizeByWidth(118.0),
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
            ),
          ],
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  final double maxHeight;
  final double minHeight;

  const Header({Key? key, required this.maxHeight, required this.minHeight}) : super(key: key);

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final expandRatio = _calculateExpandRatio(constraints);
        final animation = AlwaysStoppedAnimation(expandRatio);

        return
          Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: Tween(begin: 10.0, end:0.0).evaluate(animation),
                    sigmaY: Tween(begin: 10.0, end:0.0).evaluate(animation),
                  ),
                  child: Container(
                    color: Colors.transparent, //test
                    alignment: Alignment.center,
                    width: SizeConfig.screenWidth,
                    height: 50,
                  ),
                ),
              ), // to clip the container
            ),
            _buildTitle(animation),
          ],
        );
      },
    );
  }

  double _calculateExpandRatio(BoxConstraints constraints) {
    var expandRatio =
        (constraints.maxHeight - minHeight) / (maxHeight - minHeight);

    if (expandRatio > 1.0) expandRatio = 1.0;
    if (expandRatio < 0.0) expandRatio = 0.0;

    return expandRatio;
  }

  Align _buildTitle(Animation<double> animation) {
    return Align(
      alignment: AlignmentTween(
              begin: Alignment.center, end: Alignment.bottomLeft)
          .evaluate(animation),
      child: Container(
        margin: EdgeInsets.only(bottom: 14, left: 14,),
        child: Text(
          "식단",
          style: TextStyle(
            fontSize: Tween<double>(begin: 18, end: 26).evaluate(animation),
            color: Color(0xFF3F3F3F),
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
