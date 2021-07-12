import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/notice/notice_controller.dart';
import '../../common/titlebox/twolineTitle.dart';
import '../../common/titlebox/iconSet.dart';

class NoticePage extends GetView<NoticeController> {
  final name = '공지사항', subname = '아치마당', stat = '일반', more = '학교 홈페이지';
  var iconColor = Color(0xFF000000);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconSet(iconColor: iconColor,),
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
              "Notice Page",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
