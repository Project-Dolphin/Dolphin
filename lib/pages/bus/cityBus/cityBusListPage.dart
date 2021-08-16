import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:oceanview/common/shape/circle.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/bus/api/cityBusRepository.dart';
import 'package:oceanview/pages/bus/cityBus/cityBusController.dart';
import 'package:oceanview/pages/bus/stationData.dart';

var stationList = [...station_190.map((e) => e['nodeName'].toString())];

class CityBusListPage extends GetView<CityBusController> {
  const CityBusListPage({Key? key}) : super(key: key);

  Future<Null> onRefresh() async {
    await CityBusRepository().getCityBusList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: RefreshIndicator(
              onRefresh: onRefresh,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    floating: true,
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.white.withOpacity(0.4),
                    iconTheme: IconThemeData(color: Color(0xFF3199FF)),
                    title: Text(
                      '190번 버스',
                      style: TextStyle(
                          color: Color(0xFF353B45),
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.sizeByHeight(16)),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.sizeByHeight(24),
                              horizontal: SizeConfig.sizeByHeight(10)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/busPage/busIcon_190.png',
                                width: SizeConfig.sizeByHeight(90),
                                height: SizeConfig.sizeByHeight(90),
                              ),
                              SizedBox(
                                width: SizeConfig.sizeByHeight(6),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextBox('운행시간', 12, FontWeight.w400,
                                          Color(0xFF0081FF)),
                                      SizedBox(
                                          width: SizeConfig.sizeByHeight(7)),
                                      TextBox('04:55 ~ 21:50', 14,
                                          FontWeight.w400, Color(0xFF353B45)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.sizeByHeight(10),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextBox('배차간격', 12, FontWeight.w400,
                                          Color(0xFF0081FF)),
                                      SizedBox(
                                          width: SizeConfig.sizeByHeight(7)),
                                      TextBox('19분', 14, FontWeight.w400,
                                          Color(0xFF353B45)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        GetBuilder<CityBusController>(
                            init: CityBusController(),
                            builder: (_) {
                              return Container(
                                height: SizeConfig.sizeByHeight(3600),
                                child: _.responseCityBusList != []
                                    ? renderStationStatus(
                                        stationList, _.responseCityBusList)
                                    : SpinKitCircle(
                                        color: Colors.blue,
                                        size: SizeConfig.sizeByHeight(50),
                                      ),
                              );
                            }),
                        SizedBox(
                          height: SizeConfig.sizeByHeight(50),
                        )
                      ],
                    );
                  }, childCount: 1))
                ],
              )),
        ));
  }

  renderStationStatus(
      List<String> stationList, List<CityBusListData>? busList) {
    var busListIndex = [];
    busList!.forEach((e) => {
          if (station_190
                  .indexWhere((element) => element['nodeId'] == e.nodeId) !=
              -1)
            {
              busListIndex.add([
                station_190
                    .indexWhere((element) => element['nodeId'] == e.nodeId),
                e.carNo
              ])
            }
        });

    return Stack(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(
                top: SizeConfig.sizeByHeight(50),
                bottom: SizeConfig.sizeByHeight(50)),
            width: 1,
            height: double.infinity,
            color: Color(0xFF4BA6FF),
          ),
        ),
        Container(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  width: SizeConfig.sizeByWidth(100),
                  margin: EdgeInsets.only(top: SizeConfig.sizeByHeight(13)),
                  alignment: Alignment.center,
                  child: TextBox(
                      stationList[0], 14, FontWeight.w500, Color(0xFF353B45))),
              renderCirleWithShadow(11),
              getTextWidgets(stationList),
              renderCirleWithShadow(11),
              Container(
                  width: SizeConfig.sizeByWidth(80),
                  alignment: Alignment.center,
                  child: TextBox(stationList[stationList.length - 1], 14,
                      FontWeight.w500, Color(0xFF353B45))),
            ],
          ),
        ),
        ...busListIndex.map((e) => Container(
            margin: EdgeInsets.only(
                top: (e[0] + 1) * SizeConfig.sizeByHeight(49) -
                    SizeConfig.sizeByHeight(26)),
            width: double.infinity,
            height: SizeConfig.sizeByHeight(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: SizeConfig.sizeByHeight(100),
                ),
                Image.asset(
                  'assets/images/busPage/busIcon_190.png',
                  width: SizeConfig.sizeByHeight(32),
                  height: SizeConfig.sizeByHeight(32),
                ),
                Container(
                  width: SizeConfig.sizeByHeight(100),
                  // child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     TextBox(e[1], 12, FontWeight.w400, Color(0xFF353B45)),
                  //   ],
                  // ),
                ),
              ],
            )))
      ],
    );
  }

  Widget getTextWidgets(List<String> stationList) {
    var i = 0;
    return Container(
      height: SizeConfig.sizeByHeight(3450),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: stationList.map((item) {
            i++;
            if (i == 1 || i == stationList.length) {
              return Container();
            } else if (i % 2 == 0) {
              return renderLeftSide(item);
            } else {
              return renderRightSide(item);
            }
          }).toList()),
    );
  }

  Widget renderLeftSide(String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: SizeConfig.sizeByWidth(150),
            alignment: Alignment.centerRight,
            child: TextBox(value, 14, FontWeight.w500, Color(0xFF353B45))),
        renderCirleWithShadow(5),
        Container(
          width: SizeConfig.sizeByWidth(150),
        ),
      ],
    );
  }

  Widget renderRightSide(String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: SizeConfig.sizeByWidth(150),
        ),
        renderCirleWithShadow(5),
        Container(
            width: SizeConfig.sizeByWidth(150),
            alignment: Alignment.centerLeft,
            child: TextBox(value, 14, FontWeight.w500, Color(0xFF353B45)))
      ],
    );
  }
}
