import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/sizeConfig.dart';
import '../../common/titlebox/twolineTitle.dart';
import '../../common/titlebox/iconSet.dart';

class HomePage extends GetView<HomeController> {
  final name = '홈', subname = '아치마당', stat = '일반', more = '학교 홈페이지';
  final Color iconColor = Color(0xFF000000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          IconSet(
            iconColor: iconColor,
          ),
          Column(
            children: [
              TwolineTitle(
                name: name,
                subname: subname,
                stat: stat,
                more: more,
                fontsize1: SizeConfig.sizeByWidth(26),
                fontsize2: SizeConfig.sizeByWidth(20),
                fontsize3: SizeConfig.sizeByWidth(12),
                fontweight1: FontWeight.w700,
                fontweight2: FontWeight.w500,
                fontweight3: FontWeight.w400,
              ),
              Container(
                child: Center(
                  child: TextBox('Home', 24, FontWeight.w500, Colors.black),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
