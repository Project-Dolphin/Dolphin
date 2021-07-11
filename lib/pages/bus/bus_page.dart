import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Container(color: Colors.red,);
  }
}
class test2 extends StatelessWidget {
  const test2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue,);
  }
}
class test3 extends StatelessWidget {
  const test3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.black,);
  }
}
class test4 extends StatelessWidget {
  const test4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.yellow,);
  }
}
