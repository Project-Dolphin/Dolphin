import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:OceanView/common/container/glassMorphism.dart';
import 'package:OceanView/common/dropdown/dropdownButton.dart';
import 'package:OceanView/common/shape/circle.dart';
import 'package:OceanView/common/sizeConfig.dart';
import 'package:OceanView/common/text/textBox.dart';
import 'package:OceanView/pages/bus/commuterBus/commuterBusController.dart';

class CommuterBus extends GetView<CommuterBusController> {
  findCommuterBusTitle(item) {
    return item.contains('출근')
        ? item.replaceFirst(' 출근', '')
        : item.contains('퇴근')
            ? item.replaceFirst(' 퇴근', '')
            : item;
  }

  findCommuterBusSubTitle(item) {
    return item.contains('출근')
        ? '출근'
        : item.contains('퇴근')
            ? '퇴근'
            : '';
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommuterBusController>(
        init: CommuterBusController(),
        builder: (_) {
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
                            '버스 선택',
                            style: TextStyle(
                              color: Color(0xff005A9E),
                              fontSize: SizeConfig.sizeByHeight(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.sizeByHeight(55),
                        ),
                        setStationStatus(_.selectedBus)
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
                              controller.busList,
                              _.selectedBus,
                              (value) => _.setSelectedBus(value),
                              findTitle: findCommuterBusTitle,
                              findSubTitle: findCommuterBusSubTitle,
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

  setStationStatus(selectedBus) {
    if (selectedBus == '통근 버스 1호 출근') {
      return renderStationStatus(controller.stationList_1[0], '07:25', '08:50');
    } else if (selectedBus == '통근 버스 2호 출근') {
      return renderStationStatus(controller.stationList_2[0], '07:58', '08:45');
    } else if (selectedBus == '통근 버스 3호 출근') {
      return renderStationStatus(controller.stationList_3[0], '07:35', '08:50');
    } else if (selectedBus == '통근 버스 1호 퇴근') {
      return renderStationStatus(controller.stationList_1[1], '18:10', ' ');
    } else if (selectedBus == '통근 버스 2호 퇴근') {
      return renderStationStatus(controller.stationList_2[1], '18:10', ' ');
    } else if (selectedBus == '통근 버스 3호 퇴근') {
      return renderStationStatus(controller.stationList_3[1], '18:10', ' ');
    }
  }

  renderStationStatus(
      List<String> stationList, String departTime, String arriveTime) {
    return Stack(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(top: SizeConfig.sizeByHeight(11)),
            width: 1,
            height: SizeConfig.sizeByHeight(320),
            color: Color(0xFF339EFB),
          ),
        ),
        Container(
          height: SizeConfig.sizeByHeight(368),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: SizeConfig.sizeByWidth(100),
                      alignment: Alignment.centerRight,
                      child: TextBox(stationList[0], 14, FontWeight.w700,
                          Color(0xFF0797F8))),
                  renderCirleWithShadow(11),
                  Container(
                      width: SizeConfig.sizeByWidth(100),
                      alignment: Alignment.centerLeft,
                      child: TextBox(
                          departTime, 14, FontWeight.w700, Color(0xff3F3F3F)))
                ],
              ),
              SizedBox(
                height: SizeConfig.sizeByHeight(10),
              ),
              getTextWidgets(stationList),
              SizedBox(
                height: SizeConfig.sizeByHeight(15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: SizeConfig.sizeByWidth(80),
                      alignment: Alignment.centerRight,
                      child: TextBox(stationList[stationList.length - 1], 14,
                          FontWeight.w700, Color(0xFF0797F8))),
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.sizeByWidth(14)),
                      child: Image.asset(
                        'assets/images/busPage/busIcon_home.png',
                        width: SizeConfig.sizeByHeight(40),
                        height: SizeConfig.sizeByHeight(40),
                      )),
                  Container(
                      width: SizeConfig.sizeByWidth(80),
                      alignment: Alignment.centerLeft,
                      child: TextBox(
                          arriveTime, 14, FontWeight.w700, Color(0xff3F3F3F)))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

Widget getTextWidgets(List<String> stationList) {
  var i = 0;
  return Container(
    height: SizeConfig.sizeByHeight(280),
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
          width: SizeConfig.sizeByWidth(100),
          alignment: Alignment.centerRight,
          child: TextBox(value, 12, FontWeight.w500, Colors.black)),
      Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.sizeByWidth(10)),
        width: SizeConfig.sizeByHeight(11),
        height: SizeConfig.sizeByHeight(11),
      ),
      Container(
        width: SizeConfig.sizeByWidth(100),
      )
    ],
  );
}

Widget renderRightSide(String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: SizeConfig.sizeByWidth(100),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.sizeByWidth(10)),
        width: SizeConfig.sizeByHeight(11),
        height: SizeConfig.sizeByHeight(11),
      ),
      Container(
          width: SizeConfig.sizeByWidth(100),
          alignment: Alignment.centerLeft,
          child: TextBox(value, 12, FontWeight.w500, Colors.black))
    ],
  );
}
