import 'package:flutter/cupertino.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/pages/dailyMenu/infoMenu/menu_information.dart';
import 'dailyMenu_contents.dart';

class MealCard extends StatelessWidget {
  MealCard({
    required this.menu,
    required this.type,
    required this.name,
    required this.time,
    this.menu2,
    this.menu3,
  });

  List<String>? menu;
  List<String>? menu2;
  List<String>? menu3;

  final int type;
  final List name;
  final List time;

  @override
  Widget build(BuildContext context) {
    var emptyMenuText = List.filled(8, "", growable: true);
    emptyMenuText[0] = "식단이 없어요";
    menu!.length == 0 ? menu = emptyMenuText : menu = menu;
    return GlassMorphism(
        width: SizeConfig.screenWidth - SizeConfig.sizeByWidth(20.0),
        height: (SizeConfig.screenHeight * 0.9),
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
                    mealMenu: menu,
                    imageName: "cutlery_orange.png",
                  ),
                ),
                menu2 != null
                    ? Padding(
                        padding: EdgeInsets.only(
                          bottom: SizeConfig.sizeByWidth(29.0),
                        ),
                        child: MealContentColumn(
                          mealName: name[1],
                          mealTime: time[1],
                          mealMenu: menu2,
                          imageName: "cutlery_red.png",
                        ),
                      )
                    : Container(),
                menu3 != null
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
                    : Container()
              ],
            )));
  }
}
