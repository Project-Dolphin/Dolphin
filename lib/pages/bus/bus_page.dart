import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bus_controller.dart';

class BusPage extends GetView<BusController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Bus Page",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
