import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:OceanView/common/icon/gradientIcon.dart';
import 'package:OceanView/common/sizeConfig.dart';
import 'package:OceanView/common/text/textBox.dart';

Widget dialog = Container(
  width: SizeConfig.sizeByWidth(300),
  height: SizeConfig.sizeByHeight(222),
  child: Center(
    child: Column(
      children: [
        GradientIcon(
          ImageIcon(AssetImage('assets/images/bottomNavigationIcon/bus.png'),
              size: SizeConfig.sizeByHeight(40)),
          LinearGradient(
              colors: <Color>[
                Color(0xFF009DF5),
                Color(0xFF1E7AFF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        SizedBox(
          height: SizeConfig.sizeByHeight(15),
        ),
        TextBox('버스 도착 3분전 알림', 20, FontWeight.w700, Colors.black),
        SizedBox(
          height: SizeConfig.sizeByHeight(10),
        ),
        TextBox('다음차가 도착하기 3분전', 14, FontWeight.w400, Colors.black),
        TextBox('푸시 알림을 보내드려요', 14, FontWeight.w400, Colors.black),
        SizedBox(height: SizeConfig.sizeByHeight(27)),
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
            child: TextBox('확인', 18, FontWeight.w400, Colors.black))
      ],
    ),
  ),
);
