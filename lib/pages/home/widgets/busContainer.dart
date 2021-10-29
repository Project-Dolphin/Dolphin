import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/bus/cityBus/cityBusController.dart';

class BusContainer extends GetView<CityBusController> {
  const BusContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/homePage/homeIcon_190.png',
          width: SizeConfig.sizeByHeight(90),
          height: SizeConfig.sizeByHeight(90),
        ),
        TextBox(
          '해양대구본관',
          SizeConfig.sizeByHeight(14),
          FontWeight.w400,
          Color(0xFF353B45),
        ),
        SizedBox(
          height: SizeConfig.sizeByHeight(6),
        ),
        GetBuilder<CityBusController>(
            init: CityBusController(),
            builder: (_) {
              return TextBox(
                _.departArriveTime.length > 0
                    ? _.departArriveTime[0]
                                .difference(DateTime.now())
                                .inMinutes >
                            1
                        ? '${_.departArriveTime[0].difference(DateTime.now()).inMinutes.toString()}분 후 출발'
                        : _.departArriveTime[0]
                                    .difference(DateTime.now())
                                    .inMinutes >
                                -1
                            ? '곧 도착'
                            : '${(_.departArriveTime[0].difference(DateTime.now()).inMinutes * -1).toString()}분 전 출발'
                    : '다음 차가 없어요',
                SizeConfig.sizeByHeight(16),
                FontWeight.w700,
                Color(0xFF0081FF),
              );
            })
      ],
    );
  }
}
