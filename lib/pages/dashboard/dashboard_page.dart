import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oceanview/main.dart';
import 'package:oceanview/pages/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:oceanview/common/icon/gradientIcon.dart';
import 'package:oceanview/common/sizeConfig.dart';

import 'package:oceanview/pages/bus/bus_page.dart';
import 'package:oceanview/pages/calendar/calendar_page.dart';
import 'package:oceanview/pages/dailyMenu/dailyMenu_page.dart';
import 'package:oceanview/pages/more/more_page.dart';

import 'dashboard_controller.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? _token;

  @override
  void initState() {
    super.initState();

    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: GetBuilder<DashboardController>(
          builder: (controller) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: IndexedStack(
                index: controller.tabIndex,
                children: [
                  HomePage(),
                  BusPage(),
                  DailyMenupage(),
                  CalendarPage(),
                  MorePage(),
                ],
              ),
              bottomNavigationBar: _getBtmNavBar(controller),
            );
          },
        ));
  }

  _bottomNavigationBarItem({Widget? icon, String? label}) {
    return BottomNavigationBarItem(
      icon: Opacity(
        opacity: 0.7,
        child: Container(
          child: Center(
            child: Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.sizeByHeight(5),
                  bottom: SizeConfig.sizeByHeight(2),
                ),
                child: icon!),
          ),
        ),
      ),
      activeIcon: Container(
        child: Center(
          child: Container(
              margin: EdgeInsets.only(
                top: SizeConfig.sizeByHeight(5),
                bottom: SizeConfig.sizeByHeight(2),
              ),
              child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(0, 3),
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.transparent,
                            width: 0,
                          ),
                        ),
                        child: Opacity(
                          opacity: 0.5,
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                Color(0xFFb7b7b7), BlendMode.srcATop),
                            child: icon,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GradientIcon(
                    icon,
                    LinearGradient(
                        colors: <Color>[
                          Color(0xFF3199FF),
                          Color(0xFF0081FF),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                ],
              )),
        ),
      ),
      label: label,
    );
  }

  ClipRRect _getBtmNavBar(controller) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: Container(
          height:
              foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS
                  ? SizeConfig.blockSizeVertical * 11.5
                  : SizeConfig.blockSizeVertical * 9.5,
          child: BottomNavigationBar(
            unselectedItemColor: Color(0xFF939393),
            selectedItemColor: Color(0xFF0081FF),
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            iconSize: SizeConfig.sizeByHeight(30),
            selectedFontSize: SizeConfig.sizeByHeight(10),
            unselectedFontSize: SizeConfig.sizeByHeight(10),
            selectedLabelStyle: TextStyle(
                color: Color(0xFF0081FF), fontWeight: FontWeight.w500),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white.withOpacity(0.8),
            elevation: 0,
            items: [
              _bottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/bottomNavigationIcon/house.fill.png',
                  width: SizeConfig.sizeByHeight(30),
                  height: SizeConfig.sizeByHeight(30),
                ),
                label: '홈',
              ),
              _bottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.only(right: SizeConfig.sizeByHeight(2)),
                  child: Image.asset(
                    'assets/images/bottomNavigationIcon/bus.png',
                    width: SizeConfig.sizeByHeight(30),
                    height: SizeConfig.sizeByHeight(30),
                  ),
                ),
                label: '버스',
              ),
              _bottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.only(right: SizeConfig.sizeByHeight(2)),
                  child: Image.asset(
                    'assets/images/bottomNavigationIcon/fork.knife.png',
                    width: SizeConfig.sizeByHeight(30),
                    height: SizeConfig.sizeByHeight(30),
                  ),
                ),
                label: '식단',
              ),
              _bottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/bottomNavigationIcon/calendar.png',
                  width: SizeConfig.sizeByHeight(30),
                  height: SizeConfig.sizeByHeight(30),
                ),
                label: '학사일정',
              ),
              _bottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/bottomNavigationIcon/ellipsis.png',
                  width: SizeConfig.sizeByHeight(30),
                  height: SizeConfig.sizeByHeight(30),
                ),
                label: '더보기',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
