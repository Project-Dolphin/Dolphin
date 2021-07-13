import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_app/common/container/glassMorphism.dart';

import 'package:getx_app/common/carousel/carousel.dart';

import 'bus_controller.dart';

import '../../common/titlebox/onelineTitle.dart';

class BusPage extends GetView<BusController> {
  final List<String> titleList = ['190번', '셔틀버스', '통근버스', '학교버스'];
  List<dynamic> testPageList = [test1(), test2(), test3(), test4()];
  final name = '버스', description = '6월 28일 월요일 16:00', stat = '시험기간';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          OnelineTitle(
            name: name,
            description: description,
            stat: stat,
            fontsize1: 24.0,
            fontsize2: 14.0,
            fontsize3: 12.0,
            fontweight1: FontWeight.w700,
            fontweight2: FontWeight.w400,
            fontweight3: FontWeight.w400,
          ),
          Carousel(pageList: testPageList, titleList: titleList),
        ],
      ),
    );
  }
}

class test1 extends StatelessWidget {
  const test1({Key key}) : super(key: key);

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

class test2 extends StatelessWidget {
  const test2({Key key}) : super(key: key);

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

class test3 extends StatelessWidget {
  const test3({Key key}) : super(key: key);

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

class test4 extends StatelessWidget {
  const test4({Key key}) : super(key: key);

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
