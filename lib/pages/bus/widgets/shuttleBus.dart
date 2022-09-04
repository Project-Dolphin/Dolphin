import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/dialog/dialog.dart';
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
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '정류장',
                        style: TextStyle(
                          color: Color(0xFF0081FF),
                          fontSize: 10,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.sizeByHeight(12),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: SizeConfig.sizeByWidth(200),
                        height: SizeConfig.sizeByHeight(35),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xFFFBFBFB),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 6),
                              blurRadius: 20,
                              spreadRadius: -5,
                              color: Color(0xFFA9A9A9).withOpacity(0.21),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextBox(
                                '학교종점', 16, FontWeight.w700, Color(0xff3f3f3f))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.sizeByHeight(16),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: SizeConfig.sizeByHeight(10)),
                      child: Column(children: [
                        SizedBox(
                          height: SizeConfig.sizeByHeight(14),
                        ),
                        SizedBox(
                          height: SizeConfig.sizeByHeight(10),
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
                                                    children: [
                                                      FirstArrive(
                                                        _.nextShuttle.length > 0
                                                            ? _.nextShuttle[0]
                                                                .remainMinutes
                                                                .toString()
                                                            : '없음',
                                                        _.nextShuttle.length > 0
                                                            ? _.nextShuttle[0]
                                                                .time
                                                            : ' ',
                                                        _.nextShuttle.length > 0
                                                            ? _.nextShuttle[0]
                                                                .destination
                                                            : ' ',
                                                      ),
                                                      SecondArrive(
                                                          _.nextShuttle.length >
                                                                  1
                                                              ? _.nextShuttle[1]
                                                                  .remainMinutes
                                                                  .toString()
                                                              : '없음',
                                                          _.nextShuttle.length >
                                                                  1
                                                              ? _.nextShuttle[1]
                                                                  .time
                                                              : ' ',
                                                          _.nextShuttle.length >
                                                                  1
                                                              ? _.nextShuttle[1]
                                                                  .destination
                                                              : ' ',
                                                          busController
                                                              .getIsNotiOn(30)),
                                                      ThirdArrive(
                                                          _.nextShuttle.length >
                                                                  2
                                                              ? _.nextShuttle[2]
                                                                  .remainMinutes
                                                                  .toString()
                                                              : '없음',
                                                          _.nextShuttle.length >
                                                                  2
                                                              ? _.nextShuttle[2]
                                                                  .time
                                                              : ' ',
                                                          _.nextShuttle.length >
                                                                  2
                                                              ? _.nextShuttle[2]
                                                                  .destination
                                                              : ' ',
                                                          busController
                                                              .getIsNotiOn(40))
                                                    ]);
                                              }),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () => UrlUtils.launchURL(
                                                    'https://www.kmou.ac.kr/kmou/cm/cntnts/cntntsView.do?mi=1418&cntntsId=328'),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.transparent,
                                                  shadowColor:
                                                      Colors.transparent,
                                                  padding: EdgeInsets.all(
                                                      SizeConfig.sizeByHeight(
                                                          8.5)),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
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
                      ]),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
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
  const FirstArrive(this.remainTime, this.arriveTime, this.destination,
      {Key? key})
      : super(key: key);

  final String? remainTime;
  final String? arriveTime;
  final String? destination;
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
                : int.parse(remainTime!) > 0
                    ? TextBox('$remainTime분 후', 30, FontWeight.w700,
                        Color(0xFF353B45))
                    : TextBox('곧 도착', 30, FontWeight.w700, Color(0xFF353B45)),
            arriveTime != ' '
                ? Padding(
                    padding: EdgeInsets.only(top: SizeConfig.sizeByHeight(4)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            TextBox(
                              '$arriveTime',
                              14,
                              FontWeight.w400,
                              Color(0xFF717171),
                            ),
                            SizedBox(
                              width: SizeConfig.sizeByHeight(8),
                            ),
                            destination != '하리'
                                ? TextBox(
                                    '$destination',
                                    14,
                                    FontWeight.w700,
                                    Color(0xFF4BA6FF),
                                  )
                                : Container(),
                          ],
                        )
                      ],
                    ),
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
  const SecondArrive(
      this.remainTime, this.arriveTime, this.destination, this.isNotificationOn,
      {Key? key})
      : super(key: key);

  final String? remainTime;
  final String? arriveTime;
  final String? destination;
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
              onPressed: () =>
                  handleBusNotification(30, remainTime, isNotificationOn),
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
                ? Padding(
                    padding: EdgeInsets.only(top: SizeConfig.sizeByHeight(4)),
                    child: Row(
                      children: [
                        TextBox(
                          '$arriveTime',
                          14,
                          FontWeight.w400,
                          Color(0xFF717171),
                        ),
                        SizedBox(
                          width: SizeConfig.sizeByHeight(8),
                        ),
                        destination != '하리'
                            ? TextBox(
                                '$destination',
                                14,
                                FontWeight.w700,
                                Color(0xFF4BA6FF),
                              )
                            : Container(),
                      ],
                    ),
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
  const ThirdArrive(
      this.remainTime, this.arriveTime, this.destination, this.isNotificationOn,
      {Key? key})
      : super(key: key);

  final String? remainTime;
  final String? arriveTime;
  final String? destination;
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
              onPressed: () =>
                  handleBusNotification(40, remainTime, isNotificationOn),
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
                    '$remainTime분 후', 18, FontWeight.w700, Color(0xFF353B45)),
            arriveTime != ' '
                ? Padding(
                    padding: EdgeInsets.only(top: SizeConfig.sizeByHeight(4)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            TextBox(
                              '$arriveTime',
                              14,
                              FontWeight.w400,
                              Color(0xFF717171),
                            ),
                            SizedBox(
                              width: SizeConfig.sizeByHeight(8),
                            ),
                            destination != '하리'
                                ? TextBox(
                                    '$destination',
                                    14,
                                    FontWeight.w700,
                                    Color(0xFF4BA6FF),
                                  )
                                : Container(),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.sizeByHeight(2),
                        ),
                      ],
                    ),
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
