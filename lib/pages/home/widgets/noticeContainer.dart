import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:oceanview/common/loading/loading.dart';
import 'package:oceanview/common/shape/circle.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/home/home_controller.dart';
import 'package:oceanview/services/urlUtils.dart';

const NOTICE_URL =
    'https://www.kmou.ac.kr/kmou/na/ntt/selectNttList.do?mi=2032&bbsId=10373';

class NoticeContainer extends StatelessWidget {
  const NoticeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.sizeByHeight(15),
            vertical: SizeConfig.sizeByHeight(12)),
        child: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (_) {
              return _.noticeList.length == 0
                  ? Loading()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextBox(
                                '공지사항',
                                SizeConfig.sizeByHeight(18),
                                FontWeight.w700,
                                Color(0xFF4BA6FF),
                              ),
                              InkWell(
                                  onTap: () => UrlUtils.launchURL(NOTICE_URL),
                                  child: TextBox(
                                    '학교 홈페이지 ❯',
                                    SizeConfig.sizeByHeight(10),
                                    FontWeight.w400,
                                    Color(0xFF0081FF),
                                  ))
                            ],
                          ),
                          ..._.noticeList
                              .sublist(0, 5)
                              .map((e) => InkWell(
                                    onTap: () => UrlUtils.launchURL(e['link']),
                                    child: Row(
                                      children: [
                                        renderCircle(3),
                                        Expanded(
                                          child: Text(e['title'] ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize:
                                                      SizeConfig.sizeByHeight(
                                                          14),
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF353B45),
                                                  fontFamily: 'Pretendard')),
                                        )
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ]);
            }));
  }
}
