import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/container/glassMorphism.dart';
import 'package:getx_app/common/dropdown/dropdownButton.dart';
import 'package:getx_app/common/icon/gradientIcon.dart';
import 'package:getx_app/common/sizeConfig.dart';
import 'package:getx_app/common/text/textBox.dart';
import 'package:getx_app/pages/bus/bus_controller.dart';
import 'package:getx_app/pages/bus/stationData.dart';

class CityBus extends StatefulWidget {
  @override
  _CityBusState createState() => _CityBusState();
}

class _CityBusState extends State<CityBus> {
  final stationList = ['주변정류장', '해양대구본관', '부산역', '영도대교'];
  var selectedStation = '주변정류장';
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<BusController>(
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
                              height: SizeConfig.sizeByHeight(6),
                            ),
                            SizedBox(
                              height: SizeConfig.sizeByHeight(45),
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
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FirstArrive(),
                                      SecondArrive(),
                                      ThirdArrive(),
                                    ],
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
                                      padding: EdgeInsets.all(
                                          SizeConfig.sizeByHeight(8.5)),
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
                          left: SizeConfig.sizeByWidth(28),
                          child:
                              Dropdown(stationList, selectedStation, (value) {
                            setState(() {
                              selectedStation = value;
                            });
                            findNearStation();
                          }),
                        ),
                      ],
                    )),
              );
            }),
      ],
    );
  }
}

class FirstArrive extends StatelessWidget {
  const FirstArrive({Key? key}) : super(key: key);

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
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextBox('4분 52초', 28, FontWeight.w700,
                                  Color(0xFF3F3F3F)),
                              SizedBox(
                                width: SizeConfig.sizeByWidth(10),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextBox(
                                    '21:45',
                                    14,
                                    FontWeight.w500,
                                    Color(0xFF717171),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.sizeByHeight(6),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.sizeByHeight(25),
                          )
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
  const SecondArrive({Key? key}) : super(key: key);

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
                  onPressed: () {
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
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextBox('4분 52초', 22, FontWeight.w700, Color(0xFF3F3F3F)),
                    SizedBox(
                      width: SizeConfig.sizeByWidth(10),
                    ),
                    Column(
                      children: [
                        TextBox(
                          '21:45',
                          14,
                          FontWeight.w500,
                          Color(0xFF717171),
                        ),
                        SizedBox(
                          height: SizeConfig.sizeByHeight(3),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.sizeByHeight(5),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}

Widget dialog = Container(
  width: SizeConfig.sizeByWidth(300),
  height: SizeConfig.sizeByHeight(210),
  child: Center(
    child: Column(
      children: [
        GradientIcon(
          ImageIcon(AssetImage('assets/images/bottomNavigationIcon/bus.png'),
              size: SizeConfig.sizeByHeight(40)),
          LinearGradient(
              colors: <Color>[
                Color(0xFF009DF5),
                Color(0xFF1E7AFF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        SizedBox(
          height: SizeConfig.sizeByHeight(15),
        ),
        TextBox('버스 도착 3분전 알림', 20, FontWeight.w700, Colors.black),
        SizedBox(
          height: SizeConfig.sizeByHeight(10),
        ),
        TextBox('다음차가 도착하기 3분전', 14, FontWeight.w400, Colors.black),
        TextBox('푸시 알림을 보내드려요', 14, FontWeight.w400, Colors.black),
        SizedBox(height: SizeConfig.sizeByHeight(27)),
        Container(
          width: SizeConfig.sizeByWidth(200),
          height: 0.5,
          color: Color(0xffC4C4C4),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            onPressed: () => Get.back(),
            child: TextBox('확인', 18, FontWeight.w400, Colors.black))
      ],
    ),
  ),
);

class ThirdArrive extends StatelessWidget {
  const ThirdArrive({Key? key}) : super(key: key);

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
                    TextBox('4분 52초', 18, FontWeight.w500, Color(0xFF3F3F3F)),
                    SizedBox(
                      width: SizeConfig.sizeByWidth(10),
                    ),
                    Column(
                      children: [
                        TextBox(
                          '21:45',
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
                SizedBox(
                  height: SizeConfig.sizeByHeight(5),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
