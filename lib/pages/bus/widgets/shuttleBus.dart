import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/dropdown/dropdownButton.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/bus/api/shuttleBusRepository.dart';
import 'package:oceanview/pages/bus/shuttleBus/shuttleBusController.dart';

class ShuttleBus extends GetView<ShuttleBusController> {
  findShuttleBusSubTitle(item) {
    return item == '하리상가' ? 'beta' : '';
  }

  @override
  Widget build(BuildContext context) {
    ShuttleBusRepository().getNextShuttle();
    return GetBuilder<ShuttleBusController>(
        init: ShuttleBusController(),
        builder: (_) {
          var remainTime = [];
          var arriveTime = [];
          for (var i = 0; i < _.nextShuttle.length; i++) {
            remainTime.add(_.nextShuttle[i]
                .difference(DateTime.now())
                .inMinutes
                .toString());
            arriveTime.add(DateFormat('HH:mm').format(_.nextShuttle[i]));
          }

          return GlassMorphism(
            width: SizeConfig.sizeByWidth(300),
            height: SizeConfig.sizeByHeight(478),
            widget: Container(
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.sizeByWidth(8),
                    horizontal: SizeConfig.sizeByHeight(16)),
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
                        _.selectedStation == '학교종점 (아치나루터)'
                            ? Column(children: [
                                BeforeArrive(),
                                Container(
                                  height: SizeConfig.sizeByHeight(280),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 1,
                                        margin: EdgeInsets.only(
                                            left: SizeConfig.sizeByWidth(40)),
                                        height: SizeConfig.sizeByHeight(290),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: <Color>[
                                                Color(0xFF339EFB)
                                                    .withOpacity(0),
                                                Color(0xFF3299F3),
                                                Color(0xFF339EFB)
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
                                        children: _.isLoading
                                            ? [Container()]
                                            : [
                                                FirstArrive(
                                                    _.nextShuttle.length > 0
                                                        ? remainTime[0]
                                                        : '없음',
                                                    _.nextShuttle.length > 0
                                                        ? arriveTime[0]
                                                        : ' '),
                                                SecondArrive(
                                                    _.nextShuttle.length > 1
                                                        ? remainTime[1]
                                                        : '없음',
                                                    _.nextShuttle.length > 1
                                                        ? arriveTime[1]
                                                        : ' '),
                                                ThirdArrive(
                                                    _.nextShuttle.length > 2
                                                        ? remainTime[2]
                                                        : '없음',
                                                    _.nextShuttle.length > 2
                                                        ? arriveTime[2]
                                                        : ' ')
                                              ],
                                      ),
                                    ],
                                  ),
                                ),
                              ])
                            : Column(
                                children: [
                                  SizedBox(
                                    height: SizeConfig.sizeByHeight(20),
                                  ),
                                  Container(
                                    height: SizeConfig.sizeByHeight(290),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 1,
                                          margin: EdgeInsets.only(
                                              left: SizeConfig.sizeByWidth(40)),
                                          height: SizeConfig.sizeByHeight(290),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: <Color>[
                                                  Color(0xFF339EFB)
                                                      .withOpacity(0),
                                                  Color(0xFF3299F3),
                                                  Color(0xFF339EFB)
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
                                            HomeDeparted(remainTime[0]),
                                            FirstArrive(
                                                (int.parse(remainTime[0]) + 6)
                                                    .toString(),
                                                ' '),
                                            SecondArrive(
                                                (int.parse(remainTime[1]) + 6)
                                                    .toString(),
                                                ' '),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: SizeConfig.sizeByHeight(10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: EdgeInsets.all(
                                      SizeConfig.sizeByHeight(8.5)),
                                ),
                                child: Row(
                                  children: [
                                    TextBox('전체시간보기', 12, FontWeight.w500,
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
                            Dropdown(
                              _.stationList,
                              _.selectedStation,
                              (value) {
                                value == '학교종점 (아치나루터)'
                                    ? ShuttleBusRepository().getNextShuttle()
                                    : () {};
                                _.setSelectedStation(value);
                              },
                              findSubTitle: findShuttleBusSubTitle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}

class BeforeArrive extends StatelessWidget {
  const BeforeArrive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: SizeConfig.sizeByHeight(5)),
            width: SizeConfig.sizeByWidth(80),
            child: TextBox('이전차', 14, FontWeight.w500, Color(0xFF717171))),
        SizedBox(
          width: SizeConfig.sizeByWidth(15),
        ),
        TextBox('약 3분전 출발', 12, FontWeight.w500, Color(0xFF3F3F3F))
      ],
    );
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
      children: [
        Container(
          width: SizeConfig.sizeByWidth(80),
          child: Center(
            child: Image.asset(
              'assets/images/busPage/busIcon_shuttle.png',
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            remainTime == '없음'
                ? TextBox('다음 차가 없습니다.', 18, FontWeight.w700, Color(0xFF3F3F3F))
                : TextBox('약 ${remainTime != null ? remainTime : '300'}분', 28,
                    FontWeight.w700, Color(0xFF3F3F3F)),
            arriveTime != ' '
                ? Column(
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

class SecondArrive extends StatelessWidget {
  const SecondArrive(this.remainTime, this.arriveTime, {Key? key})
      : super(key: key);

  final String? remainTime;
  final String? arriveTime;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: SizeConfig.sizeByWidth(80),
          child: Center(
            child: Image.asset(
              'assets/images/busPage/notiIcon_next.png',
              width: SizeConfig.sizeByHeight(60),
              height: SizeConfig.sizeByHeight(60),
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
                ? TextBox('다음 차가 없습니다.', 18, FontWeight.w700, Color(0xFF3F3F3F))
                : TextBox('약 ${remainTime != null ? remainTime : '300'}분', 22,
                    FontWeight.w700, Color(0xFF3F3F3F)),
            arriveTime != ' '
                ? TextBox(
                    '$arriveTime',
                    14,
                    FontWeight.w500,
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
  const ThirdArrive(this.remainTime, this.arriveTime, {Key? key})
      : super(key: key);

  final String? remainTime;
  final String? arriveTime;
  @override
  Widget build(BuildContext context) {
    return Row(
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
                ? TextBox('다음 차가 없습니다.', 18, FontWeight.w700, Color(0xFF3F3F3F))
                : TextBox('약 ${remainTime != null ? remainTime : '300'}분', 18,
                    FontWeight.w500, Color(0xFF3F3F3F)),
            arriveTime != ' '
                ? Column(
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
      children: [
        Container(
          width: SizeConfig.sizeByWidth(80),
          child: Center(
            child: Image.asset(
              'assets/images/busPage/busIcon_home.png',
              width: SizeConfig.sizeByHeight(50),
              height: SizeConfig.sizeByHeight(50),
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.sizeByWidth(15),
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
                    Color(0xFF3F3F3F)),
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
