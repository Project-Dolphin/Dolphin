import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:oceanview/common/shape/circle.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/home/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';

const NOTICE_URL =
    'https://www.kmou.ac.kr/kmou/na/ntt/selectNttList.do?mi=2032&bbsId=10373';

class NoticeContainer extends StatelessWidget {
  const NoticeContainer({Key? key}) : super(key: key);

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.sizeByHeight(15),
            vertical: SizeConfig.sizeByHeight(6)),
        child: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (_) {
              return _.noticeList.length == 0
                  ? Container(
                      child: SpinKitCircle(
                        color: Colors.lightBlue,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextBox('공지사항', SizeConfig.sizeByHeight(16),
                                  FontWeight.w700, Color(0xFF0C98F5)),
                              InkWell(
                                  onTap: () => _launchURL(NOTICE_URL),
                                  child: TextBox(
                                      '학교 홈페이지 ❯',
                                      SizeConfig.sizeByHeight(10),
                                      FontWeight.w500,
                                      Color(0xFF737373)))
                            ],
                          ),
                          ..._.noticeList
                              .sublist(0, 4)
                              .map((e) => InkWell(
                                    onTap: () => _launchURL(e['link']),
                                    child: Row(
                                      children: [
                                        renderCircle(3),
                                        Expanded(
                                          child: Text(e['title'] ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize:
                                                      SizeConfig.sizeByHeight(
                                                          12),
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ]);
            }));
  }
}
