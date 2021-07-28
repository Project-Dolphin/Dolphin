import 'package:flutter/material.dart';
import 'package:OceanView/common/container/glassMorphism.dart';
import 'package:OceanView/common/shape/circle.dart';
import 'package:OceanView/common/sizeConfig.dart';
import 'package:OceanView/common/text/textBox.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: SizeConfig.sizeByHeight(12)),
                height: SizeConfig.sizeByHeight(360),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    renderSchoolBus('학교 - 남포동간 1회 운행', '영도대교 대궁한정식'),
                    renderSchoolBus('학교 - 대연동간 1회 운행', '경성대부경대역 3번출구 눈사랑 안경점'),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.sizeByHeight(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.all(SizeConfig.sizeByHeight(8.5)),
                      ),
                      child: Row(
                        children: [
                          TextBox(
                              '전체시간보기', 12, FontWeight.w500, Color(0xff3F3F3F)),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: SizeConfig.sizeByHeight(12),
                            color: Color(0xff3F3F3F),
                          )
                        ],
                      )),
                ],
              )
            ],
          )),
    );
  }

  Widget renderSchoolBus(String title, String station) {
    return Container(
      width: SizeConfig.sizeByWidth(260),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextBox(title, 18, FontWeight.w700, Color(0xFF0797F8)),
          SizedBox(
            height: SizeConfig.sizeByHeight(30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBox('학교 출발', 14, FontWeight.w500, Color(0xFF393939)),
              TextBox('학교 도착', 14, FontWeight.w500, Color(0xFF393939)),
            ],
          ),
          SizedBox(
            height: SizeConfig.sizeByHeight(10),
          ),
          Stack(
            children: [
              Center(
                child: Container(
                  width: SizeConfig.sizeByWidth(200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      renderCirleWithShadow(11),
                      renderCirleWithShadow(11),
                      renderCirleWithShadow(11),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: SizeConfig.sizeByHeight(5)),
                  width: SizeConfig.sizeByWidth(180),
                  height: 1,
                  color: Color(0xFF339EFB),
                ),
              )
            ],
          ),
          SizedBox(
            height: SizeConfig.sizeByHeight(3),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBox('09:00', 14, FontWeight.w700, Color(0xFF393939)),
              TextBox('09:25', 14, FontWeight.w700, Color(0xFF393939)),
              TextBox('09:50', 14, FontWeight.w700, Color(0xFF393939)),
            ],
          ),
          SizedBox(
            height: SizeConfig.sizeByHeight(5),
          ),
          Container(
              width: SizeConfig.sizeByWidth(140),
              child: Text(
                station,
                style: TextStyle(
                    color: Color(0xFF393939),
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.sizeByHeight(14)),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
