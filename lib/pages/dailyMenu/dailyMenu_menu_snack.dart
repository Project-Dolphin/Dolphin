import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/pages/dailyMenu/infoMenu/menu_information.dart';

class SnackCard extends StatelessWidget {
  var type, name, time;

  SnackCard({
    required this.type,
    required this.name,
    required this.time,
  });

  var menu1 = breakfastMenu;
  var menu2 = americanMenu;
  var menu3 = ramenMenu;
  var menu4 = bunsikMenu;
  var menu5 = riceMenu;

  @override
  Widget build(BuildContext context) {
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
                  Divider(
                    color: Color(0xffE0E0E0),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: SizeConfig.sizeByWidth(7.0),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: SizeConfig.sizeByWidth(110.0),
                              child: Text(
                                menu1[0],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Container(
                              width: SizeConfig.sizeByWidth(110.0),
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
                  Divider(
                    color: Color(0xffE0E0E0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: SizeConfig.sizeByWidth(10.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: SizeConfig.sizeByWidth(10.0)),
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
                              width: SizeConfig.sizeByWidth(110.0),
                              child: Text(
                                menu2[0],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            menu2.length > 2? Container(
                              width: SizeConfig.sizeByWidth(110.0),
                              child: Text(
                                menu2[1],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu2.length > 3? Container(
                              width: SizeConfig.sizeByWidth(110.0),
                              child: Text(
                                menu2[2],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu2.length > 4? Container(
                              width: SizeConfig.sizeByWidth(110.0),
                              child: Text(
                                menu2[3],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu2.length > 5? Container(
                              width: SizeConfig.sizeByWidth(110.0),
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
                              padding: EdgeInsets.only(bottom: SizeConfig.sizeByWidth(10.0)),
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
                              width: SizeConfig.sizeByWidth(110.0),
                              child: Text(
                                menu3[0],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            menu3.length > 2? Container(
                              width: SizeConfig.sizeByWidth(110.0),
                              child: Text(
                                menu3[1],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu3.length > 3? Container(
                              width: SizeConfig.sizeByWidth(110.0),
                              child: Text(
                                menu3[2],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu3.length > 4? Container(
                              width: SizeConfig.sizeByWidth(110.0),
                              child: Text(
                                menu3[3],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu3.length > 5? Container(
                              width: SizeConfig.sizeByWidth(110.0),
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: SizeConfig.sizeByHeight(35.0), left:SizeConfig.sizeByWidth(10.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: SizeConfig.sizeByWidth(10.0)),
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
                              width: SizeConfig.sizeByWidth(110.0),
                              child: Text(
                                menu4[0],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            menu4.length > 2? Container(
                              width: SizeConfig.sizeByWidth(110.0),
                              child: Text(
                                menu4[1],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu4.length > 3? Container(
                              width: SizeConfig.sizeByWidth(110.0),
                              child: Text(
                                menu4[2],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu4.length > 4? Container(
                              width: SizeConfig.sizeByWidth(110.0),
                              child: Text(
                                menu4[3],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu4.length > 5? Container(
                              width: SizeConfig.sizeByWidth(110.0),
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
                              padding: EdgeInsets.only(bottom: SizeConfig.sizeByWidth(10.0)),
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
                              width: SizeConfig.sizeByWidth(110.0),
                              child: Text(
                                menu5[0],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            menu5.length > 2? Container(
                              width: SizeConfig.sizeByWidth(110.0),
                              child: Text(
                                menu5[1],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu5.length > 3? Container(
                              width: SizeConfig.sizeByWidth(110.0),
                              child: Text(
                                menu5[2],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu5.length > 4? Container(
                              width: SizeConfig.sizeByWidth(110.0),
                              child: Text(
                                menu5[3],
                                style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(15.0),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ): Container(),
                            menu5.length > 5? Container(
                              width: SizeConfig.sizeByWidth(110.0),
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
