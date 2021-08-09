import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/carousel/carousel.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/common/titlebox/onelineTitle.dart';

import 'bus_controller.dart';

class BusPage extends GetView<BusController> {
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
                  name: _.name,
                  description: _.formattedDate,
                  stat: _.stat,
                  fontsize1: SizeConfig.sizeByHeight(26),
                  fontsize2: SizeConfig.sizeByHeight(14),
                  fontsize3: SizeConfig.sizeByHeight(12),
                  fontweight1: FontWeight.w700,
                  fontweight2: FontWeight.w400,
                  fontweight3: FontWeight.w400,
                ),
              ),
              Carousel(
                pageList: controller.testPageList,
                titleList: controller.titleList,
                bar: true,
              ),
            ],
          ),
          Positioned(
            top: SizeConfig.screenHeight * 0.72,
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
