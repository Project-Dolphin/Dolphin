import 'package:flutter/material.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/shape/circle.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';

class SchoolBus extends StatelessWidget {
  const SchoolBus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      width: SizeConfig.sizeByWidth(300),
      height: SizeConfig.sizeByHeight(478),
      widget: Container(
          margin: EdgeInsets.symmetric(
              vertical: SizeConfig.sizeByHeight(8),
              horizontal: SizeConfig.sizeByWidth(16)),
          child: Container(
            margin: EdgeInsets.only(top: SizeConfig.sizeByHeight(12)),
            height: SizeConfig.sizeByHeight(360),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                renderSchoolBus('학교 - 남포동간 2회 운행', '영도대교 대궁한정식'),
                Column(
                  children: [
                    renderSchoolBus('학교 - 대연동간 2회 운행', '경성대부경대역 3번출구 눈사랑 안경점'),
                    SizedBox(
                      height: SizeConfig.sizeByHeight(54),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget renderSchoolBus(String title, String station) {
    return Container(
      width: SizeConfig.sizeByWidth(240),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextBox(title, 18, FontWeight.w700, Color(0xFF0081FF)),
          SizedBox(
            height: SizeConfig.sizeByHeight(30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBox('학교 출발', 14, FontWeight.w400, Color(0xFF353B45)),
              TextBox('학교 도착', 14, FontWeight.w400, Color(0xFF353B45)),
            ],
          ),
          SizedBox(
            height: SizeConfig.sizeByHeight(10),
          ),
          Stack(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: SizeConfig.sizeByHeight(2.5)),
                  width: SizeConfig.sizeByWidth(200),
                  height: 1,
                  color: Color(0xFF4BA6FF),
                ),
              ),
              Center(
                child: Container(
                  width: SizeConfig.sizeByWidth(220),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      renderCirleWithShadow(6),
                      renderCirleWithShadow(6),
                      renderCirleWithShadow(6),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.sizeByHeight(5),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.sizeByHeight(3)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextBox('09:00', 14, FontWeight.w700, Color(0xFF353B45)),
                    TextBox('09:25', 14, FontWeight.w700, Color(0xFF353B45)),
                    TextBox('09:50', 14, FontWeight.w700, Color(0xFF353B45)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextBox('14:00', 14, FontWeight.w700, Color(0xFF353B45)),
                    TextBox('14:25', 14, FontWeight.w700, Color(0xFF353B45)),
                    TextBox('14:50', 14, FontWeight.w700, Color(0xFF353B45)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.sizeByHeight(8),
          ),
          Container(
              width: SizeConfig.sizeByWidth(140),
              child: Text(
                station,
                style: TextStyle(
                    color: Color(0xFF353B45),
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                    fontSize: SizeConfig.sizeByHeight(14)),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
