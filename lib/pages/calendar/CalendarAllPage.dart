import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:oceanview/pages/calendar/CalendarData.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Dart:ui';
import 'package:intl/intl.dart';

class CalList extends StatefulWidget {
  @override
  _CalListState createState() => _CalListState();
}

class _CalListState extends State<CalList> {
  late Future<CalendarData> calendarData;

  Future<CalendarData> _fetch1() async {
    try {
      print("future 실행!");
      http.Response response = await http.get(
        Uri.parse(
            'https://pxfpulri8j.execute-api.ap-northeast-2.amazonaws.com/dev/calendar'),
      );
      if (response.statusCode == 200) {
        print(utf8.decode(response.bodyBytes));
        return CalendarData.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
      } else {
        throw Exception("Failed to load data");
      }
    } catch (err) {
      print("error!");
      return CalendarData.fromJson({
        "data": [
          {
            "term": {"startedAt": "1900-1-1", "endedAt": "1900-1-1"},
            "content": "일정 정보 없음"
          }
        ],
        "path": "/calendar"
      });
    }
  }

  void initState() {
    super.initState();
    calendarData = _fetch1();
  }

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('전체 일정표'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: buildFutureBuilder(fullWidth, fullHeight),
        ),
      ),
    );
  }

  FutureBuilder<CalendarData> buildFutureBuilder(
      double fullWidth, double fullHeight) {
    return FutureBuilder(
        future: calendarData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Column(
              children: <Widget>[
                SizedBox(height: fullHeight * 0.4),
                Center(
                  child: CupertinoActivityIndicator(
                    radius: 20,
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Column(
              children: <Widget>[
                SizedBox(height: 50.0),
                Text(
                  "error",
                  style: TextStyle(
                    color: const Color(0xff131415),
                    fontWeight: FontWeight.w500,
                    fontFamily: "NotoSansKR",
                    fontStyle: FontStyle.normal,
                    fontSize: 24,
                  ),
                ),
              ],
            );
          } else {
            print(snapshot.data);
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 4,
                ),
                CalendarInfo(
                  calendarTable: snapshot.data.result,
                ),
              ],
            );
          }
        });
  }
}

class CalendarInfo extends StatelessWidget {
  final List<dynamic>? calendarTable;

  const CalendarInfo({
    Key? key,
    @required this.calendarTable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fullwidth = MediaQuery.of(context).size.width;
    List<dynamic>? list = calendarTable;
    ListView myList = new ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: list!.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        list[index]["content"],
                        style: TextStyle(
                          color: const Color(0xff131415),
                          fontWeight: FontWeight.w300,
                          fontFamily: "NotoSansKR",
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                        ),
                      ),
                      DateFormat('yyyy.M.dd(E)', 'ko_KR')
                                  .format(DateFormat("yyyy-M-dd").parse(
                                      list[index]['term']['startedAt']
                                          .toString()))
                                  .toString() !=
                              DateFormat('yyyy.M.dd(E)', 'ko_KR')
                                  .format(DateFormat("yyyy-M-dd").parse(
                                      list[index]['term']['endedAt']
                                          .toString()))
                                  .toString()
                          ? Row(
                              children: [
                                Text(
                                  DateFormat('yyyy.M.dd(E)', 'ko_KR')
                                          .format(DateFormat("yyyy-M-dd").parse(
                                              list[index]['term']['startedAt']
                                                  .toString()))
                                          .toString() +
                                      ' ~ ' +
                                      DateFormat('yyyy.M.dd(E)', 'ko_KR')
                                          .format(DateFormat("yyyy-M-dd").parse(
                                              list[index]['term']['endedAt']
                                                  .toString()))
                                          .toString(),
                                  style: TextStyle(
                                    color: const Color(0xff131415),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "NotoSansKR",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              DateFormat('yyyy.M.dd(E)', 'ko_KR')
                                  .format(DateFormat("yyyy-M-dd").parse(
                                      list[index]['term']['startedAt']
                                          .toString()))
                                  .toString(),
                              style: TextStyle(
                                color: const Color(0xff131415),
                                fontWeight: FontWeight.w300,
                                fontFamily: "NotoSansKR",
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                height: 5,
              ),
            ],
          );
        });
    return myList;
  }
}
