import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_app/common/container/glassMorphism.dart';

import 'package:getx_app/widgets/carousel.dart';


import 'bus_controller.dart';

class BusPage extends GetView<BusController> {
  final List<String> titleList = ['190번', '셔틀버스', '통근버스', '학교버스'];
  List<dynamic> testPageList = [test1(),test2(),test3(),test4()];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Carousel(pageList: testPageList, titleList: titleList),

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
              )),;
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
              )),;
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
              )),;
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
              )),;
  }
}
