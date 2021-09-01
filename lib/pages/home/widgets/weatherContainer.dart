import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/loading/loading.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/home/home_controller.dart';

class WeatherContainer extends StatelessWidget {
  const WeatherContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.sizeByHeight(14),
          horizontal: SizeConfig.sizeByHeight(20)),
      child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (_) {
            return _.currentWeather == null
                ? Loading(
                    color: Colors.white,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 180,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextBox(
                                  '오늘 해양대는', 16, FontWeight.w700, Colors.white),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Image.asset(
                                        _.currentWeather!.status!.contains('맑')
                                            ? 'assets/images/homePage/weatherIcon_sunny.png'
                                            : _.currentWeather!.status!
                                                    .contains('비')
                                                ? 'assets/images/homePage/weatherIcon_rainy.png'
                                                : 'assets/images/homePage/weatherIcon_cloudy.png',
                                        height: SizeConfig.sizeByHeight(48),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          TextBox(
                                              _.currentWeather!.temparature!,
                                              42,
                                              FontWeight.w700,
                                              Colors.white),
                                          TextBox(
                                            _.currentWeather!.status!,
                                            16,
                                            FontWeight.w400,
                                            Colors.white,
                                          ),
                                          SizedBox(
                                            height: SizeConfig.sizeByHeight(12),
                                          )
                                        ],
                                      )),
                                ],
                              )
                            ],
                          )),
                      Expanded(flex: 20, child: Container()),
                      Expanded(
                          flex: 140,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: SizeConfig.sizeByHeight(34),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/homePage/weatherIcon_wind.png',
                                          height: SizeConfig.sizeByHeight(19),
                                        ),
                                        SizedBox(
                                          height: SizeConfig.sizeByHeight(7),
                                        ),
                                        TextBox('풍속', 14, FontWeight.w400,
                                            Colors.white,
                                            textAlign: TextAlign.center)
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.sizeByHeight(13),
                                  ),
                                  TextBox(_.currentWeather!.windSpeed!, 18,
                                      FontWeight.w700, Colors.white),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.sizeByHeight(18),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: SizeConfig.sizeByHeight(34),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/homePage/weatherIcon_humidity.png',
                                          height: SizeConfig.sizeByHeight(19),
                                        ),
                                        SizedBox(
                                          height: SizeConfig.sizeByHeight(7),
                                        ),
                                        TextBox('습도', 14, FontWeight.w400,
                                            Colors.white,
                                            textAlign: TextAlign.center)
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.sizeByHeight(13),
                                  ),
                                  TextBox(_.currentWeather!.humidity!, 18,
                                      FontWeight.w700, Colors.white),
                                ],
                              ),
                            ],
                          ))
                    ],
                  );
          }),
    );
  }
}
