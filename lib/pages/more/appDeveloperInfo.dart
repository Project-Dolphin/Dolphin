import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:package_info/package_info.dart';

class AppDeveloperInfo extends StatefulWidget {
  const AppDeveloperInfo({Key? key}) : super(key: key);

  @override
  _AppDeveloperInfoState createState() => _AppDeveloperInfoState();
}

class _AppDeveloperInfoState extends State<AppDeveloperInfo> {
  PackageInfo? _packageInfo;
  @override
  initState() {
    super.initState();
    getPackageInfo();
  }

  getPackageInfo() async {
    var packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = packageInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
            appBar: CupertinoNavigationBar(
              backgroundColor: CupertinoColors.white.withOpacity(0.4),
              border: null,
              padding: EdgeInsetsDirectional.only(start: 0, end: 0),
              leading: GestureDetector(
                onTap: () => Get.back(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 24,
                    color: Color(0xFF3199FF),
                  ),
                ),
              ),
              middle: const Text(
                '앱 및 개발자 정보',
                style: TextStyle(fontSize: 16),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.sizeByHeight(20),
                  vertical: SizeConfig.sizeByHeight(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    renderRole('🎨', 'Project Manager / Design', ['조성우']),
                    SizedBox(
                      height: SizeConfig.sizeByHeight(30),
                    ),
                    renderRole('💻', 'App Developer', ['이시형', '김덕현']),
                    SizedBox(
                      height: SizeConfig.sizeByHeight(30),
                    ),
                    renderRole('📡', 'Backend Developer',
                        ['이시형', '김덕현', '한채연', '이재왕']),
                    SizedBox(
                      height: SizeConfig.sizeByHeight(20),
                    ),
                    TextBox('Sponsored by GDSC KMOU 2020-2021', 12,
                        FontWeight.w400, Color(0xFF979A9F)),
                    SizedBox(
                      height: SizeConfig.sizeByHeight(50),
                    ),
                    TextBox('문의사항', 16, FontWeight.w700, Color(0xFF353B45)),
                    SizedBox(
                      height: SizeConfig.sizeByHeight(6),
                    ),
                    TextBox('swch0516@naver.com', 14, FontWeight.w400,
                        Color(0xFF353B45)),
                    SizedBox(
                      height: SizeConfig.sizeByHeight(50),
                    ),
                    TextBox('앱정보', 16, FontWeight.w700, Color(0xFF353B45)),
                    SizedBox(
                      height: SizeConfig.sizeByHeight(6),
                    ),
                    TextBox('오션뷰 ${_packageInfo?.version}', 14, FontWeight.w400,
                        Color(0xFF353B45)),
                  ],
                ),
              ),
            )));
  }
}

Widget renderRole(icon, role, names) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextBox(icon, 16, FontWeight.w400, Color(0xFF0081FF)),
          SizedBox(
            width: SizeConfig.sizeByWidth(10),
          ),
          TextBox(role, 14, FontWeight.w400, Color(0xFF0081FF)),
        ],
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: SizeConfig.sizeByHeight(6)),
        height: 0.5,
        width: SizeConfig.sizeByWidth(280),
        color: Color(0xFF0081FF),
      ),
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        ...names.map((e) => Container(
            padding: EdgeInsets.only(right: SizeConfig.sizeByWidth(40)),
            child: TextBox(e, 16, FontWeight.w700, Color(0xff353B45)))),
      ])
    ],
  );
}
