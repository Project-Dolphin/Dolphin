import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/titlebox/onelineTitle.dart';
import 'package:oceanview/pages/bus/cityBus/cityBusController.dart';
import 'package:oceanview/pages/dashboard/dashboard_controller.dart';
import 'package:oceanview/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/pages/home/notice/noticeRepository.dart';
import 'package:oceanview/pages/home/widgets/busContainer.dart';
import 'package:oceanview/pages/home/widgets/noticeContainer.dart';

class HomePage extends GetView<HomeController> {
  final name = '오션뷰';
  final Color iconColor = Color(0xFF000000);

  Future<Null> onRefresh() async {
    Get.put(CityBusController());
    // Get.find<CityBusController>().findNextDepartCityBus();
    await NoticeRepository().getNotice();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.put(DashboardController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          child: Container(
            height: SizeConfig.sizeByHeight(675),
            margin:
                EdgeInsets.symmetric(horizontal: SizeConfig.sizeByHeight(14)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<HomeController>(
                    builder: (_) =>
                        // OnelineTitle(
                        //       name: name,
                        //       description: controller.formattedDate,
                        //       stat: controller.stat,
                        //       fontsize1: SizeConfig.sizeByHeight(26),
                        //       fontsize2: SizeConfig.sizeByHeight(14),
                        //       fontsize3: SizeConfig.sizeByHeight(12),
                        //       fontweight1: FontWeight.w700,
                        //       fontweight2: FontWeight.w400,
                        //       fontweight3: FontWeight.w500,
                        //       isGradient: true,
                        //     )
                        Container(
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.sizeByHeight(12)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MainTitle(
                                title: 'OceanView',
                                fontsize: SizeConfig.sizeByHeight(26),
                                fontweight: FontWeight.w700,
                                isGradient: true,
                                fontFamily: 'Pretendard',
                              ),
                              Row(
                                children: [
                                  SubText(
                                    description: _.formattedDate,
                                    fontsize: SizeConfig.sizeByHeight(14),
                                    fontweight: FontWeight.w400,
                                    fontFamily: 'Pretendard',
                                  ),
                                  StatusContainer(
                                    stat: _.stat,
                                    fontsize: SizeConfig.sizeByHeight(12),
                                    fontweight: FontWeight.w500,
                                    fontFamily: 'Pretendard',
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
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 11,
                                      spreadRadius: 0,
                                      offset: Offset(0, 0),
                                      color: Color(0x6E0068FF))
                                ]),
                            child: Container(),
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
                              Expanded(flex: 163, child: GlassMorphism())
                            ],
                          )),
                      Expanded(flex: 12, child: Container()),
                      Expanded(flex: 80, child: GlassMorphism()),
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
    );
  }
}
