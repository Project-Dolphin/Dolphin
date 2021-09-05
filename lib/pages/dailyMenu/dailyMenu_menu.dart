import 'package:flutter/cupertino.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/pages/dailyMenu/infoMenu/menu_information.dart';
import 'dailyMenu_contents.dart';

class MealCard extends StatelessWidget {
  MealCard({
    required this.menu1,
    required this.menu2,
    required this.menu3,
    required this.type,
    required this.name,
    required this.time,
  });

  List menu1, menu2, menu3;
  final int type;
  final List name;
  final List time;

  @override
  Widget build(BuildContext context) {
    var emptyMenuText = List.filled(8, "", growable: true);
    emptyMenuText[0] = "식단이 없어요";
    menu1.isEmpty ? menu1 = emptyMenuText : menu1 = menu1;
    menu2.isEmpty ? menu2 = emptyMenuText : menu2 = menu2;
    menu3.isEmpty ? menu3 = emptyMenuText : menu3 = menu3;
    //메뉴갯수 리턴 받아서 minHeight와 비교 후 최소 높이 리턴 받아야함
    return GlassMorphism(
      width: SizeConfig.screenWidth - SizeConfig.sizeByWidth(20.0),
      //height: (SizeConfig.screenHeight*0.9),
      height: (SizeConfig.screenHeight * 0.7),

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
                mealName: name[0],
                mealTime: time[0],
                mealMenu: menu1,
                imageName: "cutlery_orange.png",
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: SizeConfig.sizeByWidth(29.0),
              ),
              child: MealContentColumn(
                mealName: name[1],
                mealTime: time[1],
                mealMenu: menu2,
                imageName: "cutlery_red.png",
              ),
            ),
            name[2] != ""
                ? Padding(
                    padding: EdgeInsets.only(
                      bottom: SizeConfig.sizeByWidth(29.0),
                    ),
                    child: MealContentColumn(
                      mealName: name[2],
                      mealTime: time[2],
                      mealMenu: menu3,
                      imageName: "cutlery_purple.png",
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
