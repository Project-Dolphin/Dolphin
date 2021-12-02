import 'package:flutter/cupertino.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/pages/dailyMenu/api/dailyMenu_data.dart';

import 'dailyMenu_contents.dart';

class MealCard extends StatelessWidget {
  MealCard({
    required this.menu,
    required this.type,
    required this.name,
    required this.time,
  });

  final List<dynamic>? menu;
  final String type;
  final List name;
  final List time;

  @override
  Widget build(BuildContext context) {
    List<String> emptyMenuText = ["식단이 없어요"];
    var menu1, menu2, menu3;
    menu1 = menu2 = menu3 = MealData(value: emptyMenuText);

    switch (type) {
      case 'student':
        {
          menu?.forEach((element) {
            switch (element.type) {
              case '중식':
                menu1 = element.value![0] == '-'
                    ? MealData(value: emptyMenuText)
                    : element;
                break;
              // case '석식':
              //   menu2 = element;
              //   break;
              // case '일품식':
              //   menu3 = element;
              //   break;
              default:
                break;
            }
          });
          menu2 = menu3 = null;
          break;
        }
      case 'staff':
        {
          menu?.forEach((element) {
            switch (element.type) {
              case '중식':
                menu1 = element.value![0] == '-'
                    ? MealData(value: emptyMenuText)
                    : element;

                break;
              case '일품식':
                menu2 = element.value![0] == '-'
                    ? MealData(value: emptyMenuText)
                    : element;

                break;
              default:
                break;
            }
          });
          menu3 = null;
          break;
        }
      case 'dorm':
        {
          menu?.forEach((element) {
            switch (element.type) {
              case 'morning':
                menu1 = element.value![0] == '-'
                    ? MealData(value: emptyMenuText)
                    : element;
                break;
              case 'lunch':
                menu2 = element.value![0] == '-'
                    ? MealData(value: emptyMenuText)
                    : element;
                break;
              case 'dinner':
                menu3 = element.value![0] == '-'
                    ? MealData(value: emptyMenuText)
                    : element;
                break;
              default:
                break;
            }
          });

          break;
        }
      default:
        {
          break;
        }
    }

    return GlassMorphism(
        width: SizeConfig.screenWidth - SizeConfig.sizeByWidth(20.0),
        height: SizeConfig.screenHeight,
        widget: Container(
            margin: EdgeInsets.all(
              SizeConfig.sizeByWidth(12.0),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: SizeConfig.sizeByHeight(29),
                    ),
                    child: MealContentColumn(
                      mealName: name[0],
                      mealTime: time[0],
                      mealMenu: menu1!.value,
                      imageName: "cutlery_orange.png",
                    ),
                  ),
                ),
                menu2 != null
                    ? Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: SizeConfig.sizeByHeight(29.0),
                          ),
                          child: MealContentColumn(
                            mealName: name[1],
                            mealTime: time[1],
                            mealMenu: menu2!.value,
                            imageName: "cutlery_red.png",
                          ),
                        ),
                      )
                    : Container(),
                menu3 != null
                    ? Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: SizeConfig.sizeByHeight(29.0),
                          ),
                          child: MealContentColumn(
                            mealName: name[2],
                            mealTime: time[2],
                            mealMenu: menu3!.value,
                            imageName: "cutlery_purple.png",
                          ),
                        ),
                      )
                    : Container()
              ],
            )));
  }
}
