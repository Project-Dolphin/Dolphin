import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/icon/gradientIcon.dart';
import 'package:getx_app/common/sizeConfig.dart';

import 'package:getx_app/pages/bus/bus_page.dart';
import 'package:getx_app/pages/calendar/calendar_page.dart';
import 'package:getx_app/pages/dailyMenu/dailyMenu_page.dart';
import 'package:getx_app/pages/more/more_page.dart';
import 'package:getx_app/pages/notice/notice_page.dart';
import 'package:getx_app/services/local_notification_service.dart';

import 'dashboard_controller.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();

    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];

        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }

      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];

      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: IndexedStack(
                index: controller.tabIndex,
                children: [
                  BusPage(),
                  DailyMenuPage(),
                  NoticePage(),
                  CalendarPage(),
                  MorePage(),
                ],
              ),
            ),
            bottomNavigationBar: _getBtmNavBar(controller),
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({Widget? icon, String? label}) {
    return BottomNavigationBarItem(
      icon: Container(
        margin: EdgeInsets.only(top: 8, right: 3, bottom: 8),
        child: icon,
      ),
      activeIcon: Container(
          margin: EdgeInsets.only(top: 8, right: 3, bottom: 8),
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
                            Color(0xFFB4D5F1), BlendMode.srcATop),
                        child: icon,
                      ),
                    ),
                  ),
                ),
              ),
              GradientIcon(
                icon!,
                LinearGradient(
                    colors: <Color>[
                      Color(0xFF009DF5),
                      Color(0xFF1E7AFF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ],
          )),
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
        child: BottomNavigationBar(
          unselectedItemColor: Color(0xFF939393),
          selectedItemColor: Color(0xFF1E7AFF),
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedLabelStyle: TextStyle(color: Color(0xFF1E7AFF)),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white.withOpacity(0.8),
          elevation: 0,
          items: [
            _bottomNavigationBarItem(
              icon: ImageIcon(
                  AssetImage('assets/images/bottomNavigationIcon/bus.png'),
                  size: 24),
              label: '버스',
            ),
            _bottomNavigationBarItem(
              icon: ImageIcon(AssetImage(
                  'assets/images/bottomNavigationIcon/fork.knife.png')),
              label: '식단',
            ),
            _bottomNavigationBarItem(
              icon: ImageIcon(AssetImage(
                  'assets/images/bottomNavigationIcon/megaphone.fill.png')),
              label: '공지사항',
            ),
            _bottomNavigationBarItem(
              icon: ImageIcon(AssetImage(
                  'assets/images/bottomNavigationIcon/calendar.png')),
              label: '학사일정',
            ),
            _bottomNavigationBarItem(
              icon: ImageIcon(AssetImage(
                  'assets/images/bottomNavigationIcon/ellipsis.png')),
              label: '더보기',
            ),
          ],
        ),
      ),
    );
  }
}
