import 'package:flutter/cupertino.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'dailyMenu_contents.dart';
import 'dailyMenu_page.dart';

class MealCard extends StatefulWidget {
  @override
  _MealCard createState() => _MealCard();
}

class _MealCard extends State<MealCard> {
  List mealTime = time;

  List mealMenu1=[8];
  var mealMenu2 = [
    "dkahffk",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  var mealMenu3 = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      width: SizeConfig.screenWidth - SizeConfig.sizeByWidth(20.0),
      height: (SizeConfig.screenHeight)*0.7,
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
                mealMenu: mealMenu1,
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
                mealMenu: mealMenu2,
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
                mealMenu: mealMenu3,
                imageName: "cutlery_purple.png",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuData {
}