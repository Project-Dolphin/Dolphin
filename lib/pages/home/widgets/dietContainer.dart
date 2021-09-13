import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/loading/loading.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/dailyMenu/dailyMenu_controller.dart';

class DietContainer extends GetView<DailyMenuController> {
  DietContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.sizeByHeight(16),
            vertical: SizeConfig.sizeByHeight(10)),
        child: GetBuilder<DailyMenuController>(
            init: DailyMenuController(),
            builder: (_) {
              return _.isLoading
                  ? Loading()
                  : Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextBox(
                                '3층', 18, FontWeight.w400, Color(0xFF0081FF)),
                            SizedBox(
                              height: SizeConfig.sizeByHeight(1),
                            ),
                            Container(
                              width: SizeConfig.sizeByHeight(24),
                              height: 0.5,
                              color: Color(0xFF0081FF),
                            ),
                            SizedBox(
                              height: SizeConfig.sizeByHeight(6),
                            ),
                            TextBox('천원\n아침', 16, FontWeight.w700,
                                Color(0xFF0081FF)),
                          ],
                        ),
                        SizedBox(
                          width: SizeConfig.sizeByWidth(20),
                        ),
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _.societyData!.length <= 1 ||
                                        _.societyData![1].value!.length == 0
                                    ? [
                                        TextBox('식단이 없어요', 14, FontWeight.w700,
                                            Color(0xFF353B45))
                                      ]
                                    : _.societyData![1].value![0]
                                        .split(' + ')
                                        .map((e) => Padding(
                                              padding: EdgeInsets.only(
                                                  bottom:
                                                      SizeConfig.sizeByHeight(
                                                          5)),
                                              child: Text(
                                                e,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Color(0xFF353B45),
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 14 * 0.9),
                                              ),
                                            ))
                                        .toList()))
                      ],
                    );
            }));
  }
}
