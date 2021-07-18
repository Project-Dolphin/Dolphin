import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/container/glassMorphism.dart';
import 'package:getx_app/common/carousel/carousel.dart';
import 'package:getx_app/common/sizeConfig.dart';
import 'package:getx_app/common/text/textBox.dart';
import 'package:getx_app/pages/bus/widgets/cityBus.dart';
import 'package:getx_app/pages/bus/widgets/shuttleBus.dart';

import 'bus_controller.dart';

import '../../common/titlebox/onelineTitle.dart';

class BusPage extends GetView<BusController> {
  final List<String> titleList = ['190번', '셔틀버스', '통근버스', '학교버스'];
  final List<dynamic> testPageList = [
    CityBus(),
    ShuttleBus(),
    test3(),
    test4()
  ];
  final name = '버스', stat = '시험기간';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<BusController>(
                builder: (_) => OnelineTitle(
                  name: name,
                  description: _.formattedDate,
                  stat: stat,
                  fontsize1: SizeConfig.sizeByWidth(24),
                  fontsize2: SizeConfig.sizeByWidth(14),
                  fontsize3: SizeConfig.sizeByWidth(12),
                  fontweight1: FontWeight.w700,
                  fontweight2: FontWeight.w400,
                  fontweight3: FontWeight.w400,
                ),
              ),
              Carousel(pageList: testPageList, titleList: titleList),
            ],
          ),
          Positioned(
            bottom: SizeConfig.sizeByHeight(72),
            left: SizeConfig.sizeByWidth(36),
            child: TextBox('학교 출발시간은 실시간 위치가 아닌 홈페이지 기준 고정값입니다.', 11,
                FontWeight.w300, Colors.black),
          )
        ],
      ),
    );
  }
}

class test2 extends StatelessWidget {
  const test2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      width: 300,
      height: 478,
      widget: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '정류장 선택',
                style: TextStyle(
                  color: Color(0xff005A9E),
                  fontSize: 10,
                ),
              ),
              Text(
                '해양대구본관',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              )
            ],
          )),
    );
  }
}

class test3 extends StatelessWidget {
  const test3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      width: 300,
      height: 478,
      widget: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '정류장 선택',
                style: TextStyle(
                  color: Color(0xff005A9E),
                  fontSize: 10,
                ),
              ),
              Text(
                '해양대구본관',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              )
            ],
          )),
    );
  }
}

class test4 extends StatelessWidget {
  const test4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      width: 300,
      height: 478,
      widget: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '정류장 선택',
                style: TextStyle(
                  color: Color(0xff005A9E),
                  fontSize: 10,
                ),
              ),
              Text(
                '해양대구본관',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              )
            ],
          )),
    );
  }
}
