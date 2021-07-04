import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_app/pages/bus/bus_page.dart';
import 'package:getx_app/pages/calendar/calendar_page.dart';
import 'package:getx_app/pages/dailyMenu/dailyMenu_page.dart';
import 'package:getx_app/pages/more/dailyMenu_page.dart';
import 'package:getx_app/pages/notice/notice_page.dart';

import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
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
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Color(0xFF939393),
            selectedItemColor: Color(0xFF0797F8),
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedFontSize: 12,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
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
                icon: Icon(
                  CupertinoIcons.ellipsis,
                  size: 28,
                ),
                label: '더보기',
              ),
            ],
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({Widget icon, String label}) {
    return BottomNavigationBarItem(
      icon: Container(
        margin: EdgeInsets.only(right: 3, bottom: 10),
        child: icon,
      ),
      label: label,
    );
  }
}
