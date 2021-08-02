import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:oceanview/common/titlebox/iconSet.dart';
import 'package:oceanview/common/titlebox/twolineTitle.dart';
import 'package:oceanview/pages/calendar/CalendarSearch.dart';
import 'package:oceanview/pages/calendar/CalendarAllPage.dart';
import 'package:oceanview/pages/calendar/calendar_controller.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/sizeConfig.dart';

Future<Calendar> fetchPost() async {
  try {
    final response = await http.get(
      Uri.parse(
        'https://asia-northeast1-kmouin-62d7f.cloudfunctions.net/api/schedule',
      ),
    );
    if (response.statusCode == 200) {
      return Calendar.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  } catch (e) {
    print('\nfetchERROR :: Errortype : ${e}\n');
    throw Exception('Failed to load post');
  }
}

class Calendar {
  String? status;
  List<dynamic>? jsonList = [];

  Calendar({this.status, this.jsonList});

  factory Calendar.fromJson(Map<String, dynamic> json) {
    return Calendar(
      status: json['status'],
      jsonList: json['result']['list'],
    );
  }

  List? setList() {
    return jsonList;
  }
}

class CalendarPage extends GetView<CalendarController1> {
  var iconColor = Color(0xFF000000);
  final name = '학사일정', subname = '아치마당', stat = '일반', more = '전체일정 보기';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          IconSet(
            iconColor: iconColor,
            onPressed1: CalendarSearch(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 24.0, 14.0, 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainTitle(
                      name: name,
                      fontsize1: SizeConfig.sizeByWidth(26),
                      fontweight1: FontWeight.w700,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CalList()),
                              );
                            },
                            child: MoreText(
                              description: more,
                              fontsize: SizeConfig.sizeByWidth(12),
                              fontweight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Text(
                      '2021',
                      style: TextStyle(
                        fontSize: SizeConfig.sizeByWidth(22),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Calendar_test(),
          ),
        ],
      ),
    );
  }
}

class Calendar_test extends StatefulWidget {
  const Calendar_test({Key? key}) : super(key: key);

  @override
  _Calendar_testState createState() => _Calendar_testState();
}

class _Calendar_testState extends State<Calendar_test> {
  Map<DateTime, List>? _events;
  Map<DateTime, List>? _holidays;
  late Future<Calendar> calendar;
  List? _selectedEvents;
  bool key = true;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List> input_events() {
    final _selectedDay = DateTime.now();
    calendar = fetchPost();
    _holidays = {
      // 휴일 저장
      DateTime(_selectedDay.year - 1, 1, 1): ['새해'],
      DateTime(_selectedDay.year - 1, 3, 1): ['삼일절'],
      DateTime(_selectedDay.year - 1, 5, 5): ['어린이날'],
      DateTime(_selectedDay.year - 1, 6, 6): ['현충일'],
      DateTime(_selectedDay.year - 1, 8, 15): ['광복절'],
      DateTime(_selectedDay.year - 1, 10, 3): ['개천절'],
      DateTime(_selectedDay.year - 1, 10, 9): ['한글날'],
      DateTime(_selectedDay.year - 1, 12, 25): ['크리스마스'],

      DateTime(_selectedDay.year, 1, 1): ['새해'],
      DateTime(_selectedDay.year, 1, 24): ['설 연휴'],
      DateTime(_selectedDay.year, 1, 25): ['설 연휴'],
      DateTime(_selectedDay.year, 1, 26): ['설 연휴'],
      DateTime(_selectedDay.year, 3, 1): ['삼일절'],
      DateTime(_selectedDay.year, 5, 5): ['어린이날'],
      DateTime(_selectedDay.year, 6, 6): ['현충일'],
      DateTime(_selectedDay.year, 8, 15): ['광복절'],
      DateTime(_selectedDay.year, 9, 30): ['추석 연휴'],
      DateTime(_selectedDay.year, 10, 1): ['추석 연휴'],
      DateTime(_selectedDay.year, 10, 2): ['추석 연휴'],
      DateTime(_selectedDay.year, 10, 3): ['개천절'],
      DateTime(_selectedDay.year, 10, 9): ['한글날'],
      DateTime(_selectedDay.year, 12, 25): ['크리스마스'],

      DateTime(_selectedDay.year + 1, 1, 1): ['새해'],
      DateTime(_selectedDay.year + 1, 2, 11): ['설 연휴'],
      DateTime(_selectedDay.year + 1, 2, 12): ['설 연휴'],
      DateTime(_selectedDay.year + 1, 2, 13): ['설 연휴'],
      DateTime(_selectedDay.year + 1, 3, 1): ['삼일절'],
      DateTime(_selectedDay.year + 1, 5, 5): ['어린이날'],
      DateTime(_selectedDay.year + 1, 5, 19): ['부처님 오신 날'],
      DateTime(_selectedDay.year + 1, 6, 6): ['현충일'],
      DateTime(_selectedDay.year + 1, 8, 15): ['광복절'],
      DateTime(_selectedDay.year + 1, 9, 20): ['추석 연휴'],
      DateTime(_selectedDay.year + 1, 9, 21): ['추석 연휴'],
      DateTime(_selectedDay.year + 1, 9, 22): ['추석 연휴'],
      DateTime(_selectedDay.year + 1, 10, 3): ['개천절'],
      DateTime(_selectedDay.year + 1, 10, 9): ['한글날'],
      DateTime(_selectedDay.year + 1, 12, 25): ['크리스마스'],
    };
    Map<DateTime, List> events = {};
    events.addAll(_holidays!);
    return events;
  }

  @override
  void initState() {
    super.initState();
    _events = input_events();
    _selectedDay = _focusedDay;
    _selectedEvents = _events![_selectedDay] ?? [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlassMorphism(
          width: 320,
          widget: FutureBuilder<Calendar>(
              future: calendar,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (key) {
                    setData(snapshot.data!.jsonList);
                  }
                } else if (snapshot.hasError) {
                  print(
                      '\n\nERRORMESSAGE :: snapshot Error :  ${snapshot.error}\n\n');
                }
                return _buildTableCalendar();
              }),
        ),
        Expanded(
          child: _buildEventList(),
        )
      ],
    );
  }

  void setData(List? jsonList) {
    try {
      for (var i = 0; i < jsonList!.length; i++) {
        if (_events![DateTime(jsonList[i]['date']['year'],
                jsonList[i]['date']['month'], jsonList[i]['date']['day'])] ==
            null) {
          _events![DateTime(jsonList[i]['date']['year'],
              jsonList[i]['date']['month'], jsonList[i]['date']['day'])] = [];
        }
        {
          _events![DateTime(jsonList[i]['date']['year'],
                  jsonList[i]['date']['month'], jsonList[i]['date']['day'])]!
              .add(jsonList[i]['calendar']);
        }
      }
      key = false;
    } catch (e) {
      print('\nErrortype : ${e}\n');
    }
  }

  Widget _buildTableCalendar() {
    return TableCalendar<Event>(
      onDaySelected: _onDaySelected,
      //availableGestures: AvailableGestures.none,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
        titleCentered: true,
        titleTextFormatter: (date, locale) => DateFormat.M(locale).format(date),
        headerPadding: EdgeInsets.all(8),
      ),
      daysOfWeekHeight: 30.0,
      daysOfWeekStyle: DaysOfWeekStyle(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Color(0xffe0e0e0),
            ),
          ),
        ),
      ),
      locale: 'ko_KR',
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      calendarFormat: _calendarFormat,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarStyle: CalendarStyle(
        todayTextStyle: TextStyle(color: Colors.white),
        todayDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff1e7aff),
        ),
        selectedTextStyle: TextStyle(color: Colors.black),
        selectedDecoration: BoxDecoration(
          border: Border.all(
            color: Color(0xff1e7aff),
          ),
          shape: BoxShape.circle,
          color: null,
        ),
        // Use `CalendarStyle` to customize the UI
        weekendTextStyle: TextStyle(color: Colors.red),
        outsideDaysVisible: true,
      ),
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      calendarBuilders: CalendarBuilders(
        holidayBuilder: (context, datetime, holidays) {
          final children = <Widget>[];
          if (holidays != null) {
            children.add(
              Positioned(
                right: 1,
                top: 0.5,
                child: _buildHolidaysMarker(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.grade,
      size: 17.0,
      color: Colors.orange,
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents!
          .map(
            (event) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x80cacaca),
                          offset: Offset(0, -1),
                          blurRadius: 16,
                          spreadRadius: 2)
                    ],
                    color: Colors.white),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 15),
                    Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: const Color(0xff5b9fee),
                          borderRadius: BorderRadius.circular(12.0),
                        )),
                    SizedBox(width: 15),
                    Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          event.toString(),
                          style: TextStyle(
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w500,
                            fontFamily: "NotoSansKR",
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(2021, 1, 1);
final kLastDay = DateTime(2021, 12, 31);
