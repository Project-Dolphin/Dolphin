import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/common/titlebox/onelineTitle.dart';
import 'package:oceanview/pages/more/appDeveloperInfo.dart';

import 'package:oceanview/pages/more/more_controller.dart';
import 'package:oceanview/services/urlUtils.dart';

const String SITE_MAP =
    'https://www.kmou.ac.kr/kmou/ad/site/view.do?mi=3513#sideContent';
const String SITE_PHONE =
    'https://www.kmou.ac.kr/kmou/cm/cntnts/cntntsView.do?mi=1435&cntntsId=329#sideContent';

class MorePage extends GetView<MoreController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.sizeByHeight(20),
        vertical: SizeConfig.sizeByHeight(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitle(
              title: '더보기',
              fontsize: 26.0,
              fontweight: FontWeight.w700,
              isGradient: false),
          SizedBox(
            height: SizeConfig.sizeByHeight(30),
          ),
          renderContentsBlock('내 설정', [
            renderContent('assets/images/morePage/moreIcon_home.png', '홈 화면 설정')
          ]),
          renderContentsBlock('학교', [
            GestureDetector(
              onTap: () => UrlUtils.launchURL(SITE_MAP),
              child: renderContent(
                  'assets/images/morePage/moreIcon_web.png', '학교 주요 홈페이지'),
            ),
            GestureDetector(
              onTap: () => UrlUtils.launchURL(SITE_PHONE),
              child: renderContent(
                  'assets/images/morePage/moreIcon_phone.png', '학교 사무실 전화번호'),
            ),
          ]),
          renderContentsBlock('앱', [
            GestureDetector(
              onTap: () => Get.to(() => AppDeveloperInfo()),
              child: renderContent(
                  'assets/images/morePage/moreIcon_info.png', '앱 및 개발자 정보'),
            ),
            renderContent(
                'assets/images/morePage/moreIcon_suggestion.png', '오류 제보')
          ]),
        ],
      ),
    );
  }
}

Widget renderContentsBlock(String title, List<Widget> children) {
  return Container(
    margin: EdgeInsets.only(bottom: SizeConfig.sizeByHeight(56)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBox(title, 20, FontWeight.w700, Color(0xFF353B45)),
        ...children
      ],
    ),
  );
}

Widget renderContent(String iconPath, String title) {
  return Container(
    margin: EdgeInsets.only(top: SizeConfig.sizeByHeight(20)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          iconPath,
          width: SizeConfig.sizeByHeight(28),
          height: SizeConfig.sizeByHeight(28),
        ),
        SizedBox(
          width: SizeConfig.sizeByWidth(10),
        ),
        TextBox(title, 16, FontWeight.w600, Color(0xFF353B45))
      ],
    ),
  );
}
