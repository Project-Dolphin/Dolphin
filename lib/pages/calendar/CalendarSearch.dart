import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:intl/intl.dart';
import 'package:oceanview/pages/calendar/calendar_controller.dart';
import 'package:oceanview/pages/calendar/calendar_widget.dart';

class CalendarSearch extends StatefulWidget {
  @override
  _CalendarSearchState createState() => new _CalendarSearchState();
}

class _CalendarSearchState extends State<CalendarSearch> {
  TextEditingController controller = new TextEditingController();
  FocusNode _focusNode = FocusNode();

  final calendarController = Get.put(CalendarController());

  List<List<dynamic>> _searchResult = [];
  List<dynamic> _calendarDetails = [];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _calendarDetails = calendarController.calendarData!;

    double fullwidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover)),
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: SizeConfig.sizeByHeight(14)),
                child: Row(
                  children: [
                    GestureDetector(
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
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 45,
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.sizeByWidth(20)),
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.sizeByHeight(8),
                            horizontal: SizeConfig.sizeByWidth(10)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: Color.fromRGBO(255, 255, 255, 0.6),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 16),
                                  autofocus: true,
                                  controller: controller,
                                  focusNode: _focusNode,
                                  decoration: new InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      hintText: '학사일정 검색하기 ex.수강신청',
                                      border: InputBorder.none),
                                  onChanged: onSearchTextChanged,
                                ),
                              ),
                            ),
                            Container(
                              width: 20,
                              child: IconButton(
                                iconSize: (20),
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.cancel),
                                color: Color(0xff4ba6ff),
                                onPressed: () {
                                  controller.clear();
                                  onSearchTextChanged('');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              new Expanded(
                child: _searchResult.length != 0 || controller.text.isNotEmpty
                    ? new ListView.builder(
                        itemCount: _searchResult.length,
                        itemBuilder: (context, i) {
                          return new Card(
                            color: Colors.transparent,
                            elevation: 0,
                            child: new ListTile(
                              title: GestureDetector(
                                onTap: () {
                                  calendarController.carouselController
                                      .animateToPage(
                                          _searchResult[i][1].month - 2);
                                  calendarController.setFocusedDay(
                                      _searchResult[i][1].month - 2,
                                      _searchResult[i][1]);
                                  Get.back();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _searchResult[i][1] != _searchResult[i][2]
                                        ? new Text(
                                            DateFormat('M.dd(E)', 'ko_KR')
                                                    .format(_searchResult[i][1])
                                                    .toString() +
                                                ' ~ ' +
                                                DateFormat('M.dd(E)', 'ko_KR')
                                                    .format(_searchResult[i][2])
                                                    .toString())
                                        : new Text(
                                            DateFormat('M.dd(E)', 'ko_KR')
                                                .format(_searchResult[i][1])
                                                .toString()),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(right: 8.0),
                                      width: fullwidth * 0.5,
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: new Text(
                                              _searchResult[i][0].toString())),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            margin: const EdgeInsets.all(0.0),
                          );
                        },
                      )
                    : new ListView.builder(
                        itemCount: 0,
                        itemBuilder: (context, index) {
                          return new Card(
                            elevation: 0,
                            color: Colors.transparent,
                            child: new ListTile(),
                            margin: const EdgeInsets.all(0.0),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _calendarDetails.forEach((calendarDetail) {
      if (calendarDetail.content.contains(text)) {
        print(
            '${calendarDetail.term.startedAt} ${calendarDetail.term.endedAt} ${calendarDetail.content}');
        _searchResult.add([
          calendarDetail.content,
          DateFormat("yyyy-M-dd")
              .parse(calendarDetail.term.startedAt.toString()),
          DateFormat("yyyy-M-dd").parse(calendarDetail.term.endedAt.toString()),
          calendarDetail.content
        ]);
      }
    });

    setState(() {});
  }
}
