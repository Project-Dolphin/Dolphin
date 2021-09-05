import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/pages/calendar/Calendar_repository.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:oceanview/pages/calendar/calendar_controller.dart';

class CalendarSearch extends StatefulWidget {
  @override
  _CalendarSearchState createState() => new _CalendarSearchState();
}

class _CalendarSearchState extends State<CalendarSearch> {
  TextEditingController controller = new TextEditingController();
  FocusNode _focusNode = FocusNode();

  final calendarController = Get.put(CalendarController());

  List<dynamic> _searchResult = [];
  List<dynamic> _calendarDetails = [];
  List<DateTime> _searchResultStart = [];
  List<DateTime> _searchResultEnd = [];

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
    onSearchTextChanged('');
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
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leadingWidth: SizeConfig.sizeByWidth(20),
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
                color: Color(0xff009DF5),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios)),
          ),
          title: new Container(
            height: SizeConfig.sizeByHeight(40),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: Color.fromRGBO(255, 255, 255, 0.6),
            ),
            child: new ListTile(
              title: new TextFormField(
                style: TextStyle(fontSize: SizeConfig.sizeByHeight(16)),
                autofocus: true,
                controller: controller,
                focusNode: _focusNode,
                decoration: new InputDecoration(
                    hintText: '학사일정을 검색하기 ex.수강신청', border: InputBorder.none),
                onChanged: onSearchTextChanged,
              ),
              trailing: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.cancel),
                color: Color(0xff4ba6ff),
                onPressed: () {
                  controller.clear();
                  onSearchTextChanged('');
                },
              ),
            ),
          ),
        ),
        body: new Column(
          children: <Widget>[
            new Expanded(
              child: _searchResult.length != 0 || controller.text.isNotEmpty
                  ? new ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, i) {
                        return new Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: new ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _searchResultStart[i] != _searchResultEnd[i]
                                    ? new Text(DateFormat('M.dd(E)', 'ko_KR')
                                            .format(_searchResultStart[i])
                                            .toString() +
                                        ' ~ ' +
                                        DateFormat('M.dd(E)', 'ko_KR')
                                            .format(_searchResultEnd[i])
                                            .toString())
                                    : new Text(DateFormat('M.dd(E)', 'ko_KR')
                                        .format(_searchResultStart[i])
                                        .toString()),
                                Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 8.0),
                                  width: fullwidth * 0.5,
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: new Text(
                                          _searchResult[i].toString())),
                                ),
                              ],
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
    );
  }

  onSearchTextChanged(String text) async {
    print(text);
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _calendarDetails.forEach((calendarDetail) {
      if (calendarDetail.content.contains(text)) {
        _searchResult.add(calendarDetail.content);
        _searchResultStart.add(DateFormat("yyyy-M-dd")
            .parse(calendarDetail.term.startedAt.toString()));
        _searchResultEnd.add(DateFormat("yyyy-M-dd")
            .parse(calendarDetail.term.endedAt.toString()));
      }
    });

    setState(() {});
  }
}
