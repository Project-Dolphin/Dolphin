import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/pages/dailyMenu/dailyMenu_data.dart';
import 'package:http/http.dart' as http;
import 'dailyMenu_contents.dart';
import 'dailyMenu_page.dart';

class MealCard extends StatefulWidget {
  MealCard({
    required this.type,
    required this.time,
  });

  final int type;
  final List time;

  @override
  _MealCard createState() => _MealCard();
}

class _MealCard extends State<MealCard> {
  var mealTime = time;

  List<dynamic> menu = [];

  List<String>mealMenu1 = List.filled(8, "", growable: false);
  List<String>mealMenu2 = List.filled(8, "", growable: false);
  List<String>mealMenu3 = List.filled(8, "", growable: false);

  void mealParse() async {
    var response = await http.get(Uri.parse(
        'https://pxfpulri8j.execute-api.ap-northeast-2.amazonaws.com/dev/diet/society/today'));
    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    final responseJson = json.decode(utf8.decode(response.bodyBytes));

    List<dynamic> list = MenuData.fromJson(responseJson) as List;
    print(list);
    print(list[0]['type']);
    print(list[0]['value']);

    //runApp(MyApp());
  }

  @override
  Widget build(BuildContext context) {
    mealMenu1[0] = "식단이 없어요";
    mealMenu2[0] = "식단이 없어요";
    mealMenu3[0] = "식단이 없어요";
    return GlassMorphism(
      width: SizeConfig.screenWidth - SizeConfig.sizeByWidth(20.0),
      height: (SizeConfig.screenHeight * 0.8),
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