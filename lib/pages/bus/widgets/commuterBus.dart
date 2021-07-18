import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/container/glassMorphism.dart';
import 'package:getx_app/common/dropdown/dropdownButton.dart';
import 'package:getx_app/common/sizeConfig.dart';
import 'package:getx_app/common/text/textBox.dart';
import 'package:getx_app/pages/bus/bus_controller.dart';

class CommuterBus extends StatefulWidget {
  @override
  _CommuterBusState createState() => _CommuterBusState();
}

class _CommuterBusState extends State<CommuterBus> {
  final busList = [
    '통근 버스 1호',
    '통근 버스 2호',
    '통근 버스 3호',
  ];
  var selectedBus = '통근 버스 1호';
  List<String> stationList_1 = [
    '풍년혼수마트',
    '롯데캐슬 상가 앞',
    '장전동 기아자동차',
    '장전동 놀이터',
    '온천장 홈플러스',
    '롯데백화점 정류장',
    '삼성프라자(온천점)',
    '교대역',
    '연산동, 연제초교',
    '양정역',
    '부전역',
    '서면역',
    '범일역 5번출구',
    '부산진역 7번출구',
    '부산역 3번출구',
    '영도대교 대궁한정식',
    '학교도착',
  ];
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<BusController>(
            init: BusController(),
            builder: (_) {
              return GlassMorphism(
                width: SizeConfig.sizeByWidth(300),
                height: SizeConfig.sizeByHeight(478),
                widget: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.sizeByWidth(8),
                        horizontal: SizeConfig.sizeByHeight(16)),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '버스 선택',
                                style: TextStyle(
                                  color: Color(0xff005A9E),
                                  fontSize: SizeConfig.sizeByHeight(10),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.sizeByHeight(6),
                            ),
                            SizedBox(
                              height: SizeConfig.sizeByHeight(45),
                            ),
                            renderStationStatus(stationList_1, '07:25', '08:50')
                          ],
                        ),
                        Positioned(
                          top: SizeConfig.sizeByHeight(24),
                          right: SizeConfig.sizeByWidth(24),
                          child: Dropdown(
                              busList,
                              selectedBus,
                              (value) => setState(() {
                                    selectedBus = value;
                                  })),
                        ),
                      ],
                    )),
              );
            }),
      ],
    );
  }

  renderStationStatus(
      List<String> stationList, String departTime, String arriveTime) {
    return Stack(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(top: SizeConfig.sizeByHeight(11)),
            width: 1,
            height: SizeConfig.sizeByHeight(350),
            color: Color(0xFF339EFB),
          ),
        ),
        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: SizeConfig.sizeByWidth(100),
                    alignment: Alignment.centerRight,
                    child: TextBox(stationList[0], 14, FontWeight.w700,
                        Color(0xFF0797F8))),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.sizeByWidth(10)),
                  width: SizeConfig.sizeByHeight(11),
                  height: SizeConfig.sizeByHeight(11),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(SizeConfig.sizeByHeight(11))),
                      gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF009DF5),
                            Color(0xFF1E7AFF),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xffB4D5F1).withOpacity(0.7),
                            offset: Offset(0, 3),
                            blurRadius: 5,
                            spreadRadius: 1)
                      ]),
                ),
                Container(
                    width: SizeConfig.sizeByWidth(100),
                    alignment: Alignment.centerLeft,
                    child: TextBox(
                        departTime, 14, FontWeight.w700, Color(0xff3F3F3F)))
              ],
            ),
            SizedBox(
              height: SizeConfig.sizeByHeight(20),
            ),
            renderLeftSide(stationList[1]),
            renderRightSide(stationList[2])
          ],
        )
      ],
    );
  }
}

Widget renderLeftSide(String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
          width: SizeConfig.sizeByWidth(100),
          alignment: Alignment.centerRight,
          child: TextBox(value, 12, FontWeight.w500, Colors.black)),
      Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.sizeByWidth(10)),
        width: SizeConfig.sizeByHeight(11),
        height: SizeConfig.sizeByHeight(11),
      ),
      Container(
        width: SizeConfig.sizeByWidth(100),
      )
    ],
  );
}

Widget renderRightSide(String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: SizeConfig.sizeByWidth(100),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.sizeByWidth(10)),
        width: SizeConfig.sizeByHeight(11),
        height: SizeConfig.sizeByHeight(11),
      ),
      Container(
          width: SizeConfig.sizeByWidth(100),
          alignment: Alignment.centerLeft,
          child: TextBox(value, 12, FontWeight.w500, Colors.black))
    ],
  );
}
