import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/dialog/dialog.dart';
import 'package:oceanview/common/dropdown/dropdownButton.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/bus/api/cityBusRepository.dart';
import 'package:oceanview/pages/bus/cityBus/cityBusController.dart';
import 'package:oceanview/pages/bus/cityBus/cityBusListPage.dart';
import 'package:oceanview/pages/bus/stationData.dart';
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
                                  Color(0xFF4BA6FF).withOpacity(0),
                                  Color(0xFF3299F3),
                                  Color(0xFF4BA6FF).withOpacity(0),
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
                            var departRemainTime = [];
                            var departArriveTime = [];
                            var cityBusArriveTime = [];
                            if (_.selectedStation == '해양대구본관') {
                              for (var i = 0;
                                  i < _.nextDepartCityBus!.length;
                                  i++) {
                                departRemainTime.add(_.nextDepartCityBus![i]
                                    .difference(DateTime.now())
                                    .inMinutes
                                    .toString());
                                departArriveTime.add(DateFormat('HH:mm')
                                    .format(_.nextDepartCityBus![i]));
                              }
                            } else {
                              _.responseCityBus != null
                                  ? cityBusArriveTime = [
                                      _.responseCityBus!.min1,
                                      _.responseCityBus!.min2
                                    ]
                                  : cityBusArriveTime = [];
                            }

                            return _.selectedStation == '해양대구본관'
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: _.isLoading
                                        ? [Container()]
                                        : [
                                            FirstArrive(
                                                _.nextDepartCityBus!.length > 0
                                                    ? departRemainTime[0]
                                                    : '없음',
                                                _.nextDepartCityBus!.length > 0
                                                    ? departArriveTime[0]
                                                    : ' '),
                                            SecondArrive(
                                                _.nextDepartCityBus!.length > 1
                                                    ? departRemainTime[1]
                                                    : '없음',
                                                _.nextDepartCityBus!.length > 1
                                                    ? departArriveTime[1]
                                                    : ' '),
                                            ThirdArrive(
                                                _.nextDepartCityBus!.length > 2
                                                    ? departRemainTime[2]
                                                    : '없음',
                                                _.nextDepartCityBus!.length > 2
                                                    ? departArriveTime[2]
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
                                              cityBusArriveTime != []
                                                  ? cityBusArriveTime[0]
                                                      .toString()
                                                  : 'error',
                                              cityBusArriveTime != []
                                                  ? DateFormat('HH:mm').format(
                                                      DateTime.now().add(Duration(
                                                          minutes:
                                                              cityBusArriveTime[
                                                                  0])))
                                                  : 'error'),
                                      _.isLoading
                                          ? SpinKitThreeBounce(
                                              color: Colors.lightBlue,
                                              size: SizeConfig.sizeByHeight(30),
                                            )
                                          : SecondArrive(
                                              cityBusArriveTime != []
                                                  ? cityBusArriveTime[1]
                                                      .toString()
                                                  : 'error',
                                              cityBusArriveTime != []
                                                  ? DateFormat('HH:mm').format(
                                                      DateTime.now().add(Duration(
                                                          minutes:
                                                              cityBusArriveTime[
                                                                  1])))
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
                          onPressed: () {
                            CityBusRepository().getCityBusList();
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => CityBusListPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding:
                                EdgeInsets.all(SizeConfig.sizeByHeight(8.5)),
                          ),
                          child: Row(
                            children: [
                              TextBox('버스위치보기', 12, FontWeight.w500,
                                  Color(0xFF353B45)),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: SizeConfig.sizeByHeight(12),
                                color: Color(0xFF353B45),
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
                                            : CityBusRepository()
                                                .getNextDepartCityBus();
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
                              Color(0xFF353B45))
                          : TextBox(
                              '약 ${remainTime != null ? remainTime : '300'}분',
                              28,
                              FontWeight.w700,
                              Color(0xFF353B45)),
                      TextBox(
                        '$arriveTime',
                        14,
                        FontWeight.w400,
                        Color(0xFF717171),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
                    // await dailyAtTimeNotification('버스 도착 알림', '버스 도착 3분 전이에요.',
                    //     (int.parse(remainTime!) - 3));
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
                        '다음 차가 없습니다.', 18, FontWeight.w700, Color(0xFF353B45))
                    : TextBox('약 ${remainTime != null ? remainTime : '300'}분',
                        22, FontWeight.w700, Color(0xFF353B45)),
                arriveTime != ' '
                    ? TextBox(
                        '$arriveTime',
                        14,
                        FontWeight.w400,
                        Color(0xFF717171),
                      )
                    : SizedBox(
                        height: SizeConfig.sizeByHeight(5),
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
                  width: SizeConfig.sizeByHeight(40),
                  height: SizeConfig.sizeByHeight(40),
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
                        '다음 차가 없습니다.', 18, FontWeight.w700, Color(0xFF353B45))
                    : TextBox('약 ${remainTime != null ? remainTime : '300'}분',
                        18, FontWeight.w500, Color(0xFF353B45)),
                arriveTime != ' '
                    ? Column(
                        children: [
                          TextBox(
                            '$arriveTime',
                            14,
                            FontWeight.w400,
                            Color(0xFF717171),
                          ),
                          SizedBox(
                            height: SizeConfig.sizeByHeight(2),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: SizeConfig.sizeByHeight(5),
                      ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
