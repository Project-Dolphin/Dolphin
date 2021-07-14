import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_app/common/container/glassMorphism.dart';

import 'package:getx_app/common/carousel/carousel.dart';
import 'package:getx_app/common/dropdown/dropdownButton.dart';
import 'package:intl/intl.dart';

import 'bus_controller.dart';

import '../../common/titlebox/onelineTitle.dart';

class BusPage extends GetView<BusController> {
  final List<String> titleList = ['190번', '셔틀버스', '통근버스', '학교버스'];
  List<dynamic> testPageList = [CityBus(), test2(), test3(), test4()];
  final name = '버스', stat = '시험기간';

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('M월 d일 E H:m');
    String formattedDate = formatter.format(now);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          OnelineTitle(
            name: name,
            description: formattedDate,
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

class CityBus extends StatefulWidget {
  @override
  _CityBusState createState() => _CityBusState();
}

class _CityBusState extends State<CityBus> {
  final stationList = ['주변정류장', '해양대구본관', '부산역', '영도대교'];
  var selectedStation = '주변정류장';
  bool isDropdownOpen = false;

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
              SizedBox(
                height: 6,
              ),
              Dropdown(
                  stationList,
                  selectedStation,
                  (value) => setState(() {
                        selectedStation = value;
                      })),
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
