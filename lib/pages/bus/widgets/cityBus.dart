import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/dialog/dialog.dart';
import 'package:oceanview/common/dropdown/dropdownButton.dart';
import 'package:oceanview/common/loading/loading.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/bus/api/cityBusRepository.dart';
import 'package:oceanview/pages/bus/bus_controller.dart';
import 'package:oceanview/pages/bus/cityBus/cityBusController.dart';
import 'package:oceanview/pages/bus/cityBus/cityBusListPage.dart';
import 'package:oceanview/pages/bus/stationData.dart';

import 'package:intl/intl.dart';
import 'package:oceanview/services/dailyAtTimeNotification.dart';

class CityBus extends GetView<CityBusController> {
  findCityBusTitle(item) {
    return item == '주변정류장'
        ? Get.find<CityBusController>().nearStation.length > 10
            ? Get.find<CityBusController>().nearStation.substring(0, 7) + '...'
            : Get.find<CityBusController>().nearStation
        : item;
  }

  findCityBusSubTitle(item) {
    return item == '주변정류장' || item == '부산역.초량시장입구' || item == '영도대교'
        ? '해양대행'
        : '';
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
            return Stack(
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
                          fontSize: 10,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.sizeByHeight(93),
                    ),
                    Container(
                      height: SizeConfig.sizeByHeight(355),
                      child: _.isLoading
                          ? Loading()
                          : Stack(
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
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: GetBuilder<BusController>(
                                          init: BusController(),
                                          builder: (busController) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: _.selectedStation ==
                                                      '해양대구본관'
                                                  ? [
                                                      FirstArrive(
                                                          _.departBus.length > 0
                                                              ? _.departBus[0].remainMinutes
                                                                  .toString()
                                                              : '없음',
                                                          _.departBus.length > 0
                                                              ? _.departBus[0]
                                                                  .bus!
                                                              : ' '),
                                                      SecondArrive(
                                                          _.departBus.length > 1
                                                              ? _.departBus[1].remainMinutes
                                                                  .toString()
                                                              : '없음',
                                                          _.departBus.length > 1
                                                              ? _.departBus[1]
                                                                  .bus!
                                                              : ' ',
                                                          _.stationList.indexOf(_
                                                              .selectedStation),
                                                          busController.getIsNotiOn(_
                                                                  .stationList
                                                                  .indexOf(_
                                                                      .selectedStation) +
                                                              10)),
                                                      ThirdArrive(
                                                        _.departBus.length > 2
                                                            ? _.departBus[2].remainMinutes
                                                                .toString()
                                                            : '없음',
                                                        _.departBus.length > 2
                                                            ? _.departBus[2]
                                                                .bus!
                                                            : ' ',
                                                        _.stationList.indexOf(
                                                            _.selectedStation),
                                                        busController.getIsNotiOn(_
                                                                .stationList
                                                                .indexOf(_
                                                                    .selectedStation) +
                                                            20),
                                                      )
                                                    ]
                                                  : [
                                                      FirstArrive(
                                                          _.cityBusRemainTime !=
                                                                      [] &&
                                                                  _.cityBusRemainTime[
                                                                          0] !=
                                                                      9999
                                                              ? _.cityBusRemainTime[
                                                                      0]
                                                                  .toString()
                                                              : '없음',
                                                          _.cityBusRemainTime !=
                                                                      [] &&
                                                                  _.cityBusRemainTime[
                                                                          0] !=
                                                                      9999
                                                              ? DateFormat(
                                                                      'HH:mm')
                                                                  .format(
                                                                      _.cityBusArriveTime[
                                                                          0])
                                                              : ' '),
                                                      SecondArrive(
                                                          _.cityBusRemainTime != [] &&
                                                                  _.cityBusRemainTime[1] !=
                                                                      9999
                                                              ? _.cityBusRemainTime[1]
                                                                  .toString()
                                                              : '없음',
                                                          _.cityBusRemainTime != [] &&
                                                                  _.cityBusRemainTime[1] !=
                                                                      9999
                                                              ? DateFormat('HH:mm')
                                                                  .format(
                                                                      _.cityBusArriveTime[
                                                                          1])
                                                              : ' ',
                                                          _.stationList.indexOf(_
                                                              .selectedStation),
                                                          busController.getIsNotiOn(_
                                                                  .stationList
                                                                  .indexOf(_.selectedStation) +
                                                              10)),
                                                      Container(),
                                                    ],
                                            );
                                          }),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              CityBusRepository()
                                                  .getCityBusList();
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                TextBox(
                                                    '버스위치보기',
                                                    13,
                                                    FontWeight.w500,
                                                    Color(0xFF353B45)),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  size: SizeConfig.sizeByHeight(
                                                      12),
                                                  color: Color(0xFF353B45),
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                    ),
                  ],
                ),
                Positioned.fill(
                  top: SizeConfig.sizeByHeight(24),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Center(
                        child: GetBuilder<CityBusController>(
                            init: CityBusController(),
                            builder: (_) {
                              return Dropdown(
                                _.stationList,
                                _.selectedStation,
                                (value) {
                                  fetchSelectedStation(value);
                                  _.setSelectedStation(value);
                                },
                                findTitle: findCityBusTitle,
                                findSubTitle: findCityBusSubTitle,
                              );
                            }),
                      ),
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

fetchSelectedStation(selectedStation) {
  selectedStation == '주변정류장'
      ? findNearStation()
      : selectedStation == '부산역.초량시장입구'
          ? fetchStation('169130201')
          : selectedStation == '영도대교'
              ? fetchStation('167850202')
              : CityBusRepository().getNextDepartCityBus();
}

handleBusNotification(id, remainTime, isNotiOn) async {
  if (remainTime != null && remainTime != '없음') {
    await dailyAtTimeNotification(
        id, '버스 도착 알림', '190 버스 도착 3분 전이에요.', (int.parse(remainTime) - 3));
    if (!isNotiOn) {
      Get.dialog(
          AlertDialog(
              contentPadding: EdgeInsets.fromLTRB(SizeConfig.sizeByHeight(20),
                  SizeConfig.sizeByHeight(20), SizeConfig.sizeByHeight(20), 0),
              content: dialog),
          transitionDuration: Duration(milliseconds: 200),
          name: '190버스알림');
    }
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
                          : int.parse(remainTime!) > 0
                              ? TextBox('$remainTime분 후', 30, FontWeight.w700,
                                  Color(0xFF353B45))
                              : TextBox('곧 도착', 30, FontWeight.w700,
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
  const SecondArrive(this.remainTime, this.arriveTime, this.stationIndex,
      this.isNotificationOn,
      {Key? key})
      : super(key: key);
  final String arriveTime;
  final String? remainTime;
  final int? stationIndex;
  final bool? isNotificationOn;

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
                  onPressed: () => handleBusNotification(
                      10 + stationIndex!, remainTime, isNotificationOn),
                  child: Image.asset(
                    isNotificationOn!
                        ? 'assets/images/busPage/notiIcon_next_on.png'
                        : 'assets/images/busPage/notiIcon_next_off.png',
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
                    : TextBox('$remainTime분 후', 22, FontWeight.w700,
                        Color(0xFF353B45)),
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
  const ThirdArrive(this.remainTime, this.arriveTime, this.stationIndex,
      this.isNotificationOn,
      {Key? key})
      : super(key: key);
  final String? arriveTime;
  final String? remainTime;
  final int? stationIndex;
  final bool? isNotificationOn;

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
                  onPressed: () => handleBusNotification(
                      20 + stationIndex!, remainTime, isNotificationOn),
                  child: Image.asset(
                    isNotificationOn!
                        ? 'assets/images/busPage/notiIcon_later_on.png'
                        : 'assets/images/busPage/notiIcon_later_off.png',
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
                    : TextBox('$remainTime분 후', 18, FontWeight.w700,
                        Color(0xFF353B45)),
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
