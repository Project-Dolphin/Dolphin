import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/dialog/dialog2.dart';
import 'package:oceanview/pages/calendar/CalendarSearch.dart';
import 'package:oceanview/common/sizeConfig.dart';

class CalendarIcon extends StatefulWidget {
  const CalendarIcon({Key? key}) : super(key: key);

  @override
  _CalendarIconState createState() => _CalendarIconState();
}

class _CalendarIconState extends State<CalendarIcon> {
  var iconColor = Color(0xFF000000);
  bool isSwitched = false;
  int val = 1;

  tmpNoti() {
    Get.dialog(
        AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(SizeConfig.sizeByHeight(20),
              SizeConfig.sizeByHeight(20), SizeConfig.sizeByHeight(20), 0),
          content: dialog,
        ),
        transitionDuration: Duration(milliseconds: 200),
        name: '미완성알림');
  }

  showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(25, 25, 25, 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/CalendarPage/CalendarAlarmDialog.png',
                          width: SizeConfig.sizeByHeight(25.56),
                          height: SizeConfig.sizeByHeight(23.47),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "일정 알림",
                                style: TextStyle(
                                    fontSize: SizeConfig.sizeByHeight(22),
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                height: SizeConfig.sizeByHeight(6),
                              ),
                              Text(
                                "아침에 해당 일정\n푸시 알림이 와요",
                                style: TextStyle(
                                    fontSize: SizeConfig.sizeByHeight(12),
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff353b45).withOpacity(0.8)),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        )
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.sizeByHeight(26),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '모든 학사일정 받기',
                          style: TextStyle(
                              fontSize: SizeConfig.sizeByHeight(19),
                              fontWeight: FontWeight.w400),
                        ),
                        Radio(
                          value: 1,
                          groupValue: val,
                          onChanged: !isSwitched
                              ? null
                              : (int? value) {
                                  setState(() {
                                    val = value!;
                                  });
                                },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.sizeByHeight(30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '주요 학사일정 받기',
                              style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(19),
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: SizeConfig.sizeByHeight(6),
                            ),
                            Text(
                              '수강신청, 등록금 납입, 시험 등 학생 일정',
                              style: TextStyle(
                                  fontSize: SizeConfig.sizeByHeight(12),
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xff353b45).withOpacity(0.8)),
                            ),
                          ],
                        ),
                        Radio(
                          value: 2,
                          groupValue: val,
                          onChanged: !isSwitched
                              ? null
                              : (int? value) {
                                  setState(() {
                                    val = value!;
                                  });
                                },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.sizeByHeight(40),
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(0xffc5c5c5),
                    ),
                    Center(
                      child: Container(
                        height: 30,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              "확인",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.sizeByHeight(22),
                                  color: Color(0xff353b45)),
                            ),
                            onPressed: () {
                              setState(() {
                                isSwitched = isSwitched;
                              });
                              Navigator.pop(context);
                            }),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarSearch()),
              );
            },
            child: Container(
                height: SizeConfig.sizeByHeight(40),
                width: SizeConfig.sizeByHeight(40),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFFFFFFF).withOpacity(0.5),
                        Color(0xFFFFFFFF).withOpacity(0.3)
                      ],
                    )),
                child: Center(
                  child: Image.asset(
                    'assets/images/CalendarPage/CalendarSearch.png',
                    width: SizeConfig.sizeByHeight(16),
                    height: SizeConfig.sizeByHeight(16),
                  ),
                ))),
        SizedBox(
          width: SizeConfig.sizeByWidth(20),
        ),
        GestureDetector(
            onTap: () {
              tmpNoti();
              //showAlertDialog(context);
            },
            child: Container(
                height: SizeConfig.sizeByHeight(40),
                width: SizeConfig.sizeByHeight(40),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFFFFFFF).withOpacity(0.5),
                        Color(0xFFFFFFFF).withOpacity(0.3)
                      ],
                    )),
                child: Center(
                  child: Image.asset(
                    isSwitched
                        ? 'assets/images/CalendarPage/CalendarNotiOn.png'
                        : 'assets/images/CalendarPage/CalendarNotiOff.png',
                    width: SizeConfig.sizeByWidth(14),
                    height: SizeConfig.sizeByWidth(14),
                  ),
                ))),
      ],
    ));
  }
}
