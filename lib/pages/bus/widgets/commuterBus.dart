import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/dropdown/dropdownButton.dart';
import 'package:oceanview/common/shape/circle.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/bus/commuterBus/commuterBusController.dart';

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
                              color: Color(0xFF0081FF),
                              fontSize: SizeConfig.sizeByHeight(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.sizeByHeight(65),
                        ),
                        setStationStatus(_.selectedBus)
                      ],
                    ),
                    Positioned.fill(
                      top: SizeConfig.sizeByHeight(24),
                      child: Align(
                        alignment: Alignment.center,
                        child: Dropdown(
                          controller.busList,
                          _.selectedBus,
                          (value) => _.setSelectedBus(value),
                          findTitle: findCommuterBusTitle,
                          findSubTitle: findCommuterBusSubTitle,
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
            height: SizeConfig.sizeByHeight(350),
            color: Color(0xFF4BA6FF),
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
                          Color(0xFF4BA6FF))),
                  renderCirleWithShadow(11),
                  Container(
                      width: SizeConfig.sizeByWidth(100),
                      alignment: Alignment.centerLeft,
                      child: TextBox(
                          departTime, 14, FontWeight.w700, Color(0xFF353B45)))
                ],
              ),
              getTextWidgets(stationList),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: SizeConfig.sizeByWidth(100),
                      alignment: Alignment.centerRight,
                      child: TextBox(stationList[stationList.length - 1], 14,
                          FontWeight.w700, Color(0xFF4BA6FF))),
                  renderCirleWithShadow(11),
                  Container(
                      width: SizeConfig.sizeByWidth(100),
                      alignment: Alignment.centerLeft,
                      child: TextBox(
                          arriveTime, 14, FontWeight.w700, Color(0xFF353B45)))
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
    height: SizeConfig.sizeByHeight(300),
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
          child: TextBox(value, 12, FontWeight.w400, Color(0xFF353B45))),
      renderCirleWithShadow(3),
      Container(
        width: SizeConfig.sizeByWidth(100),
      ),
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
      renderCirleWithShadow(3),
      Container(
          width: SizeConfig.sizeByWidth(100),
          alignment: Alignment.centerLeft,
          child: TextBox(value, 12, FontWeight.w400, Color(0xFF353B45)))
    ],
  );
}
