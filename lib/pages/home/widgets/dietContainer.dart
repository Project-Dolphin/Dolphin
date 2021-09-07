import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/loading/loading.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/dailyMenu/dailyMenu_controller.dart';
import 'package:oceanview/pages/dailyMenu/infoMenu/menu_information.dart';
import 'package:oceanview/pages/home/home_controller.dart';

class DietContainer extends StatelessWidget {
  DietContainer({Key? key}) : super(key: key);

  final controller = Get.put(DailyMenuController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.sizeByHeight(16),
            vertical: SizeConfig.sizeByHeight(10)),
        child: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (_) {
              return controller.isLoading
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
                          width: SizeConfig.sizeByHeight(14),
                        ),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            controller.societyData![1].value!.length == 0
                                ? TextBox('식단이 없어요', 14, FontWeight.w700,
                                    Color(0xFF353B45))
                                : Text('${controller.societyData![1].value}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Color(0xFF353B45),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14 * 0.9),
                                    maxLines: 7)
                          ],
                        ))
                      ],
                    );
            }));
  }
}
