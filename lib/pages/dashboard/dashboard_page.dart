import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oceanview/main.dart';
import 'package:oceanview/pages/home/home_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

// Crude counter to make messages unique
// int _messageCount = 0;

/// The API endpoint here accepts a raw FCM payload for demonstration purposes.
// String constructFCMPayload(String token) {
//   _messageCount++;
//   return jsonEncode({
//     'token': token,
//     'data': {
//       'via': 'FlutterFire Cloud Messaging!!!',
//       'count': _messageCount.toString(),
//     },
//     'notification': {
//       'title': 'Hello FlutterFire!',
//       'body': 'This notification (#$_messageCount) was created via FCM!',
//     },
//   });
// }

class DashboardPage extends StatefulWidget {
  DashboardPage() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? _token;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        Get.find<DashboardController>().changeTabIndex(3);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                channel!.description,
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Get.find<DashboardController>().changeTabIndex(3);
    });
    // () async {
    //   print('FlutterFire Messaging Example: Getting APNs token...');
    //   String? token = await FirebaseMessaging.instance.getAPNSToken();
    //   print('FlutterFire Messaging Example: Got APNs token: $token');
    // }();
    // FirebaseMessaging.instance
    //     .getToken(
    //         // vapidKey:
    //         //     'BGpdLRsMJKvFDD9odfPk92uBg-JbQbyoiZdah0XlUyrjG4SDgUsE1iC_kdRgt4Kn0CO7K3RTswPZt61NNuO0XoA')
    //         )
    //     .then((token) {
    //   print(token);
    // });
    onRefresh();
  }

  // Future<void> sendPushMessage() async {
  //   if (_token == null) {
  //     print('Unable to send FCM message, no token exists.');
  //     return;
  //   }

  //   try {
  //     await http.post(
  //       Uri.parse('https://api.rnfirebase.io/messaging/send'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: constructFCMPayload(_token!),
  //     );
  //     print('FCM request for device sent!');
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> onActionSelected(String value) async {
  //   switch (value) {
  //     case 'subscribe':
  //       {
  //         print(
  //             'FlutterFire Messaging Example: Subscribing to topic "fcm_test".');
  //         await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
  //         print(
  //             'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.');
  //       }
  //       break;
  //     case 'unsubscribe':
  //       {
  //         print(
  //             'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".');
  //         await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
  //         print(
  //             'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.');
  //       }
  //       break;
  //     case 'get_apns_token':
  //       {
  //         if (defaultTargetPlatform == TargetPlatform.iOS ||
  //             defaultTargetPlatform == TargetPlatform.macOS) {
  //           print('FlutterFire Messaging Example: Getting APNs token...');
  //           String? token = await FirebaseMessaging.instance.getAPNSToken();
  //           print('FlutterFire Messaging Example: Got APNs token: $token');
  //         } else {
  //           print(
  //               'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.');
  //         }
  //       }
  //       break;
  //     default:
  //       break;
  //   }
  // }

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
      icon: Container(
        child: Center(
          child: Container(
              margin: EdgeInsets.only(
                top: SizeConfig.sizeByHeight(5),
                bottom: SizeConfig.sizeByHeight(2),
              ),
              child: icon!),
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
                                Color(0xFFB4D5F1), BlendMode.srcATop),
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
                  ? SizeConfig.blockSizeVertical * 12
                  : SizeConfig.blockSizeVertical * 10,
          child: BottomNavigationBar(
            unselectedItemColor: Color(0xFF939393),
            selectedItemColor: Color(0xFF0081FF),
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            iconSize: SizeConfig.sizeByHeight(32),
            selectedFontSize: SizeConfig.sizeByHeight(11),
            unselectedFontSize: SizeConfig.sizeByHeight(11),
            selectedLabelStyle: TextStyle(color: Color(0xFF0081FF)),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white.withOpacity(0.8),
            elevation: 0,
            items: [
              _bottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/bottomNavigationIcon/house.fill.png',
                  width: SizeConfig.sizeByHeight(32),
                  height: SizeConfig.sizeByHeight(32),
                ),
                label: '홈',
              ),
              _bottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.only(right: SizeConfig.sizeByHeight(2)),
                  child: Image.asset(
                    'assets/images/bottomNavigationIcon/bus.png',
                    width: SizeConfig.sizeByHeight(32),
                    height: SizeConfig.sizeByHeight(32),
                  ),
                ),
                label: '버스',
              ),
              _bottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.only(right: SizeConfig.sizeByHeight(2)),
                  child: Image.asset(
                    'assets/images/bottomNavigationIcon/fork.knife.png',
                    width: SizeConfig.sizeByHeight(32),
                    height: SizeConfig.sizeByHeight(32),
                  ),
                ),
                label: '식단',
              ),
              _bottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/bottomNavigationIcon/calendar.png',
                  width: SizeConfig.sizeByHeight(32),
                  height: SizeConfig.sizeByHeight(32),
                ),
                label: '학사일정',
              ),
              _bottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/bottomNavigationIcon/ellipsis.png',
                  width: SizeConfig.sizeByHeight(32),
                  height: SizeConfig.sizeByHeight(32),
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
