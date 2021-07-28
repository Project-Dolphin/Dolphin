import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:OceanView/common/container/glassMorphism.dart';
import 'package:OceanView/common/dialog/dialog.dart';
import 'package:OceanView/common/dropdown/dropdownButton.dart';
import 'package:OceanView/common/sizeConfig.dart';
import 'package:OceanView/common/text/textBox.dart';
import 'package:OceanView/pages/bus/cityBus/cityBusController.dart';
import 'package:OceanView/pages/bus/stationData.dart';
import 'package:OceanView/services/dailyAtTimeNotification.dart';
import 'package:intl/intl.dart';

class CityBus extends GetView<CityBusController> {
  findCityBusTitle(item) {
    return item == '주변정류장' ? Get.find<CityBusController>().nearStation : item;
  }

  findCityBusSubTitle(item) {
    return item == '주변정류장' || item == '부산역' || item == '영도대교' ? '해양대행' : '';
  }

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      width: SizeConfig.sizeByWidth(300),
      height: SizeConfig.sizeByHeight(478),
      widget: Container(
          margin: EdgeInsets.symmetric(
              vertical: SizeConfig.sizeByHeight(8),
              horizontal: SizeConfig.sizeByWidth(16)),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '정류장 선택',
                      style: TextStyle(
                        color: Color(0xff005A9E),
                        fontSize: SizeConfig.sizeByHeight(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.sizeByHeight(55),
                  ),
                  Container(
                    height: SizeConfig.sizeByHeight(290),
                    child: Stack(
                      children: [
                        Container(
                          width: 1,
                          margin:
                              EdgeInsets.only(left: SizeConfig.sizeByWidth(40)),
                          height: SizeConfig.sizeByHeight(290),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: <Color>[
                                  Color(0xFF339EFB).withOpacity(0),
                                  Color(0xFF3299F3),
                                  Color(0xFF339EFB).withOpacity(0),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.0, 0.5, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                        ),
                        GetBuilder<CityBusController>(
                          init: CityBusController(),
                          builder: (_) {
                            return _.selectedStation == '해양대구본관'
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FirstArrive(
                                          _.nextDepartCityBus!.length > 0
                                              ? _.nextDepartCityBus![0]
                                                  .difference(DateTime.now())
                                                  .inMinutes
                                                  .toString()
                                              : '없음',
                                          _.nextDepartCityBus!.length > 0
                                              ? DateFormat('HH:mm').format(
                                                  _.nextDepartCityBus![0])
                                              : ' '),
                                      SecondArrive(
                                          _.nextDepartCityBus!.length > 1
                                              ? _.nextDepartCityBus![1]
                                                  .difference(DateTime.now())
                                                  .inMinutes
                                                  .toString()
                                              : '없음',
                                          _.nextDepartCityBus!.length > 1
                                              ? DateFormat('HH:mm').format(
                                                  _.nextDepartCityBus![1])
                                              : ' '),
                                      ThirdArrive(
                                          _.nextDepartCityBus!.length > 2
                                              ? _.nextDepartCityBus![2]
                                                  .difference(DateTime.now())
                                                  .inMinutes
                                                  .toString()
                                              : '없음',
                                          _.nextDepartCityBus!.length > 2
                                              ? DateFormat('HH:mm').format(
                                                  _.nextDepartCityBus![2])
                                              : ' '),
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _.isLoading
                                          ? SpinKitThreeBounce(
                                              color: Colors.lightBlue,
                                              size: SizeConfig.sizeByHeight(30),
                                            )
                                          : FirstArrive(
                                              _.responseCityBus?.min1,
                                              _.responseCityBus != null
                                                  ? DateFormat('HH:mm').format(
                                                      DateTime.now().add(Duration(
                                                          minutes: int.parse(_
                                                              .responseCityBus!
                                                              .min1))))
                                                  : 'error'),
                                      _.isLoading
                                          ? SpinKitThreeBounce(
                                              color: Colors.lightBlue,
                                              size: SizeConfig.sizeByHeight(30),
                                            )
                                          : SecondArrive(
                                              _.responseCityBus?.min2,
                                              _.responseCityBus != null
                                                  ? DateFormat('HH:mm').format(
                                                      DateTime.now().add(Duration(
                                                          minutes: int.parse(_
                                                              .responseCityBus!
                                                              .min2))))
                                                  : 'error'),
                                      SizedBox(
                                        height: 1,
                                      ),

                                      // ThirdArrive(null, "error"),
                                    ],
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.sizeByHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding:
                                EdgeInsets.all(SizeConfig.sizeByHeight(8.5)),
                          ),
                          child: Row(
                            children: [
                              TextBox('버스위치보기', 12, FontWeight.w500,
                                  Color(0xff3F3F3F)),
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
              ),
              Positioned(
                top: SizeConfig.sizeByHeight(24),
                child: Container(
                  width: SizeConfig.sizeByWidth(268),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetBuilder<CityBusController>(
                          init: CityBusController(),
                          builder: (_) {
                            return Dropdown(
                              controller.stationList,
                              _.selectedStation,
                              (value) {
                                value == '주변정류장'
                                    ? findNearStation()
                                    : value == '부산역'
                                        ? fetchStation('169100201')
                                        : value == '영도대교'
                                            ? fetchStation('167850202')
                                            : _.findNextDepartCityBus();

                                controller.setSelectedStation(value);
                              },
                              findTitle: findCityBusTitle,
                              findSubTitle: findCityBusSubTitle,
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class FirstArrive extends StatelessWidget {
  const FirstArrive(this.remainTime, this.arriveTime, {Key? key})
      : super(key: key);
  final String arriveTime;
  final String? remainTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: SizeConfig.sizeByWidth(80),
              child: Center(
                child: Image.asset(
                  'assets/images/busPage/busIcon_190.png',
                  width: SizeConfig.sizeByHeight(80),
                  height: SizeConfig.sizeByHeight(80),
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.sizeByWidth(15),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '도착까지',
                  style: TextStyle(
                      color: Color(0xFF0797F8),
                      fontSize: SizeConfig.sizeByHeight(12),
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  height: SizeConfig.sizeByHeight(70),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          remainTime == '없음'
                              ? TextBox('다음 차가 없습니다.', 18, FontWeight.w700,
                                  Color(0xFF3F3F3F))
                              : TextBox(
                                  '약 ${remainTime != null ? remainTime : '300'}분',
                                  28,
                                  FontWeight.w700,
                                  Color(0xFF3F3F3F)),
                          TextBox(
                            '$arriveTime',
                            14,
                            FontWeight.w500,
                            Color(0xFF717171),
                          ),
                          SizedBox(
                            height: SizeConfig.sizeByHeight(6),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

class SecondArrive extends StatelessWidget {
  const SecondArrive(this.remainTime, this.arriveTime, {Key? key})
      : super(key: key);
  final String arriveTime;
  final String? remainTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: SizeConfig.sizeByWidth(80),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () async {
                    await dailyAtTimeNotification('버스 도착 알림', '버스 도착 3분 전이에요.',
                        (int.parse(remainTime!) - 3));
                    Get.dialog(
                        AlertDialog(
                          contentPadding: EdgeInsets.fromLTRB(
                              SizeConfig.sizeByHeight(20),
                              SizeConfig.sizeByHeight(20),
                              SizeConfig.sizeByHeight(20),
                              0),
                          content: dialog,
                        ),
                        transitionDuration: Duration(milliseconds: 200),
                        name: '버스알림');
                  },
                  child: Image.asset(
                    'assets/images/busPage/notiIcon_next.png',
                    width: SizeConfig.sizeByHeight(60),
                    height: SizeConfig.sizeByHeight(60),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.sizeByWidth(15),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                remainTime == '없음'
                    ? TextBox(
                        '다음 차가 없습니다.', 18, FontWeight.w700, Color(0xFF3F3F3F))
                    : TextBox('약 ${remainTime != null ? remainTime : '300'}분',
                        22, FontWeight.w700, Color(0xFF3F3F3F)),
                TextBox(
                  '$arriveTime',
                  14,
                  FontWeight.w500,
                  Color(0xFF717171),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class ThirdArrive extends StatelessWidget {
  const ThirdArrive(this.remainTime, this.arriveTime, {Key? key})
      : super(key: key);
  final String? arriveTime;
  final String? remainTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: SizeConfig.sizeByWidth(80),
              child: Center(
                child: Image.asset(
                  'assets/images/busPage/notiIcon_later.png',
                  width: SizeConfig.sizeByHeight(30),
                  height: SizeConfig.sizeByHeight(30),
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.sizeByWidth(15),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                remainTime == '없음'
                    ? TextBox(
                        '다음 차가 없습니다.', 18, FontWeight.w700, Color(0xFF3F3F3F))
                    : TextBox('약 ${remainTime != null ? remainTime : '300'}분',
                        18, FontWeight.w500, Color(0xFF3F3F3F)),
                Column(
                  children: [
                    TextBox(
                      '$arriveTime',
                      14,
                      FontWeight.w500,
                      Color(0xFF717171),
                    ),
                    SizedBox(
                      height: SizeConfig.sizeByHeight(2),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
