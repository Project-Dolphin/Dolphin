import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/icon/gradientIcon.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';

Widget dialog = Container(
  width: SizeConfig.sizeByWidth(300),
  height: SizeConfig.sizeByHeight(154),
  child: Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientIcon(
              ImageIcon(
                  AssetImage('assets/images/bottomNavigationIcon/bus.png'),
                  size: SizeConfig.sizeByHeight(30)),
              LinearGradient(
                  colors: <Color>[
                    Color(0xFF3199FF),
                    Color(0xFF0081FF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            SizedBox(
              width: SizeConfig.sizeByHeight(22),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBox('준비중이에요..', 22, FontWeight.w800, Color(0xFF353B45)),
                  SizedBox(
                    height: SizeConfig.sizeByHeight(8),
                  ),
                  Container(
                    width: SizeConfig.sizeByHeight(165),
                    child: Text.rich(
                      TextSpan(
                        text: '최대한 빠른 시간 안에 ',
                        children: [
                          TextSpan(
                              text: '업데이트',
                              style: TextStyle(fontWeight: FontWeight.w700)),
                          TextSpan(text: '할게요!'),
                        ],
                        style: TextStyle(
                            fontSize: SizeConfig.sizeByHeight(12),
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF353B45)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.sizeByHeight(32),
        ),
        Container(
          width: SizeConfig.sizeByWidth(200),
          height: 0.5,
          color: Color(0xffC4C4C4),
        ),
        SizedBox(height: SizeConfig.sizeByHeight(7)),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            onPressed: () => Get.back(),
            child: TextBox('확인', 18, FontWeight.w400, Color(0xFF353B45)))
      ],
    ),
  ),
);
