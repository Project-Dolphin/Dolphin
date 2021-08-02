import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:oceanview/pages/calendar/CalendarData.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

List<dynamic> _searchResult = [];
List<dynamic> _calendarDetails = [];
List<DateTime> _searchResultStart = [];
List<DateTime> _searchResultEnd = [];

class CalendarSearch extends StatefulWidget {
  @override
  _CalendarSearchState createState() => new _CalendarSearchState();
}

class _CalendarSearchState extends State<CalendarSearch> {
  TextEditingController controller = new TextEditingController();

  Future<CalendarData> getCalendarDetails() async {
    try {
      print("future 실행!");
      final response = await http.get(Uri.parse(
          'https://pxfpulri8j.execute-api.ap-northeast-2.amazonaws.com/dev/calendar'));
      final responseJson = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setState(() {
          for (int i = 0; i < responseJson['data'].length; i++) {
            Map<String, dynamic> calendar = responseJson['data'][i];
            _calendarDetails.add(calendar);
          }
        });
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

  @override
  void initState() {
    super.initState();
    getCalendarDetails();
  }

  @override
  void dispose() {
    onSearchTextChanged('');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fullwidth = MediaQuery.of(context).size.width;
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: new Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: Color.fromRGBO(212, 212, 212, 0.4),
          ),
          child: new ListTile(
            title: new TextField(
              controller: controller,
              decoration:
                  new InputDecoration(hintText: '검색', border: InputBorder.none),
              onChanged: onSearchTextChanged,
            ),
            trailing: new IconButton(
              icon: new Icon(Icons.cancel),
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
                                    child: new Text(_searchResult[i]['content']
                                        .toString())),
                              ),
                            ],
                          ),
                        ),
                        margin: const EdgeInsets.all(0.0),
                      );
                    },
                  )
                : new ListView.builder(
                    itemCount: _calendarDetails.length,
                    itemBuilder: (context, index) {
                      return new Card(
                        child: new ListTile(),
                        margin: const EdgeInsets.all(0.0),
                      );
                    },
                  ),
          ),
        ],
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
      if (calendarDetail['content'].contains(text)) {
        _searchResult.add(calendarDetail);
        _searchResultStart.add(DateFormat("yyyy-M-dd")
            .parse(calendarDetail['term']['startedAt'].toString()));
        _searchResultEnd.add(DateFormat("yyyy-M-dd")
            .parse(calendarDetail['term']['endedAt'].toString()));
      }
    });

    setState(() {});
  }
}
