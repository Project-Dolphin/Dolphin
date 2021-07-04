import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_app/pages/more/dailyMenu_controller.dart';

class MorePage extends GetView<MoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "More Page",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
