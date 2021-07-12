import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/dailyMenu/dailyMenu_controller.dart';
import '../../common/titlebox/twolineTitle.dart';

class DailyMenuPage extends GetView<DailyMenuController> {
  final name = '식단', subname = '2층 학생식단', stat = '운영중', more = '이번주 식단 보기';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TwolineTitle(
          name: name,
          subname: subname,
          stat: stat,
          more: more,
          fontsize1: 26.0,
          fontsize2: 20.0,
          fontsize3: 12.0,
          fontweight1: FontWeight.w700,
          fontweight2: FontWeight.w500,
          fontweight3: FontWeight.w400,
        ),
        Container(
          child: Center(
            child: Text(
              "Daily Menu Page",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}