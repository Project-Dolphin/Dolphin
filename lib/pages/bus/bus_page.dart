import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/carousel/carousel.dart';
import 'package:getx_app/common/sizeConfig.dart';
import 'package:getx_app/common/text/textBox.dart';
import 'package:getx_app/pages/bus/widgets/cityBus.dart';
import 'package:getx_app/pages/bus/widgets/commuterBus.dart';
import 'package:getx_app/pages/bus/widgets/schoolBus.dart';
import 'package:getx_app/pages/bus/widgets/shuttleBus.dart';

import 'bus_controller.dart';

import '../../common/titlebox/onelineTitle.dart';

class BusPage extends GetView<BusController> {
  final List<String> titleList = ['190번', '셔틀버스', '통근버스', '학교버스'];
  final List<dynamic> testPageList = [
    CityBus(),
    ShuttleBus(),
    CommuterBus(),
    SchoolBus()
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
            top: SizeConfig.screenHeight * 0.8,
            child: Container(
              width: SizeConfig.screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBox('학교 출발시간은 실시간 위치가 아닌 홈페이지 기준 고정값입니다.', 11,
                      FontWeight.w300, Colors.black),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
