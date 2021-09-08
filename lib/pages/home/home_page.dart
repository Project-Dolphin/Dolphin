import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/titlebox/onelineTitle.dart';
import 'package:oceanview/pages/bus/api/cityBusRepository.dart';
import 'package:oceanview/pages/dailyMenu/api/dailyMenu_repository.dart';
import 'package:oceanview/pages/dashboard/dashboard_controller.dart';
import 'package:oceanview/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/pages/home/latestEvent/eventRepository.dart';
import 'package:oceanview/pages/home/notice/noticeRepository.dart';
import 'package:oceanview/pages/home/weather/weatherRepository.dart';
import 'package:oceanview/pages/home/widgets/dietContainer.dart';
import 'package:oceanview/pages/home/widgets/eventsContainer.dart';
import 'package:oceanview/pages/home/widgets/busContainer.dart';
import 'package:oceanview/pages/home/widgets/noticeContainer.dart';
import 'package:oceanview/pages/home/widgets/weatherContainer.dart';

Future<Null> onRefresh() async {
  await CityBusRepository().getNextDepartCityBus();
  await NoticeRepository().getNotice();
  await EventRespository().getLatestEventList();
  await WeatherRepository().getCurrentWeather();
  await DailyMenuRepository().getSociety();
}

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.put(DashboardController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            child: Container(
              height: SizeConfig.blockSizeVertical > 7
                  ? SizeConfig.blockSizeVertical * 83
                  : SizeConfig.blockSizeVertical * 86,
              margin:
                  EdgeInsets.symmetric(horizontal: SizeConfig.sizeByHeight(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<HomeController>(
                      builder: (_) => Container(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.sizeByHeight(14)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MainTitle(
                                  title: 'OceanView',
                                  fontsize: SizeConfig.sizeByHeight(26),
                                  fontweight: FontWeight.w700,
                                  isGradient: true,
                                ),
                                Row(
                                  children: [
                                    SubText(
                                      description: _.formattedDate,
                                      fontsize: SizeConfig.sizeByHeight(14),
                                      fontweight: FontWeight.w400,
                                    ),
                                    StatusContainer(
                                      stat: _.stat,
                                      fontsize: SizeConfig.sizeByHeight(12),
                                      fontweight: FontWeight.w400,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                            flex: 134,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xCC1E7AFF),
                                      Color(0xCC009DF5),
                                    ],
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              child: WeatherContainer(),
                            )),
                        Expanded(flex: 12, child: Container()),
                        Expanded(
                            flex: 154,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 163,
                                    child: GestureDetector(
                                      onTap: () =>
                                          dashboardController.changeTabIndex(1),
                                      child: GlassMorphism(
                                        widget: BusContainer(),
                                      ),
                                    )),
                                Expanded(flex: 14, child: Container()),
                                Expanded(
                                    flex: 163,
                                    child: GestureDetector(
                                        onTap: () => dashboardController
                                            .changeTabIndex(2),
                                        child: GlassMorphism(
                                          widget: DietContainer(),
                                        )))
                              ],
                            )),
                        Expanded(flex: 12, child: Container()),
                        Expanded(
                            flex: 80,
                            child: GestureDetector(
                                onTap: () =>
                                    dashboardController.changeTabIndex(3),
                                child: GlassMorphism(
                                  widget: EventsContainer(),
                                ))),
                        Expanded(flex: 12, child: Container()),
                        Expanded(
                            flex: 190,
                            child: GlassMorphism(
                              widget: NoticeContainer(),
                            )),
                        Expanded(flex: 25, child: Container()),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
