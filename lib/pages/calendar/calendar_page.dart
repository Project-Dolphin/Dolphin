import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:get/get.dart';
import 'package:oceanview/common/titlebox/onelineTitle.dart' as oneLine;
import 'package:oceanview/common/titlebox/twolineTitle.dart';
import 'package:oceanview/pages/calendar/CalendarData.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:oceanview/common/titlebox/iconSet.dart';
import 'package:oceanview/pages/calendar/CalendarSearch.dart';
import 'package:oceanview/pages/calendar/calendar_controller.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/sizeConfig.dart';

int _current = kToday.month - 2;

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
                    oneLine.MainTitle(
                      title: name,
                      fontsize: SizeConfig.sizeByHeight(26),
                      fontweight: FontWeight.w700,
                      isGradient: false,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                          child: InkWell(
                            onTap: _launchURL,
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
          Calendar(),
        ],
      ),
    );
  }

  _launchURL() async {
    const url =
        'https://www.kmou.ac.kr/onestop/cm/cntnts/cntntsView.do?mi=74&cntntsId=1755';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  bool isFirst = true;
  LinkedHashMap<DateTime, List<Event>> kEvents =
      LinkedHashMap<DateTime, List<Event>>();

  bool isHoliday(DateTime day) {
    //print(_holiday.keys);
    return _holiday.keys
        .contains(DateTime(day.year, day.month, day.day, 0, 0, 0));
  }

  final Map<DateTime, List<Event>> _holiday = ({});

  String _calendarContent = '';
  String _holidayContent = '';

  List<dynamic> calendar = [];
  List<dynamic> holiday = [];

  @override
  Future<CalendarData> getCalendarDetails() async {
    try {
      print("future 실행!");
      final response = await http.get(Uri.parse(
          'https://pxfpulri8j.execute-api.ap-northeast-2.amazonaws.com/dev/calendar'));
      final responseJson = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        calendar = responseJson['data'];
        makeEvent();
        return CalendarData.fromJson(responseJson);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (err) {
      print("error!");
      return CalendarData.fromJson({
        "data": [
          {
            "term": {"startedAt": "1900-1-1", "endedAt": "1900-1-1"},
            "mainPlan": true,
            "content": "일정 정보 없음"
          }
        ],
        "path": "/calendar"
      });
    }
  }

  Future<CalendarData> getHoliday() async {
    try {
      print("future 실행!");
      final response = await http.get(Uri.parse(
          'https://pxfpulri8j.execute-api.ap-northeast-2.amazonaws.com/dev/holiday'));
      final responseJson = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        holiday = responseJson['data'];
        makeHoliday();
        print(holiday[1]['content']);
        return CalendarData.fromJson(responseJson);
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
        "path": "/holiday"
      });
    }
  }

  @override
  makeHoliday() {
    for (int i = 0; i < holiday.length; i++) {
      _holidayContent = holiday[i]['content'];
      DateTime _holidayStart =
          DateTime.parse(holiday[i]['term']['startedAt'].toString());
      DateTime _holidayEnd =
          DateTime.parse(holiday[i]['term']['endedAt'].toString());

      if (_holidayStart == _holidayEnd) {
        _holiday[_holidayStart] = _holiday[_holidayStart] ?? [];
        _holiday[_holidayStart]!.add(Event(_holidayContent));
      } else if (_holidayStart != _holidayEnd) {
        for (int j = _holidayStart.day; j < _holidayEnd.day + 1; j++) {
          _holiday[DateTime(_holidayStart.year, _holidayStart.month, j)] =
              _holiday[DateTime(_holidayStart.year, _holidayStart.month, j)] ??
                  [];
          _holiday[DateTime(_holidayStart.year, _holidayStart.month, j)]!
              .add(Event(_holidayContent));
        }
      }
    }
  }

  makeEvent() {
    for (int i = 0; i < calendar.length; i++) {
      _calendarContent = calendar[i]['content'];
      DateTime _calendarStart = DateFormat("yyyy-M-dd")
          .parse(calendar[i]['term']['startedAt'].toString());
      DateTime _calendarEnd = DateFormat("yyyy-M-dd")
          .parse(calendar[i]['term']['endedAt'].toString());
      if (_calendarStart == _calendarEnd) {
        kEvents[_calendarStart] = kEvents[_calendarStart] ?? [];
        kEvents[_calendarStart]!.add(Event(_calendarContent));
      } else if (_calendarStart.month != _calendarEnd.month) {
        if (_calendarStart.month == 1 ||
            _calendarStart.month == 3 ||
            _calendarStart.month == 5 ||
            _calendarStart.month == 7 ||
            _calendarStart.month == 8 ||
            _calendarStart.month == 10 ||
            _calendarStart.month == 12) {
          for (int j = _calendarStart.day; j < 32; j++) {
            kEvents[DateTime(_calendarStart.year, _calendarStart.month, j)] =
                kEvents[DateTime(
                        _calendarStart.year, _calendarStart.month, j)] ??
                    [];
            kEvents[DateTime(_calendarStart.year, _calendarStart.month, j)]!
                .add(Event(_calendarContent));
          }
          if (_calendarStart.month == 12) {
            for (int j = 1; j < _calendarEnd.day + 1; j++) {
              kEvents[DateTime(_calendarStart.year + 1, 1, j)] =
                  kEvents[DateTime(_calendarStart.year + 1, 1, j)] ?? [];
              kEvents[DateTime(_calendarStart.year + 1, 1, j)]!
                  .add(Event(_calendarContent));
            }
          } else {
            for (int j = 1; j < _calendarEnd.day + 1; j++) {
              kEvents[DateTime(
                  _calendarStart.year, _calendarStart.month + 1, j)] = kEvents[
                      DateTime(
                          _calendarStart.year, _calendarStart.month + 1, j)] ??
                  [];
              kEvents[DateTime(
                      _calendarStart.year, _calendarStart.month + 1, j)]!
                  .add(Event(_calendarContent));
            }
          }
        } else if (_calendarStart.month == 2) {
          if (_calendarStart.year % 4 != 0) {
            for (int j = _calendarStart.day; j < 30; j++) {
              kEvents[DateTime(_calendarStart.year, _calendarStart.month, j)] =
                  kEvents[DateTime(
                          _calendarStart.year, _calendarStart.month, j)] ??
                      [];
              kEvents[DateTime(_calendarStart.year, _calendarStart.month, j)]!
                  .add(Event(_calendarContent));
            }
          } else {
            for (int j = _calendarStart.day; j < 29; j++) {
              kEvents[DateTime(_calendarStart.year, _calendarStart.month, j)] =
                  kEvents[DateTime(
                          _calendarStart.year, _calendarStart.month, j)] ??
                      [];
              kEvents[DateTime(_calendarStart.year, _calendarStart.month, j)]!
                  .add(Event(_calendarContent));
            }
          }
          for (int j = 1; j < _calendarEnd.day + 1; j++) {
            kEvents[DateTime(
                _calendarStart.year, _calendarStart.month + 1, j)] = kEvents[
                    DateTime(
                        _calendarStart.year, _calendarStart.month + 1, j)] ??
                [];
            kEvents[DateTime(_calendarStart.year, _calendarStart.month + 1, j)]!
                .add(Event(_calendarContent));
          }
        } else {
          for (int j = _calendarStart.day; j < 31; j++) {
            kEvents[DateTime(_calendarStart.year, _calendarStart.month, j)] =
                kEvents[DateTime(
                        _calendarStart.year, _calendarStart.month, j)] ??
                    [];
            kEvents[DateTime(_calendarStart.year, _calendarStart.month, j)]!
                .add(Event(_calendarContent));
          }
          for (int j = 1; j < _calendarEnd.day + 1; j++) {
            kEvents[DateTime(
                _calendarStart.year, _calendarStart.month + 1, j)] = kEvents[
                    DateTime(
                        _calendarStart.year, _calendarStart.month + 1, j)] ??
                [];
            kEvents[DateTime(_calendarStart.year, _calendarStart.month + 1, j)]!
                .add(Event(_calendarContent));
          }
        }
      } else {
        for (int j = _calendarStart.day; j < _calendarEnd.day + 1; j++) {
          kEvents[DateTime(_calendarStart.year, _calendarStart.month, j)] =
              kEvents[DateTime(_calendarStart.year, _calendarStart.month, j)] ??
                  [];
          kEvents[DateTime(_calendarStart.year, _calendarStart.month, j)]!
              .add(Event(_calendarContent));
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    kEvents = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    getCalendarDetails();
    getHoliday();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Text(
                    _current < 11 ? '2021' : '2022',
                    style: TextStyle(
                      fontSize: SizeConfig.sizeByWidth(22),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 400,
            autoPlay: false,
            enableInfiniteScroll: false,
            enlargeCenterPage: false,
            initialPage: kToday.month - 2,
            onPageChanged: (index, reason) {
              setState(
                () {
                  _current = index;
                },
              );
            },
          ),
          items: [
            GlassMorphism(
              width: SizeConfig.screenWidth * 0.7,
              widget: TableCalendar<Event>(
                onDaySelected: _onDaySelected,
                availableGestures: AvailableGestures.none,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.M(locale).format(date),
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
                focusedDay: DateTime(kToday.year, 2, 1),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                weekendDays: [DateTime.sunday],
                calendarStyle: CalendarStyle(
                  todayTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0081FF),
                  ),
                  selectedTextStyle: TextStyle(
                      color: _selectedDay.weekday == 7
                          ? Colors.red
                          : Color(0xFF353B45)),
                  selectedDecoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF0081FF),
                    ),
                    shape: BoxShape.circle,
                    color: null,
                  ),
                  holidayTextStyle: TextStyle(color: Colors.red),
                  holidayDecoration: BoxDecoration(shape: BoxShape.circle),
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
                eventLoader: _getEventsForDay,
                holidayPredicate: isHoliday,
              ),
            ),
            GlassMorphism(
              width: SizeConfig.screenWidth * 0.7,
              widget: TableCalendar<Event>(
                onDaySelected: _onDaySelected,
                availableGestures: AvailableGestures.none,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.M(locale).format(date),
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
                focusedDay: DateTime(kToday.year, 3, 1),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                weekendDays: [DateTime.sunday],
                calendarStyle: CalendarStyle(
                  todayTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0081FF),
                  ),
                  selectedTextStyle: TextStyle(
                      color: _selectedDay.weekday == 7
                          ? Colors.red
                          : Color(0xFF353B45)),
                  selectedDecoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF0081FF),
                    ),
                    shape: BoxShape.circle,
                    color: null,
                  ),
                  holidayTextStyle: TextStyle(color: Colors.red),
                  holidayDecoration: BoxDecoration(shape: BoxShape.circle),
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
                eventLoader: _getEventsForDay,
                holidayPredicate: isHoliday,
              ),
            ),
            GlassMorphism(
              width: SizeConfig.screenWidth * 0.7,
              widget: TableCalendar<Event>(
                onDaySelected: _onDaySelected,
                availableGestures: AvailableGestures.none,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.M(locale).format(date),
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
                focusedDay: DateTime(kToday.year, 4, 1),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                weekendDays: [DateTime.sunday],
                calendarStyle: CalendarStyle(
                  todayTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0081FF),
                  ),
                  selectedTextStyle: TextStyle(
                      color: _selectedDay.weekday == 7
                          ? Colors.red
                          : Color(0xFF353B45)),
                  selectedDecoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF0081FF),
                    ),
                    shape: BoxShape.circle,
                    color: null,
                  ),
                  holidayTextStyle: TextStyle(color: Colors.red),
                  holidayDecoration: BoxDecoration(shape: BoxShape.circle),
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
                eventLoader: _getEventsForDay,
                holidayPredicate: isHoliday,
              ),
            ),
            GlassMorphism(
              width: SizeConfig.screenWidth * 0.7,
              widget: TableCalendar<Event>(
                onDaySelected: _onDaySelected,
                availableGestures: AvailableGestures.none,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.M(locale).format(date),
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
                focusedDay: DateTime(kToday.year, 5, 1),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                weekendDays: [DateTime.sunday],
                calendarStyle: CalendarStyle(
                  todayTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0081FF),
                  ),
                  selectedTextStyle: TextStyle(
                      color: _selectedDay.weekday == 7
                          ? Colors.red
                          : Color(0xFF353B45)),
                  selectedDecoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF0081FF),
                    ),
                    shape: BoxShape.circle,
                    color: null,
                  ),
                  holidayTextStyle: TextStyle(color: Colors.red),
                  holidayDecoration: BoxDecoration(shape: BoxShape.circle),
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
                eventLoader: _getEventsForDay,
                holidayPredicate: isHoliday,
              ),
            ),
            GlassMorphism(
              width: SizeConfig.screenWidth * 0.7,
              widget: TableCalendar<Event>(
                onDaySelected: _onDaySelected,
                availableGestures: AvailableGestures.none,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.M(locale).format(date),
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
                focusedDay: DateTime(kToday.year, 6, 1),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                weekendDays: [DateTime.sunday],
                calendarStyle: CalendarStyle(
                  todayTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0081FF),
                  ),
                  selectedTextStyle: TextStyle(
                      color: _selectedDay.weekday == 7
                          ? Colors.red
                          : Color(0xFF353B45)),
                  selectedDecoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF0081FF),
                    ),
                    shape: BoxShape.circle,
                    color: null,
                  ),
                  holidayTextStyle: TextStyle(color: Colors.red),
                  holidayDecoration: BoxDecoration(shape: BoxShape.circle),
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
                eventLoader: _getEventsForDay,
                holidayPredicate: isHoliday,
              ),
            ),
            GlassMorphism(
              width: SizeConfig.screenWidth * 0.7,
              widget: TableCalendar<Event>(
                onDaySelected: _onDaySelected,
                availableGestures: AvailableGestures.none,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.M(locale).format(date),
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
                focusedDay: DateTime(kToday.year, 7, 1),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                weekendDays: [DateTime.sunday],
                calendarStyle: CalendarStyle(
                  todayTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0081FF),
                  ),
                  selectedTextStyle: TextStyle(
                      color: _selectedDay.weekday == 7
                          ? Colors.red
                          : Color(0xFF353B45)),
                  selectedDecoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF0081FF),
                    ),
                    shape: BoxShape.circle,
                    color: null,
                  ),
                  holidayTextStyle: TextStyle(color: Colors.red),
                  holidayDecoration: BoxDecoration(shape: BoxShape.circle),
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
                eventLoader: _getEventsForDay,
                holidayPredicate: isHoliday,
              ),
            ),
            GlassMorphism(
              width: SizeConfig.screenWidth * 0.7,
              widget: TableCalendar<Event>(
                onDaySelected: _onDaySelected,
                availableGestures: AvailableGestures.none,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.M(locale).format(date),
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
                focusedDay: DateTime(kToday.year, 8, 1),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                weekendDays: [DateTime.sunday],
                calendarStyle: CalendarStyle(
                  todayTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0081FF),
                  ),
                  selectedTextStyle: TextStyle(
                      color: _selectedDay.weekday == 7
                          ? Colors.red
                          : Color(0xFF353B45)),
                  selectedDecoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF0081FF),
                    ),
                    shape: BoxShape.circle,
                    color: null,
                  ),
                  holidayTextStyle: TextStyle(color: Colors.red),
                  holidayDecoration: BoxDecoration(shape: BoxShape.circle),
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
                eventLoader: _getEventsForDay,
                holidayPredicate: isHoliday,
              ),
            ),
            GlassMorphism(
              width: SizeConfig.screenWidth * 0.7,
              widget: TableCalendar<Event>(
                onDaySelected: _onDaySelected,
                availableGestures: AvailableGestures.none,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.M(locale).format(date),
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
                focusedDay: DateTime(kToday.year, 9, 1),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                weekendDays: [DateTime.sunday],
                calendarStyle: CalendarStyle(
                  todayTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0081FF),
                  ),
                  selectedTextStyle: TextStyle(
                      color: _selectedDay.weekday == 7
                          ? Colors.red
                          : Color(0xFF353B45)),
                  selectedDecoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF0081FF),
                    ),
                    shape: BoxShape.circle,
                    color: null,
                  ),
                  holidayTextStyle: TextStyle(color: Colors.red),
                  holidayDecoration: BoxDecoration(shape: BoxShape.circle),
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
                eventLoader: _getEventsForDay,
                holidayPredicate: isHoliday,
              ),
            ),
            GlassMorphism(
              width: SizeConfig.screenWidth * 0.7,
              widget: TableCalendar<Event>(
                onDaySelected: _onDaySelected,
                availableGestures: AvailableGestures.none,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.M(locale).format(date),
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
                focusedDay: DateTime(kToday.year, 10, 1),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                weekendDays: [DateTime.sunday],
                calendarStyle: CalendarStyle(
                  todayTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0081FF),
                  ),
                  selectedTextStyle: TextStyle(
                      color: _selectedDay.weekday == 7
                          ? Colors.red
                          : Color(0xFF353B45)),
                  selectedDecoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF0081FF),
                    ),
                    shape: BoxShape.circle,
                    color: null,
                  ),
                  holidayTextStyle: TextStyle(color: Colors.red),
                  holidayDecoration: BoxDecoration(shape: BoxShape.circle),
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
                eventLoader: _getEventsForDay,
                holidayPredicate: isHoliday,
              ),
            ),
            GlassMorphism(
              width: SizeConfig.screenWidth * 0.7,
              widget: TableCalendar<Event>(
                onDaySelected: _onDaySelected,
                availableGestures: AvailableGestures.none,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.M(locale).format(date),
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
                focusedDay: DateTime(kToday.year, 11, 1),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                weekendDays: [DateTime.sunday],
                calendarStyle: CalendarStyle(
                  todayTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0081FF),
                  ),
                  selectedTextStyle: TextStyle(
                      color: _selectedDay.weekday == 7
                          ? Colors.red
                          : Color(0xFF353B45)),
                  selectedDecoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF0081FF),
                    ),
                    shape: BoxShape.circle,
                    color: null,
                  ),
                  holidayTextStyle: TextStyle(color: Colors.red),
                  holidayDecoration: BoxDecoration(shape: BoxShape.circle),
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
                eventLoader: _getEventsForDay,
                holidayPredicate: isHoliday,
              ),
            ),
            GlassMorphism(
              width: SizeConfig.screenWidth * 0.7,
              widget: TableCalendar<Event>(
                onDaySelected: _onDaySelected,
                availableGestures: AvailableGestures.none,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.M(locale).format(date),
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
                focusedDay: DateTime(kToday.year, 12, 1),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                weekendDays: [DateTime.sunday],
                calendarStyle: CalendarStyle(
                  todayTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0081FF),
                  ),
                  selectedTextStyle: TextStyle(
                      color: _selectedDay.weekday == 7
                          ? Colors.red
                          : Color(0xFF353B45)),
                  selectedDecoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF0081FF),
                    ),
                    shape: BoxShape.circle,
                    color: null,
                  ),
                  holidayTextStyle: TextStyle(color: Colors.red),
                  holidayDecoration: BoxDecoration(shape: BoxShape.circle),
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
                eventLoader: _getEventsForDay,
                holidayPredicate: isHoliday,
              ),
            ),
            GlassMorphism(
              width: SizeConfig.screenWidth * 0.7,
              widget: TableCalendar<Event>(
                onDaySelected: _onDaySelected,
                availableGestures: AvailableGestures.none,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.M(locale).format(date),
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
                focusedDay: DateTime(kToday.year + 1, 1, 1),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                weekendDays: [DateTime.sunday],
                calendarStyle: CalendarStyle(
                  todayTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0081FF),
                  ),
                  selectedTextStyle: TextStyle(
                      color: _selectedDay.weekday == 7
                          ? Colors.red
                          : Color(0xFF353B45)),
                  selectedDecoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF0081FF),
                    ),
                    shape: BoxShape.circle,
                    color: null,
                  ),
                  holidayTextStyle: TextStyle(color: Colors.red),
                  holidayDecoration: BoxDecoration(shape: BoxShape.circle),
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
                eventLoader: _getEventsForDay,
                holidayPredicate: isHoliday,
              ),
            ),
            GlassMorphism(
              width: SizeConfig.screenWidth * 0.7,
              widget: TableCalendar<Event>(
                onDaySelected: _onDaySelected,
                availableGestures: AvailableGestures.none,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.M(locale).format(date),
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
                focusedDay: DateTime(kToday.year + 1, 2, 1),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                weekendDays: [DateTime.sunday],
                calendarStyle: CalendarStyle(
                  todayTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0081FF),
                  ),
                  selectedTextStyle: TextStyle(
                      color: _selectedDay.weekday == 7
                          ? Colors.red
                          : Color(0xFF353B45)),
                  selectedDecoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF0081FF),
                    ),
                    shape: BoxShape.circle,
                    color: null,
                  ),
                  holidayTextStyle: TextStyle(color: Colors.red),
                  holidayDecoration: BoxDecoration(shape: BoxShape.circle),
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
                eventLoader: _getEventsForDay,
                holidayPredicate: isHoliday,
              ),
            ),
          ],
        ),
        Expanded(
          child: ValueListenableBuilder<List<Event>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    child: ListTile(
                      onTap: () => print('${value[index]}'),
                      title: Text('${value[index]}'),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(2021, 1, 1);
final kLastDay = DateTime(2022, 2, 31);
