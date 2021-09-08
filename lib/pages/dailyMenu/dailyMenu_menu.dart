import 'package:flutter/cupertino.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/pages/dailyMenu/dailyMenu_controller.dart';
import 'dailyMenu_contents.dart';

class MealCard extends StatelessWidget {
  MealCard({
    required this.menu,
    required this.type,
    required this.name,
    required this.time,
  });

  List<MealData>? menu;

  final int type;
  final List name;
  final List time;

  var menu1, menu2, menu3;

  @override
  Widget build(BuildContext context) {
    List<String> emptyMenuText = ["식단이 없어요"];
    var idx = menu!.length == 7 ? 0 : 3;

    switch (type) {
      //2층, 3층, 5층의 경우 추후 학생 생활관 데이터 추가로 인덱스가 3이 밀릴 것을 대비해 idx 변수 선언하였음
      case 0:
        {
          menu1 = idx == 0 ? MealData() : menu![0];
          menu2 = idx == 0 ? MealData() : menu![1];
          menu3 = idx == 0 ? MealData() : menu![2];
          break;
        }
      case 2:
        {
          menu1 = menu![5 + idx];
          menu2 = menu![6 + idx];
          menu3 = menu![0];

          break;
        }
      case 3:
        {
          menu1 = menu![0];
          menu2 = menu![0];
          menu3 = menu![0];
          break;
        }
      case 4:
        {
          menu1 = menu![0];
          menu2 = menu![0];
          menu3 = menu![0];

          break;
        }
      default:
        {
          break;
        }
    }

    menu1!.type == 99 ? menu1!.value = emptyMenuText : menu1 = menu1;

    return GlassMorphism(
        width: SizeConfig.screenWidth - SizeConfig.sizeByWidth(20.0),
        height: SizeConfig.sizeByHeight(calcHeight(menu1!, menu2!, menu3!)),
        widget: Container(
            margin: EdgeInsets.all(
              SizeConfig.sizeByWidth(12.0),
            ),
            child: Column(
              children: [
                menu1 != null
                    ? Padding(
                        padding: EdgeInsets.only(
                          bottom: SizeConfig.sizeByHeight(42.0),
                        ),
                        child: MealContentColumn(
                          mealName: name[0],
                          mealTime: time[0],
                          mealMenu: menu1!.value,
                          imageName: "cutlery_orange.png",
                        ),
                      )
                    : Container(),
                menu2 != null
                    ? Padding(
                        padding: EdgeInsets.only(
                          bottom: SizeConfig.sizeByHeight(42.0),
                        ),
                        child: MealContentColumn(
                          mealName: name[1],
                          mealTime: time[1],
                          mealMenu: menu2!.value,
                          imageName: "cutlery_red.png",
                        ),
                      )
                    : Container(),
                menu3 != null && type != 2
                    ? Padding(
                        padding: EdgeInsets.only(
                          bottom: SizeConfig.sizeByHeight(42.0),
                        ),
                        child: MealContentColumn(
                          mealName: name[2],
                          mealTime: time[2],
                          mealMenu: menu3!.value,
                          imageName: "cutlery_purple.png",
                        ),
                      )
                    : Container()
              ],
            )));
  }

  double calcHeight(MealData menu1, MealData menu2, MealData menu3) {
    var len1 = menu1.value!.length > 5 ? 5 : menu1.value!.length;
    var len2 = menu2.value!.length > 5 ? 5 : menu2.value!.length;
    var len3 = menu3.value!.length > 5 ? 5 : menu3.value!.length;

    if ((len1 + len2 + len3) * 30.0 + 140 < 650)
      return 650.0;
    else
      return (len1 + len2 + len3) * 30.0 + 140;
  }
}
