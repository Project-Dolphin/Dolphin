import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/dialog/dialog.dart';
import 'package:oceanview/common/dropdown/dropdownButton.dart';
import 'package:oceanview/common/loading/loading.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/bus/api/shuttleBusRepository.dart';
import 'package:oceanview/pages/bus/bus_controller.dart';
import 'package:oceanview/pages/bus/shuttleBus/shuttleBusController.dart';
import 'package:oceanview/services/dailyAtTimeNotification.dart';
import 'package:oceanview/services/urlUtils.dart';

class ShuttleBus extends GetView<ShuttleBusController> {
  findShuttleBusSubTitle(item) {
    return item == '하리상가' ? 'beta' : '';
  }

  @override
  Widget build(BuildContext context) {
    ShuttleBusRepository().getNextShuttle();
    return GlassMorphism(
      width: SizeConfig.sizeByWidth(300),
      height: SizeConfig.sizeByHeight(478),
      widget: Container(
          margin: EdgeInsets.symmetric(
              vertical: SizeConfig.sizeByWidth(8),
              horizontal: SizeConfig.sizeByHeight(16)),
          child: GetBuilder<ShuttleBusController>(
              init: ShuttleBusController(),
              builder: (_) {
                var remainTime = [];
                var arriveTime = [];
                var hariRemainTime = [];
                var previousTime = _.previousShuttle.length > 0
                    ? (_.previousShuttle[0]
                                .difference(DateTime.now())
                                .inMinutes *
                            -1)
                        .toString()
                    : '';

                for (var i = 0; i < _.nextShuttle.length; i++) {
                  var differenceMinute =
                      _.nextShuttle[i].difference(DateTime.now()).inMinutes;
                  hariRemainTime.add((differenceMinute + 6).toString());
                  remainTime.add(differenceMinute.toString());
                  arriveTime.add(DateFormat('HH:mm').format(_.nextShuttle[i]));
                }
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
                              fontSize: SizeConfig.sizeByHeight(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.sizeByHeight(55),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: SizeConfig.sizeByHeight(12)),
                          child: Column(children: [
                            _.isLoading || previousTime == ''
                                ? SizedBox(
                                    height: SizeConfig.sizeByHeight(14),
                                  )
                                : _.selectedStation == '학교종점 (아치나루터)'
                                    ? TextBox('이전차는 약 $previousTime분전에 지나갔어요',
                                        12, FontWeight.w400, Color(0xFF353B45))
                                    : hariRemainTime.length > 0 &&
                                            int.parse(hariRemainTime[0]) <= 6
                                        ? TextBox('이전차는 약 3분전에 지나갔어요', 12,
                                            FontWeight.w400, Color(0xFF353B45))
                                        : SizedBox(
                                            height: SizeConfig.sizeByHeight(14),
                                          ),
                            SizedBox(
                              height: SizeConfig.sizeByHeight(12),
                            ),
                            Container(
                              height: SizeConfig.sizeByHeight(350),
                              child: _.isLoading
                                  ? Loading()
                                  : Stack(
                                      children: [
                                        Container(
                                          width: 1,
                                          margin: EdgeInsets.only(
                                              left:
                                                  SizeConfig.sizeByHeight(45)),
                                          height: SizeConfig.sizeByHeight(290),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: <Color>[
                                                  Color(0xFF4BA6FF)
                                                      .withOpacity(0),
                                                  Color(0xFF3299F3),
                                                  Color(0xFF4BA6FF)
                                                      .withOpacity(0),
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
                                                      children:
                                                          _.selectedStation ==
                                                                  '학교종점 (아치나루터)'
                                                              ? [
                                                                  FirstArrive(
                                                                      _.nextShuttle.length >
                                                                              0
                                                                          ? remainTime[
                                                                              0]
                                                                          : '없음',
                                                                      _.nextShuttle.length >
                                                                              0
                                                                          ? arriveTime[
                                                                              0]
                                                                          : ' '),
                                                                  SecondArrive(
                                                                      _.nextShuttle.length >
                                                                              1
                                                                          ? remainTime[
                                                                              1]
                                                                          : '없음',
                                                                      _.nextShuttle.length >
                                                                              1
                                                                          ? arriveTime[
                                                                              1]
                                                                          : ' ',
                                                                      _.stationList
                                                                          .indexOf(_
                                                                              .selectedStation),
                                                                      busController.getIsNotiOn(_
                                                                              .stationList
                                                                              .indexOf(_.selectedStation) +
                                                                          30)),
                                                                  ThirdArrive(
                                                                      _.nextShuttle.length >
                                                                              2
                                                                          ? remainTime[
                                                                              2]
                                                                          : '없음',
                                                                      _.nextShuttle.length >
                                                                              2
                                                                          ? arriveTime[
                                                                              2]
                                                                          : ' ',
                                                                      _.stationList
                                                                          .indexOf(_
                                                                              .selectedStation),
                                                                      busController
                                                                          .getIsNotiOn(_.stationList.indexOf(_.selectedStation) +
                                                                              40))
                                                                ]
                                                              : [
                                                                  FirstArrive(
                                                                      _.nextShuttle.length >
                                                                              0
                                                                          ? hariRemainTime[
                                                                              0]
                                                                          : '없음',
                                                                      ' '),
                                                                  SecondArrive(
                                                                      _.nextShuttle.length >
                                                                              1
                                                                          ? hariRemainTime[
                                                                              1]
                                                                          : '없음',
                                                                      ' ',
                                                                      _.stationList
                                                                          .indexOf(_
                                                                              .selectedStation),
                                                                      busController.getIsNotiOn(_
                                                                              .stationList
                                                                              .indexOf(_.selectedStation) +
                                                                          30)),
                                                                  ThirdArrive(
                                                                      _.nextShuttle.length >
                                                                              2
                                                                          ? hariRemainTime[
                                                                              2]
                                                                          : '없음',
                                                                      ' ',
                                                                      _.stationList
                                                                          .indexOf(_
                                                                              .selectedStation),
                                                                      busController
                                                                          .getIsNotiOn(_.stationList.indexOf(_.selectedStation) +
                                                                              40))
                                                                ],
                                                    );
                                                  }),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () =>
                                                        UrlUtils.launchURL(
                                                            'https://www.kmou.ac.kr/kmou/cm/cntnts/cntntsView.do?mi=1418&cntntsId=328'),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          Colors.transparent,
                                                      shadowColor:
                                                          Colors.transparent,
                                                      padding: EdgeInsets.all(
                                                          SizeConfig
                                                              .sizeByHeight(
                                                                  8.5)),
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        TextBox(
                                                            '전체시간보기',
                                                            12,
                                                            FontWeight.w500,
                                                            Color(0xFF353B45)),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios_rounded,
                                                          size: SizeConfig
                                                              .sizeByHeight(12),
                                                          color:
                                                              Color(0xFF353B45),
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
                          ]),
                        ),
                      ],
                    ),
                    Positioned.fill(
                      top: SizeConfig.sizeByHeight(24),
                      child: Align(
                        alignment: Alignment.center,
                        child: Dropdown(
                          _.stationList,
                          _.selectedStation,
                          (value) {
                            ShuttleBusRepository().getNextShuttle();
                            _.setSelectedStation(value);
                          },
                          findSubTitle: findShuttleBusSubTitle,
                        ),
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}

handleBusNotification(id, remainTime, isNotiOn) async {
  if (remainTime != null && remainTime != '없음') {
    await dailyAtTimeNotification(
        id, '버스 도착 알림', '셔틀버스 도착 3분 전이에요.', (int.parse(remainTime) - 3));
    if (!isNotiOn) {
      Get.dialog(
          AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(SizeConfig.sizeByHeight(20),
                SizeConfig.sizeByHeight(20), SizeConfig.sizeByHeight(20), 0),
            content: dialog,
          ),
          transitionDuration: Duration(milliseconds: 200),
          name: '셔틀버스알림');
    }
  }
}

class FirstArrive extends StatelessWidget {
  const FirstArrive(this.remainTime, this.arriveTime, {Key? key})
      : super(key: key);

  final String? remainTime;
  final String? arriveTime;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: SizeConfig.sizeByHeight(90),
          child: Center(
            child: Image.asset(
              'assets/images/busPage/busIcon_shuttle.png',
              width: SizeConfig.sizeByHeight(90),
              height: SizeConfig.sizeByHeight(90),
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.sizeByHeight(15),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            remainTime == '없음'
                ? TextBox('운행 정보가 없어요', 18, FontWeight.w500, Color(0xFF353B45))
                : TextBox(
                    '$remainTime분 후', 30, FontWeight.w700, Color(0xFF353B45)),
            arriveTime != ' '
                ? Column(
                    children: [
                      TextBox(
                        '$arriveTime',
                        14,
                        FontWeight.w400,
                        Color(0xFF717171),
                      ),
                    ],
                  )
                : SizedBox(
                    height: SizeConfig.sizeByHeight(4),
                  ),
          ],
        ),
      ],
    );
  }
}

class SecondArrive extends StatelessWidget {
  const SecondArrive(this.remainTime, this.arriveTime, this.stationIndex,
      this.isNotificationOn,
      {Key? key})
      : super(key: key);

  final String? remainTime;
  final String? arriveTime;
  final int? stationIndex;
  final bool? isNotificationOn;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
                  30 + stationIndex!, remainTime, isNotificationOn),
              child: Image.asset(
                isNotificationOn!
                    ? 'assets/images/busPage/notiIcon_next_on.png'
                    : 'assets/images/busPage/notiIcon_next_off.png',
                width: SizeConfig.sizeByHeight(60),
                height: SizeConfig.sizeByHeight(60),
              ),
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.sizeByHeight(15),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            remainTime == '없음'
                ? TextBox('운행 정보가 없어요', 18, FontWeight.w500, Color(0xFF353B45))
                : TextBox(
                    '$remainTime분 후', 24, FontWeight.w700, Color(0xFF353B45)),
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
    );
  }
}

class ThirdArrive extends StatelessWidget {
  const ThirdArrive(this.remainTime, this.arriveTime, this.stationIndex,
      this.isNotificationOn,
      {Key? key})
      : super(key: key);

  final String? remainTime;
  final String? arriveTime;
  final int? stationIndex;
  final bool? isNotificationOn;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
                  40 + stationIndex!, remainTime, isNotificationOn),
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
          width: SizeConfig.sizeByHeight(15),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            remainTime == '없음'
                ? TextBox('운행 정보가 없어요', 18, FontWeight.w500, Color(0xFF353B45))
                : TextBox(
                    '$remainTime분 후', 18, FontWeight.w500, Color(0xFF353B45)),
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
    );
  }
}

class HomeDeparted extends StatelessWidget {
  const HomeDeparted(this.remainTime, {Key? key}) : super(key: key);

  final String? remainTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: SizeConfig.sizeByHeight(90),
          child: Center(
            child: Image.asset(
              'assets/images/busPage/busIcon_home.png',
              width: SizeConfig.sizeByHeight(50),
              height: SizeConfig.sizeByHeight(50),
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.sizeByHeight(15),
        ),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextBox(
                    int.parse(remainTime!) < 0
                        ? '학교에서 ${-1 * int.parse(remainTime!)}분 전 출발'
                        : '학교에서 $remainTime분 후 출발',
                    14,
                    FontWeight.w500,
                    Color(0xFF353B45)),
                SizedBox(
                  width: SizeConfig.sizeByWidth(10),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.sizeByHeight(5),
            )
          ],
        )
      ],
    );
  }
}
