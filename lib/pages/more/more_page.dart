import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_app/pages/more/more_controller.dart';

class MorePage extends GetView<MoreController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "More Page",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
