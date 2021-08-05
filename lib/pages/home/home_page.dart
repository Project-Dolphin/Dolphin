import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/common/titlebox/iconSet.dart';
import 'package:oceanview/common/titlebox/onelineTitle.dart';
import 'package:oceanview/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/sizeConfig.dart';

class HomePage extends GetView<HomeController> {
  final name = '오션뷰', stat = '시험기간', formattedDate = '7.14 월요일';
  final Color iconColor = Color(0xFF000000);

  // 140
  // [15]
  // 190
  // [15]
  // 80
  // [15]
  // 135

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.sizeByHeight(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OnelineTitle(
              name: name,
              description: formattedDate,
              stat: stat,
              fontsize1: SizeConfig.sizeByHeight(24),
              fontsize2: SizeConfig.sizeByHeight(14),
              fontsize3: SizeConfig.sizeByHeight(12),
              fontweight1: FontWeight.w700,
              fontweight2: FontWeight.w400,
              fontweight3: FontWeight.w400,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(flex: 140, child: GlassMorphism()),
                  Expanded(flex: 15, child: Container()),
                  Expanded(
                      flex: 190,
                      child: Row(
                        children: [
                          Expanded(flex: 163, child: GlassMorphism()),
                          Expanded(flex: 14, child: Container()),
                          Expanded(flex: 163, child: GlassMorphism())
                        ],
                      )),
                  Expanded(flex: 15, child: Container()),
                  Expanded(flex: 80, child: GlassMorphism()),
                  Expanded(flex: 15, child: Container()),
                  Expanded(flex: 135, child: GlassMorphism()),
                  Expanded(flex: 25, child: Container()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
