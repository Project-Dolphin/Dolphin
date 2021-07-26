import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/bus/stationData.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: findNearStation(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(debugShowCheckedModeBanner: false, home: Splash());
        } else {
          // Loading is done, return the app:
          return GetMaterialApp(
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
    return Scaffold(
      body: Center(
        child: Container(
          child: SpinKitWave(
            color: Colors.lightBlue,
            size: 50,
          ),
        ),
      ),
    );
  }
}
