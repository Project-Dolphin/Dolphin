import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/container/glassMorphism.dart';
import 'package:getx_app/common/dialog/dialog.dart';
import 'package:getx_app/common/dropdown/dropdownButton.dart';
import 'package:getx_app/common/icon/gradientIcon.dart';
import 'package:getx_app/common/sizeConfig.dart';
import 'package:getx_app/common/text/textBox.dart';
import 'package:getx_app/pages/bus/cityBus/cityBusController.dart';
import 'package:getx_app/pages/bus/stationData.dart';
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            : print('해양대구본관');

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
  const FirstArrive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CityBusController>(
        init: CityBusController(),
        builder: (_) {
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
                                _.isLoading
                                    ? SpinKitThreeBounce(
                                        color: Colors.lightBlue,
                                        size: SizeConfig.sizeByHeight(30),
                                      )
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          TextBox(
                                              '약 ${_.responseCityBus != null ? _.responseCityBus!.min1 : 300}분',
                                              28,
                                              FontWeight.w700,
                                              Color(0xFF3F3F3F)),
                                          SizedBox(
                                            width: SizeConfig.sizeByWidth(10),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextBox(
                                                '${_.responseCityBus != null ? DateFormat('HH:mm').format(DateTime.now().add(Duration(minutes: int.parse(_.responseCityBus!.min1)))) : 'error'}',
                                                14,
                                                FontWeight.w500,
                                                Color(0xFF717171),
                                              ),
                                              SizedBox(
                                                height:
                                                    SizeConfig.sizeByHeight(6),
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
        });
  }
}

class SecondArrive extends StatelessWidget {
  const SecondArrive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CityBusController>(
        init: CityBusController(),
        builder: (_) {
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
                      _.isLoading
                          ? SpinKitThreeBounce(
                              color: Colors.lightBlue,
                              size: SizeConfig.sizeByHeight(30),
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextBox(
                                    '약 ${_.responseCityBus != null ? _.responseCityBus?.min2 : '300'}분',
                                    22,
                                    FontWeight.w700,
                                    Color(0xFF3F3F3F)),
                                SizedBox(
                                  width: SizeConfig.sizeByWidth(10),
                                ),
                                Column(
                                  children: [
                                    TextBox(
                                      '${_.responseCityBus != null ? DateFormat('HH:mm').format(DateTime.now().add(Duration(minutes: int.parse(_.responseCityBus!.min2)))) : 'error'}',
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
        });
  }
}

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
                  width: SizeConfig.sizeByHeight(30),
                  height: SizeConfig.sizeByHeight(30),
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
