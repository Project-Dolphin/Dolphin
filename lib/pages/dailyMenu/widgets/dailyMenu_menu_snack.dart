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

  @override
  Widget build(BuildContext context) {
    var western, morning, ramen, flourBased, riceBowl;

    western = morning = ramen = flourBased = riceBowl = ['식단이 없어요'];

    data.forEach((element) {
      switch (element.type) {
        case '양식코너':
          western = element.value;
          break;
        case '조식':
          morning = element.value;
          break;
        case '라면코너':
          ramen = element.value;
          break;
        case '분식코너':
          flourBased = element.value;
          break;
        case '덮밥코너':
          riceBowl = element.value;
          break;
        default:
          break;
      }
    });

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
                        bottom: SizeConfig.sizeByHeight(10.0),
                      ),
                      child: Image(
                        height: SizeConfig.blockSizeHorizontal,
                        image: AssetImage('assets/images/mealPage/divider.png'),
                      ),
                    ),
                    Column(
                      children: [
                        ...morning.map((e) => Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(
                                  bottom: SizeConfig.sizeByHeight(13)),
                              child: Text(
                                '$e ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
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
                            ...western.map((e) => Container(
                                  margin: EdgeInsets.only(
                                      bottom: SizeConfig.sizeByHeight(10.0)),
                                  width: SizeConfig.sizeByWidth(120.0),
                                  child: Text(
                                    '$e',
                                    style: TextStyle(
                                      fontSize: 16.0,
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
                            ...ramen.map((e) => Container(
                                  margin: EdgeInsets.only(
                                      bottom: SizeConfig.sizeByHeight(10.0)),
                                  width: SizeConfig.sizeByWidth(120.0),
                                  child: Text(
                                    '$e',
                                    style: TextStyle(
                                      fontSize: 16.0,
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
                              ...flourBased.map((e) => Container(
                                    margin: EdgeInsets.only(
                                        bottom: SizeConfig.sizeByHeight(10.0)),
                                    width: SizeConfig.sizeByWidth(120.0),
                                    child: Text(
                                      '$e',
                                      style: TextStyle(
                                        fontSize: 16.0,
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
                              ...riceBowl.map((e) => Container(
                                    margin: EdgeInsets.only(
                                        bottom: SizeConfig.sizeByHeight(10.0)),
                                    width: SizeConfig.sizeByWidth(120.0),
                                    child: Text(
                                      '$e',
                                      style: TextStyle(
                                        fontSize: 16.0,
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
            ),
          ],
        ),
      ),
    );
  }
}
