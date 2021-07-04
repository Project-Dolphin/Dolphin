import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/dailyMenu/dailyMenu_controller.dart';

class DailyMenuPage extends GetView<DailyMenuController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Daily Menu Page",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
