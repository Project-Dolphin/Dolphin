import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'calendar_controller.dart';

class CalendarPage extends GetView<CalendarController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text("Calendar Page")],
        ),
      ),
    );
  }
}
