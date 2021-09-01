import 'package:flutter/material.dart';
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
      padding: EdgeInsets.all(SizeConfig.sizeByHeight(30)),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.sizeByHeight(19)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFFFFFF),
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(SizeConfig.sizeByHeight(8.5)),
                ),
                child: Icon(
                  Icons.search,
                  size: SizeConfig.sizeByHeight(27.5),
                  color: iconColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalendarSearch()),
                  );
                },
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFFFFFF),
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(SizeConfig.sizeByHeight(8.5)),
                ),
                child: Icon(
                  isSwitched ? Icons.notifications : Icons.notifications_none,
                  size: SizeConfig.sizeByHeight(27.5),
                  color: iconColor,
                ),
                onPressed: () {
                  showAlertDialog(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
