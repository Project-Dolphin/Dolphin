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

  calcHeight(dynamic data) {
    var idx = data!.length == 7 ? 0 : 3;

    var len1 = data[0 + idx].value.length > 5 ? 5 : data[0 + idx].value!.length;
    var len2 = (data[1 + idx].value.length > data[2 + idx].value.length
                ? data[1 + idx].value.length
                : data[2 + idx].value.length) >
            5
        ? 5
        : (data[1 + idx].value.length > data[2 + idx].value.length
            ? data[1 + idx].value.length
            : data[2 + idx].value.length);
    var len3 = (data[3 + idx].value.length > data[4 + idx].value.length
                ? data[3 + idx].value.length
                : data[4 + idx].value.length) >
            5
        ? 5
        : (data[3 + idx].value.length > data[4 + idx].value.length
            ? data[3 + idx].value.length
            : data[4 + idx].value.length);

    if ((len1 + len2 + len3) * 30.0 + 140 < 650)
      return 650.0;
    else
      return (len1 + len2 + len3) * 30.0 + 140;
  }

  @override
  Widget build(BuildContext context) {
    var idx = data!.length == 7 ? 0 : 3;
    if (data.length == 1) {
      menu1 = menu2 = menu3 = menu4 = menu5 = ['식단이 없어요'];
    } else {
      menu1 = data[0 + idx].value;
      menu2 = data[1 + idx].value;
      menu3 = data[2 + idx].value;
      menu4 = data[3 + idx].value;
      menu5 = data[4 + idx].value;
    }

    return GlassMorphism(
      width: SizeConfig.screenWidth - SizeConfig.sizeByWidth(20.0),
      height: SizeConfig.sizeByHeight(calcHeight(data)),
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
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.sizeByHeight(13)),
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
