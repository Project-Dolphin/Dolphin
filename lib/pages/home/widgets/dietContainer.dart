import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/home/home_controller.dart';

class DietContainer extends StatelessWidget {
  const DietContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.sizeByHeight(16),
            vertical: SizeConfig.sizeByHeight(10)),
        child: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (_) {
              return Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextBox('2층', 18, FontWeight.w400, Color(0xFF0081FF)),
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
                      TextBox('점심', 16, FontWeight.w700, Color(0xFF0081FF)),
                    ],
                  ),
                  SizedBox(
                    width: SizeConfig.sizeByHeight(14),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextBox(
                          '식단이 없어요', 14, FontWeight.w400, Color(0xFF353B45)),
                    ],
                  )
                ],
              );
            }));
  }
}
