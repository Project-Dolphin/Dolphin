import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oceanview/pages/bus/stationData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:async';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'themes/app_theme.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await initFirebase();
  print('Handling a background message ${message.messageId}');
}

// void _initNotiSetting() async {
//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   final initSettingsAndroid = AndroidInitializationSettings('app_icon');
//   final initSettingsIOS = IOSInitializationSettings(
//     requestSoundPermission: false,
//     requestBadgePermission: false,
//     requestAlertPermission: false,
//   );
//   final initSettings = InitializationSettings(
//     android: initSettingsAndroid,
//     iOS: initSettingsIOS,
//   );
//   await flutterLocalNotificationsPlugin.initialize(
//     initSettings,
//   );
// }

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel? channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await initFirebase();

    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    final initSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    final initSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    final initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );
    await flutterLocalNotificationsPlugin!.initialize(
      initSettings,
    );
  }

  initializeDateFormatting().then((_) => runApp(MyApp()));
}

Future<void> initFirebase() async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        name: "OceanView",
        options: const FirebaseOptions(
          apiKey:
              '	AAAAN5dXGqg:APA91bELcxT-XIYUeLPmfWs9not4_1FKpbR_5oCQwzQmfmiL-Rn2flbAugNkYd2Sj4qS-uaDH7LJ8KieB9gUlzirjUbjTyyPr2ISxcmzPsD3W9f4J7nTOgsqZD1awcsUknlkfweEHH1j',
          appId: '1:238762269352:android:9c3821ff635f1acb96c09d',
          messagingSenderId: '238762269352',
          projectId: 'oceanview_android',
        ));
  } else {
    Firebase.app('OceanView'); // 이미 초기화되었다면, 초기화 된 것을 사용함
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    findNearStation();
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 500)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(debugShowCheckedModeBanner: false, home: Splash());
        } else {
          return GetMaterialApp(
            builder: (context, child) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!);
            },
            initialRoute: AppRoutes.DASHBOARD,
            getPages: AppPages.list,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            // darkTheme: AppTheme.dark,
            // themeMode: ThemeMode.system,
          );
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Color(0xFF3199FF), Color(0xFF0081FF)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 100.0, 50.0));

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/app_logo.png',
              height: 75,
            ),
            Text(
              'Oceanview',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  foreground: Paint()..shader = linearGradient),
            )
          ],
        )),
      ),
    );
  }
}
