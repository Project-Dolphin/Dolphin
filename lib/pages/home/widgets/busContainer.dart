import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/bus/cityBus/cityBusController.dart';

class BusContainer extends GetView<CityBusController> {
  const BusContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 132,
            child: Column(
              children: [
                Expanded(
                  flex: 92,
                  child: Center(
                    child: Image.asset(
                      'assets/images/busPage/busIcon_190.png',
                      // width: SizeConfig.sizeByHeight(80),
                      // height: SizeConfig.sizeByHeight(80),
                    ),
                  ),
                ),
                Expanded(
                  flex: 40,
                  child: Center(
                      child: TextBox(
                    '해양대구본관',
                    SizeConfig.sizeByHeight(14),
                    FontWeight.w500,
                    Color(0xFF0C98F5),
                  )),
                ),
              ],
            )),
        Expanded(
            flex: 58,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xCC1E7AFF),
                      Color(0xCC009DF5),
                    ],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: GetBuilder<CityBusController>(
                  init: CityBusController(),
                  builder: (_) {
                    return _.nextDepartCityBus != null
                        ? Column(
                            children: [
                              Expanded(
                                  child: TextBox(
                                      _.nextDepartCityBus!.length > 0
                                          ? _.nextDepartCityBus![0]
                                                      .difference(
                                                          DateTime.now())
                                                      .inMinutes >
                                                  1
                                              ? '${_.nextDepartCityBus![0].difference(DateTime.now()).inMinutes.toString()}분 후 출발'
                                              : _.nextDepartCityBus![0]
                                                          .difference(
                                                              DateTime.now())
                                                          .inMinutes >
                                                      -1
                                                  ? '곧 도착'
                                                  : '${(_.nextDepartCityBus![0].difference(DateTime.now()).inMinutes * -1).toString()}분 전 출발'
                                          : '다음 차가 없습니다.',
                                      SizeConfig.sizeByHeight(16),
                                      FontWeight.w700,
                                      Colors.white)),
                              Expanded(
                                  child: TextBox(
                                      _.nextDepartCityBus!.length > 0
                                          ? DateFormat('HH:mm')
                                              .format(_.nextDepartCityBus![0])
                                          : ' ',
                                      SizeConfig.sizeByHeight(16),
                                      FontWeight.w700,
                                      Color(0xffE8E8E8)))
                            ],
                          )
                        : SpinKitThreeBounce();
                  }),
            ))
      ],
    );
  }
}
