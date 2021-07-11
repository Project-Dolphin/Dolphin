import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'calendar_controller.dart';
import '../../common/titlebox/iconSet.dart';

class CalendarPage extends GetView<CalendarController> {
  var iconColor = Color(0xFF000000);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconSet(iconColor: iconColor,),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            '공지사항',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text("Calendar Page")],
            ),
          ),
        ),
      ],
    );
  }
}
