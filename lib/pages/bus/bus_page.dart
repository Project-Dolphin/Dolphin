import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/container/glassMorphism.dart';

import 'bus_controller.dart';

class BusPage extends GetView<BusController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        //GlassMorphism 클래스 이용해서 컴포넌트 사용하면 됨
        child: GlassMorphism(
          width: 300,
          height: 478,
          widget: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '정류장 선택',
                    style: TextStyle(
                      color: Color(0xff005A9E),
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    '해양대구본관',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
