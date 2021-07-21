import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/container/glassMorphism.dart';
import 'package:getx_app/common/dropdown/dropdownButton.dart';
import 'package:getx_app/common/sizeConfig.dart';
import 'package:getx_app/common/text/textBox.dart';
import 'package:getx_app/pages/bus/bus_controller.dart';

class ShuttleBus extends StatefulWidget {
  @override
  _ShuttleBusState createState() => _ShuttleBusState();
}

class _ShuttleBusState extends State<ShuttleBus> {
  final stationList = [
    '학교종점 (아치나루터)',
    '하리상가',
  ];
  var selectedStation = '학교종점 (아치나루터)';
  bool isDropdownOpen = false;

  findShuttleBusSubTitle(item) {
    return item == '하리상가' ? 'beta' : '';
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusController>(
        init: BusController(),
        builder: (_) {
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
                        selectedStation == '학교종점 (아치나루터)'
                            ? Column(children: [
                                BeforeArrive(),
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
                                          FirstArrive('4분 52초', '21:23'),
                                          SecondArrive('4분 52초', '21:23'),
                                          ThirdArrive('4분 52초', '21:23'),
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
                                            HomeDeparted('학교에서 2분전 출발'),
                                            FirstArrive('약 4분', ''),
                                            SecondArrive('약 7분', ''),
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
                              stationList,
                              selectedStation,
                              (value) => setState(() {
                                selectedStation = value;
                              }),
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
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextBox(remainTime!, 28, FontWeight.w700, Color(0xFF3F3F3F)),
                SizedBox(
                  width: SizeConfig.sizeByWidth(10),
                ),
                arriveTime != ''
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextBox(
                            arriveTime!,
                            14,
                            FontWeight.w500,
                            Color(0xFF717171),
                          ),
                          SizedBox(
                            height: SizeConfig.sizeByHeight(6),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
            SizedBox(
              height: SizeConfig.sizeByHeight(10),
            )
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
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextBox(remainTime!, 22, FontWeight.w700, Color(0xFF3F3F3F)),
                SizedBox(
                  width: SizeConfig.sizeByWidth(10),
                ),
                arriveTime != ''
                    ? Column(
                        children: [
                          TextBox(
                            arriveTime!,
                            14,
                            FontWeight.w500,
                            Color(0xFF717171),
                          ),
                          SizedBox(
                            height: SizeConfig.sizeByHeight(3),
                          ),
                        ],
                      )
                    : Container(),
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
              width: SizeConfig.sizeByWidth(30),
              height: SizeConfig.sizeByWidth(30),
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
                TextBox(remainTime!, 18, FontWeight.w500, Color(0xFF3F3F3F)),
                SizedBox(
                  width: SizeConfig.sizeByWidth(10),
                ),
                arriveTime != ''
                    ? Column(
                        children: [
                          TextBox(
                            arriveTime!,
                            14,
                            FontWeight.w500,
                            Color(0xFF717171),
                          ),
                          SizedBox(
                            height: SizeConfig.sizeByHeight(2),
                          ),
                        ],
                      )
                    : Container(),
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
              width: SizeConfig.sizeByWidth(50),
              height: SizeConfig.sizeByWidth(50),
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
                TextBox(remainTime!, 14, FontWeight.w500, Color(0xFF3F3F3F)),
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
