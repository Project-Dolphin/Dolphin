import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_app/common/container/glassMorphism.dart';

import 'package:getx_app/common/carousel/carousel.dart';
import 'package:getx_app/common/sizeConfig.dart';

import 'package:getx_app/pages/notice/notice_controller.dart';

import '../../common/titlebox/twolineTitle.dart';
import '../../common/titlebox/iconSet.dart';

class NoticePage extends GetView<NoticeController> {
  final List<String> titleList = ['일반 공지', '고정 공지', '도서관'];
  final List<dynamic> testPageList = [
    NormalNotice(),
    FixedNotice(),
    LibNotice()
  ];
  final name = '공지사항', subname = '아치마당', stat = '일반', more = '학교 홈페이지';
  var iconColor = Color(0xFF000000);

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
              Carousel(pageList: testPageList, titleList: titleList, bar: true),
            ],
          ),
        ],
      ),
    );
  }
}

class NormalNotice extends StatelessWidget {
  const NormalNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      width: 300,
      height: 478,
      widget: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '정류장 선택',
                style: TextStyle(
                  color: Color(0xff005A9E),
                  fontSize: 10,
                ),
              ),
              Text(
                '해양대구본관',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              )
            ],
          )),
    );
  }
}

class FixedNotice extends StatelessWidget {
  const FixedNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      width: 300,
      height: 478,
      widget: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '정류장 선택',
                style: TextStyle(
                  color: Color(0xff005A9E),
                  fontSize: 10,
                ),
              ),
              Text(
                '해양대구본관',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              )
            ],
          )),
    );
  }
}

class LibNotice extends StatelessWidget {
  const LibNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassMorphism(
      width: 300,
      height: 478,
      widget: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '정류장 선택',
                style: TextStyle(
                  color: Color(0xff005A9E),
                  fontSize: 10,
                ),
              ),
              Text(
                '해양대구본관',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              )
            ],
          )),
    );
  }
}
