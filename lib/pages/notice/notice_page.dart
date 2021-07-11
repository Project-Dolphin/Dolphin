import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/notice/notice_controller.dart';

class NoticePage extends GetView<NoticeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Notice Page",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
