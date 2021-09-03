import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/pages/dailyMenu/infoMenu/menu_information.dart';
import 'package:http/http.dart' as http;

class Data {
  int type;
  String value;

  Data(this.type, this.value);

  factory Data.fromJson(dynamic json) {
    return Data(json['type'] as int, json['value'] as String);
  }

  @override
  String toString() {
    return '{${this.type}, ${this.value}}';
  }
}

class SnackCard extends StatelessWidget {
  var americanMenu = [];
  var breakfastMenu = [];
  var bunsikMenu = [];
  var ramenMenu = [];
  var riceMenu = [];

  var _text = "Http Example";
  List<Data> _datas = [];

  Future<void> mealParse() async {
  try {
  final response = await http.get(Uri.parse(
  "https://pxfpulri8j.execute-api.ap-northeast-2.amazonaws.com/dev/diet/society/today"));
  _text = utf8.decode(response.bodyBytes);
  var dataObjsJson = jsonDecode(_text)['data'] as List;
  final List<Data> parsedResponse =
  dataObjsJson.map((dataJson) => Data.fromJson(dataJson)).toList();
  _datas.clear();
  _datas.addAll(parsedResponse);

  americanMenu = (_datas[0].value + "\n").split("\n");
  menuFill(americanMenu, 2);
  breakfastMenu = (_datas[1].value + "\n").split("\n");
  menuFill(breakfastMenu, 2);
  ramenMenu = (_datas[2].value + "\n").split("\n");
  menuFill(ramenMenu, 2);
  bunsikMenu = (_datas[3].value + "\n").split("\n");
  menuFill(bunsikMenu, 2);
  riceMenu = (_datas[4].value + "\n").split("\n");
  menuFill(riceMenu, 2);
  }
  catch (err) {
  throw Exception("Failed to load data");
  }
  }

  void menuFill(List listItem, int size) {
  while (listItem.length < size) {
  listItem.add("");
  }
  }

  var type, name, time;

  SnackCard({
    required this.type,
    required this.name,
    required this.time,
  });

  var menu1, menu2, menu3, menu4, menu5;

  @override
  Widget build(BuildContext context) {
    menu1 = breakfastMenu;
    menu2 = americanMenu;
    menu3 = ramenMenu;
    menu4 = bunsikMenu;
    menu5 = riceMenu;
    var emptyMenuText = List.filled(2, "", growable: true);
    emptyMenuText[0] = "식단이 없어요";
    menu1.isEmpty ? menu1 = emptyMenuText : menu1 = menu1;
    menu2.isEmpty ? menu2 = emptyMenuText : menu2 = menu2;
    menu3.isEmpty ? menu3 = emptyMenuText : menu3 = menu3;
    menu4.isEmpty ? menu4 = emptyMenuText : menu4 = menu4;
    menu5.isEmpty ? menu5 = emptyMenuText : menu5 = menu5;
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image(
                            width: SizeConfig.sizeByHeight(30.0),
                            image: AssetImage(
                                'assets/images/mealPage/cutlery_orange.png'),
                          ),
                          Text(
                            '천원의 아침',
                            style: TextStyle(
                              fontSize: SizeConfig.sizeByHeight(16.0),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        timeCafeteria[0].toString(),
                        style: TextStyle(
                          fontSize: SizeConfig.sizeByHeight(12.0),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom:SizeConfig.sizeByHeight(5.0),),
                    child: Image(
                      height: SizeConfig.blockSizeHorizontal,
                      image:
                      AssetImage('assets/images/mealPage/divider.png'),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: SizeConfig.sizeByHeight(7.0),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: SizeConfig.sizeByWidth(180.0),
                              child: Text(
                                menu1[0],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Container(
                              width: SizeConfig.sizeByWidth(180.0),
                              child: Text(
                                menu1[1],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
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
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: SizeConfig.sizeByHeight(29.0),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image(
                            width: SizeConfig.sizeByHeight(30.0),
                            image: AssetImage(
                              'assets/images/mealPage/cutlery_red.png',
                            ),
                          ),
                          Text(
                            '스낵코너',
                            style: TextStyle(
                              fontSize: SizeConfig.sizeByHeight(16.0),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            timeCafeteria[1].toString(),
                            style: TextStyle(
                              fontSize: SizeConfig.sizeByHeight(12.0),
                            ),
                          ),
                          Text(
                            timeCafeteria[2].toString(),
                            style: TextStyle(
                              fontSize: SizeConfig.sizeByHeight(12.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom:SizeConfig.sizeByHeight(5.0),),
                    child: Image(
                      height: SizeConfig.blockSizeHorizontal,
                      image:
                      AssetImage('assets/images/mealPage/divider.png'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                            child: RichText(
                              text: TextSpan(
                                text: '| ',
                                style: TextStyle(color: Color(0xff0081FF),
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: '양식', style: TextStyle(fontSize: SizeConfig.sizeByHeight(14.0),color: Color(0xff3F3F3F),),),
                                  TextSpan(text: ' |', style: TextStyle(color: Color(0xff0081FF),)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                            width: SizeConfig.sizeByWidth(120.0),
                            child: Text(
                              menu2[0],
                              style: TextStyle(
                                fontSize: SizeConfig.sizeByHeight(15.0),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          menu2.length > 2? Container(
                            margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                            width: SizeConfig.sizeByWidth(120.0),
                            child: Text(
                              menu2[1],
                              style: TextStyle(
                                fontSize: SizeConfig.sizeByHeight(15.0),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ): Container(),
                          menu2.length > 3? Container(
                            margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                            width: SizeConfig.sizeByWidth(120.0),
                            child: Text(
                              menu2[2],
                              style: TextStyle(
                                fontSize: SizeConfig.sizeByHeight(15.0),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ): Container(),
                          menu2.length > 4? Container(
                            margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                            width: SizeConfig.sizeByWidth(120.0),
                            child: Text(
                              menu2[3],
                              style: TextStyle(
                                fontSize: SizeConfig.sizeByHeight(15.0),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ): Container(),
                          menu2.length > 5? Container(
                            margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                            width: SizeConfig.sizeByWidth(120.0),
                            child: Text(
                              menu2[4],
                              style: TextStyle(
                                fontSize: SizeConfig.sizeByHeight(15.0),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ): Container(),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                            child: RichText(
                              text: TextSpan(
                                text: '| ',
                                style: TextStyle(color: Color(0xff0081FF),
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: '라면', style: TextStyle(fontSize: SizeConfig.sizeByHeight(14.0),color: Color(0xff3F3F3F),),),
                                  TextSpan(text: ' |', style: TextStyle(color: Color(0xff0081FF),)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                            width: SizeConfig.sizeByWidth(120.0),
                            child: Text(
                              menu3[0],
                              style: TextStyle(
                                fontSize: SizeConfig.sizeByHeight(15.0),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          menu3.length > 2? Container(
                            margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                            width: SizeConfig.sizeByWidth(120.0),
                            child: Text(
                              menu3[1],
                              style: TextStyle(
                                fontSize: SizeConfig.sizeByHeight(15.0),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ): Container(),
                          menu3.length > 3? Container(
                            margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                            width: SizeConfig.sizeByWidth(120.0),
                            child: Text(
                              menu3[2],
                              style: TextStyle(
                                fontSize: SizeConfig.sizeByHeight(15.0),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ): Container(),
                          menu3.length > 4? Container(
                            margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                            width: SizeConfig.sizeByWidth(120.0),
                            child: Text(
                              menu3[3],
                              style: TextStyle(
                                fontSize: SizeConfig.sizeByHeight(15.0),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ): Container(),
                          menu3.length > 5? Container(
                            margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                            width: SizeConfig.sizeByWidth(120.0),
                            child: Text(
                              menu3[4],
                              style: TextStyle(
                                fontSize: SizeConfig.sizeByHeight(15.0),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ): Container(),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:SizeConfig.sizeByHeight(25.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                              child: RichText(
                                text: TextSpan(
                                  text: '| ',
                                  style: TextStyle(color: Color(0xff0081FF),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(text: '분식', style: TextStyle(fontSize: SizeConfig.sizeByHeight(14.0),color: Color(0xff3F3F3F),),),
                                    TextSpan(text: ' |', style: TextStyle(color: Color(0xff0081FF),)),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                              width: SizeConfig.sizeByWidth(120.0),
                              child: Text(
                                menu4[0],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            menu4.length > 2? Container(
                              margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                              width: SizeConfig.sizeByWidth(120.0),
                              child: Text(
                                menu4[1],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu4.length > 3? Container(
                              margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                              width: SizeConfig.sizeByWidth(120.0),
                              child: Text(
                                menu4[2],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu4.length > 4? Container(
                              margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                              width: SizeConfig.sizeByWidth(120.0),
                              child: Text(
                                menu4[3],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu4.length > 5? Container(
                              margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                              width: SizeConfig.sizeByWidth(120.0),
                              child: Text(
                                menu4[4],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                              child: RichText(
                                text: TextSpan(
                                  text: '| ',
                                  style: TextStyle(color: Color(0xff0081FF),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(text: '덮밥', style: TextStyle(fontSize: SizeConfig.sizeByHeight(14.0),color: Color(0xff3F3F3F),),),
                                    TextSpan(text: ' |', style: TextStyle(color: Color(0xff0081FF),)),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                              width: SizeConfig.sizeByWidth(120.0),
                              child: Text(
                                menu5[0],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            menu5.length > 2? Container(
                              margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                              width: SizeConfig.sizeByWidth(120.0),
                              child: Text(
                                menu5[1],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu5.length > 3? Container(
                              margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                              width: SizeConfig.sizeByWidth(120.0),
                              child: Text(
                                menu5[2],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu5.length > 4? Container(
                              margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                              width: SizeConfig.sizeByWidth(120.0),
                              child: Text(
                                menu5[3],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu5.length > 5? Container(
                              margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(10.0)),
                              width: SizeConfig.sizeByWidth(120.0),
                              child: Text(
                                menu5[4],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
