import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/dialog/dialog.dart';
import 'package:oceanview/common/dropdown/dropdownButton.dart';
import 'package:oceanview/common/loading/loading.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/bus/api/cityBusRepository.dart';
import 'package:oceanview/pages/bus/cityBus/cityBusController.dart';
import 'package:oceanview/pages/bus/cityBus/cityBusListPage.dart';
import 'package:oceanview/pages/bus/stationData.dart';

import 'package:intl/intl.dart';
import 'package:oceanview/services/dailyAtTimeNotification.dart';

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
        child: GetBuilder<CityBusController>(
          init: CityBusController(),
          builder: (_) {
            var departRemainTime = [];
            var departArriveTime = [];
            var cityBusArriveTime = [];
            print(_.responseCityBus!.min1);
            if (_.selectedStation == '해양대구본관') {
              for (var i = 0; i < _.nextDepartCityBus!.length; i++) {
                var differenceMinute = _.nextDepartCityBus![i]
                    .difference(DateTime.now())
                    .inMinutes;

                departRemainTime.add(differenceMinute.toString());
                departArriveTime
                    .add(DateFormat('HH:mm').format(_.nextDepartCityBus![i]));
              }
            } else {
              _.responseCityBus != null
                  ? cityBusArriveTime = [
                      _.responseCityBus!.min1 ?? 9999,
                      _.responseCityBus!.min2 ?? 9999
                    ]
                  : cityBusArriveTime = [];
            }

            return _.isLoading
                ? Loading()
                : Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '정류장 선택',
                              style: TextStyle(
                                color: Color(0xFF0081FF),
                                fontSize: SizeConfig.sizeByHeight(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.sizeByHeight(85),
                          ),
                          Container(
                            height: SizeConfig.sizeByHeight(290),
                            child: Stack(
                              children: [
                                Container(
                                  width: 1,
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.sizeByHeight(45)),
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
                                _.selectedStation == '해양대구본관'
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
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
                                          FirstArrive(
                                              cityBusArriveTime != [] &&
                                                      cityBusArriveTime[0] !=
                                                          9999
                                                  ? cityBusArriveTime[0]
                                                      .toString()
                                                  : '없음',
                                              cityBusArriveTime != [] &&
                                                      cityBusArriveTime[0] !=
                                                          9999
                                                  ? DateFormat('HH:mm').format(
                                                      DateTime.now().add(Duration(
                                                          minutes:
                                                              cityBusArriveTime[
                                                                  0])))
                                                  : ' '),
                                          SecondArrive(
                                              cityBusArriveTime != [] &&
                                                      cityBusArriveTime[1] !=
                                                          9999
                                                  ? cityBusArriveTime[1]
                                                      .toString()
                                                  : '없음',
                                              cityBusArriveTime != [] &&
                                                      cityBusArriveTime[1] !=
                                                          9999
                                                  ? DateFormat('HH:mm').format(
                                                      DateTime.now().add(Duration(
                                                          minutes:
                                                              cityBusArriveTime[
                                                                  1])))
                                                  : ' '),
                                          SizedBox(
                                            height: 1,
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.sizeByHeight(10),
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
                                          builder: (context) =>
                                              CityBusListPage()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: EdgeInsets.all(
                                        SizeConfig.sizeByHeight(8.5)),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                  );
          },
        ),
      ),
    );
  }
}

handleBusNotification(remainTime) async {
  if (remainTime != null && remainTime != '없음') {
    await dailyAtTimeNotification(
        '버스 도착 알림', '버스 도착 3분 전이에요.', (int.parse(remainTime) - 3));
    Get.dialog(
        AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(SizeConfig.sizeByHeight(20),
              SizeConfig.sizeByHeight(20), SizeConfig.sizeByHeight(20), 0),
          content: dialog,
        ),
        transitionDuration: Duration(milliseconds: 200),
        name: '190버스알림');
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
              width: SizeConfig.sizeByHeight(90),
              child: Center(
                child: Image.asset(
                  'assets/images/busPage/busIcon_190.png',
                  width: SizeConfig.sizeByHeight(90),
                  height: SizeConfig.sizeByHeight(90),
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.sizeByWidth(24),
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
                          ? TextBox('운행 정보가 없어요', 18, FontWeight.w500,
                              Color(0xFF353B45))
                          : TextBox(
                              '약 ${remainTime != null ? remainTime : '300'}분',
                              30,
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
              width: SizeConfig.sizeByHeight(90),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () => handleBusNotification(remainTime),
                  child: Image.asset(
                    'assets/images/busPage/notiIcon_next.png',
                    width: SizeConfig.sizeByHeight(70),
                    height: SizeConfig.sizeByHeight(70),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.sizeByHeight(24),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                remainTime == '없음'
                    ? TextBox(
                        '운행 정보가 없어요', 18, FontWeight.w500, Color(0xFF353B45))
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
              width: SizeConfig.sizeByHeight(90),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () => handleBusNotification(remainTime),
                  child: Image.asset(
                    'assets/images/busPage/notiIcon_later.png',
                    width: SizeConfig.sizeByHeight(40),
                    height: SizeConfig.sizeByHeight(40),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.sizeByHeight(24),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                remainTime == '없음'
                    ? TextBox(
                        '운행 정보가 없어요', 18, FontWeight.w500, Color(0xFF353B45))
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
