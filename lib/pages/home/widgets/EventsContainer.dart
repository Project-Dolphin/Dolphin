import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:oceanview/common/loading/loading.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/home/home_controller.dart';

class EventsContainer extends GetView<HomeController> {
  const EventsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.sizeByHeight(20),
          vertical: SizeConfig.sizeByHeight(7)),
      child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (_) {
            return _.latestEventList.length > 0
                ? Row(children: [
                    Expanded(
                        flex: 1,
                        child: renderLatestEvent(_.latestEventList[0]['dDay'],
                            _.latestEventList[0]['content'])),
                    Row(
                      children: [
                        SizedBox(
                          width: SizeConfig.sizeByHeight(27),
                        ),
                        Container(
                          width: 0.5,
                          height: SizeConfig.sizeByHeight(40),
                          color: Color(0xFF0081FF),
                        ),
                        SizedBox(
                          width: SizeConfig.sizeByHeight(27),
                        ),
                      ],
                    ),
                    Expanded(
                        flex: 1,
                        child: renderLatestEvent(_.latestEventList[1]['dDay'],
                            _.latestEventList[1]['content'])),
                  ])
                : Loading();
          }),
    );
  }

  renderLatestEvent(int dDay, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextBox('D-$dDay', 22, FontWeight.w400, Color(0xFF0081FF)),
        SizedBox(
          height: SizeConfig.sizeByHeight(5),
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: SizeConfig.sizeByHeight(14),
              fontWeight: FontWeight.w700,
              color: Color(0xFF353B45)),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
