import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
          width: SizeConfig.sizeByHeight(80),
          height: SizeConfig.sizeByHeight(80),
        ),
        TextBox(
          '해양대구본관',
          SizeConfig.sizeByHeight(14),
          FontWeight.w400,
          Color(0xFF353B45),
        ),
        SizedBox(
          height: SizeConfig.sizeByHeight(10),
        ),
        GetBuilder<CityBusController>(
            init: CityBusController(),
            builder: (_) {
              return _.nextDepartCityBus != null
                  ? TextBox(
                      _.nextDepartCityBus!.length > 0
                          ? _.nextDepartCityBus![0]
                                      .difference(DateTime.now())
                                      .inMinutes >
                                  1
                              ? '${_.nextDepartCityBus![0].difference(DateTime.now()).inMinutes.toString()}분 후 출발'
                              : _.nextDepartCityBus![0]
                                          .difference(DateTime.now())
                                          .inMinutes >
                                      -1
                                  ? '곧 도착'
                                  : '${(_.nextDepartCityBus![0].difference(DateTime.now()).inMinutes * -1).toString()}분 전 출발'
                          : '다음 차가 없습니다',
                      SizeConfig.sizeByHeight(16),
                      FontWeight.w700,
                      Color(0xFF0081FF),
                    )
                  : SpinKitThreeBounce(
                      size: SizeConfig.sizeByHeight(16),
                      color: Color(0xFF0081FF),
                    );
            })
      ],
    );
  }
}
