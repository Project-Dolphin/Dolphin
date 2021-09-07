import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/pages/dailyMenu/infoMenu/menu_information.dart';

class SnackCard extends StatelessWidget {
  final type;
  final name;
  final time;
  final dynamic data;

  SnackCard({
    required this.type,
    required this.name,
    required this.time,
    required this.data,
  });

  var menu1, menu2, menu3, menu4, menu5;

  @override
  Widget build(BuildContext context) {
    menu1 = data[0].value;
    menu2 = data[1].value;
    menu3 = data[2].value;
    menu4 = data[3].value;
    menu5 = data[4].value;
    print(menu1);

    // var emptyMenuText = List.filled(2, "", growable: true);
    // emptyMenuText[0] = "식단이 없어요";
    // menu1.length == 0 ? menu1 = emptyMenuText : menu1 = menu1;
    // menu2.length == 0 ? menu2 = emptyMenuText : menu2 = menu2;
    // menu3.length == 0 ? menu3 = emptyMenuText : menu3 = menu3;
    // menu4.length == 0 ? menu4 = emptyMenuText : menu4 = menu4;
    // menu5.length == 0 ? menu5 = emptyMenuText : menu5 = menu5;
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
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        timeCafeteria[0].toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: SizeConfig.sizeByHeight(5.0),
                    ),
                    child: Image(
                      height: SizeConfig.blockSizeHorizontal,
                      image: AssetImage('assets/images/mealPage/divider.png'),
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
                            ...menu1.map((e) => Container(
                                  width: SizeConfig.sizeByWidth(180.0),
                                  child: Text(
                                    '$e',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ))
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
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            timeCafeteria[1].toString(),
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            timeCafeteria[2].toString(),
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: SizeConfig.sizeByHeight(5.0),
                    ),
                    child: Image(
                      height: SizeConfig.blockSizeHorizontal,
                      image: AssetImage('assets/images/mealPage/divider.png'),
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
                            padding: EdgeInsets.only(
                                bottom: SizeConfig.sizeByHeight(10.0)),
                            child: RichText(
                              text: TextSpan(
                                text: '| ',
                                style: TextStyle(
                                  color: Color(0xff0081FF),
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '양식',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xff3F3F3F),
                                    ),
                                  ),
                                  TextSpan(
                                      text: ' |',
                                      style: TextStyle(
                                        color: Color(0xff0081FF),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          ...menu2.map((e) => Container(
                                margin: EdgeInsets.only(
                                    bottom: SizeConfig.sizeByHeight(10.0)),
                                width: SizeConfig.sizeByWidth(120.0),
                                child: Text(
                                  '$e',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ))
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: SizeConfig.sizeByHeight(10.0)),
                            child: RichText(
                              text: TextSpan(
                                text: '| ',
                                style: TextStyle(
                                  color: Color(0xff0081FF),
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '라면',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xff3F3F3F),
                                    ),
                                  ),
                                  TextSpan(
                                      text: ' |',
                                      style: TextStyle(
                                        color: Color(0xff0081FF),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          ...menu3.map((e) => Container(
                                margin: EdgeInsets.only(
                                    bottom: SizeConfig.sizeByHeight(10.0)),
                                width: SizeConfig.sizeByWidth(120.0),
                                child: Text(
                                  '$e',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.sizeByHeight(25.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.sizeByHeight(10.0)),
                              child: RichText(
                                text: TextSpan(
                                  text: '| ',
                                  style: TextStyle(
                                    color: Color(0xff0081FF),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '분식',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xff3F3F3F),
                                      ),
                                    ),
                                    TextSpan(
                                        text: ' |',
                                        style: TextStyle(
                                          color: Color(0xff0081FF),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            ...menu4.map((e) => Container(
                                  margin: EdgeInsets.only(
                                      bottom: SizeConfig.sizeByHeight(10.0)),
                                  width: SizeConfig.sizeByWidth(120.0),
                                  child: Text(
                                    '$e',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.sizeByHeight(10.0)),
                              child: RichText(
                                text: TextSpan(
                                  text: '| ',
                                  style: TextStyle(
                                    color: Color(0xff0081FF),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '덮밥',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xff3F3F3F),
                                      ),
                                    ),
                                    TextSpan(
                                        text: ' |',
                                        style: TextStyle(
                                          color: Color(0xff0081FF),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            ...menu5.map((e) => Container(
                                  margin: EdgeInsets.only(
                                      bottom: SizeConfig.sizeByHeight(10.0)),
                                  width: SizeConfig.sizeByWidth(120.0),
                                  child: Text(
                                    '$e',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ))
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
