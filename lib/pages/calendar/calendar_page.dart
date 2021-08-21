import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:get/get.dart';
import 'package:oceanview/common/titlebox/onelineTitle.dart' as oneLine;
import 'package:oceanview/common/titlebox/twolineTitle.dart';
import 'package:oceanview/pages/calendar/CalendarData.dart';
import 'package:oceanview/common/titlebox/iconSet.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:oceanview/pages/calendar/calendar_controller.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/sizeConfig.dart';

int _current = kToday.month - 2;

class CalendarPage extends GetView<CalendarController1> {
  final name = '학사일정';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          CalendarIcon(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 24.0, 14.0, 24.0),
                child: oneLine.MainTitle(
                  title: name,
                  fontsize: SizeConfig.sizeByHeight(26),
                  fontweight: FontWeight.w700,
                  isGradient: false,
                ),
              ),
            ],
          ),
          Calendar(),
        ],
      ),
    );
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
    _selectedEvents = ValueNotifier(_getEventsForDay(kToday));
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
                      fontSize: SizeConfig.sizeByHeight(26),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: SizeConfig.sizeByHeight(367),
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
            //2
            Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.sizeByWidth(7), 0, SizeConfig.sizeByWidth(7), 0),
              child: GlassMorphism(
                width: SizeConfig.sizeByWidth(330),
                widget: Column(
                  children: [
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.sizeByHeight(18),
                            color: Color(0xff353b45).withOpacity(1)),
                        titleCentered: true,
                        titleTextFormatter: (date, locale) =>
                            DateFormat.M(locale).format(date),
                        headerPadding: EdgeInsets.all(8),
                      ),
                      daysOfWeekHeight: 30.0,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: SizeConfig.sizeByHeight(12),
                        ),
                        weekendStyle: TextStyle(
                          fontSize: SizeConfig.sizeByHeight(12),
                        ),
                      ),
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 2, 1),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      weekendDays: [DateTime.sunday],
                      calendarStyle: CalendarStyle(
                          markersAutoAligned: false,
                          markersOffset: PositionedOffset(bottom: 10),
                          canMarkersOverflow: true,
                          markerSize: SizeConfig.sizeByHeight(4),
                          markerDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff353B45).withOpacity(0.5),
                          ),
                          defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.sizeByHeight(18),
                          ),
                          todayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: Colors.white),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0081FF),
                          ),
                          selectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: _selectedDay.weekday == 7
                                  ? Color(0xFFff3030)
                                  : Color(0xff353b45)),
                          selectedDecoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF0081FF),
                            ),
                            shape: BoxShape.circle,
                            color: Color(0xffffffff),
                          ),
                          holidayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: Color(0xffff3030)),
                          holidayDecoration:
                              BoxDecoration(shape: BoxShape.circle),
                          weekendTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: Color(0xffff3030)),
                          outsideDaysVisible: true,
                          outsideTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: Color(0xff353b45).withOpacity(0.5))),
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
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerVisible: false,
                      daysOfWeekVisible: false,
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 3, 7),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: CalendarFormat.week,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      calendarStyle: CalendarStyle(
                        markersAutoAligned: false,
                        markersOffset: PositionedOffset(bottom: 10),
                        canMarkersOverflow: true,
                        markerSize: SizeConfig.sizeByHeight(4),
                        markerDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff353B45).withOpacity(0.5),
                        ),
                        defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.sizeByHeight(18),
                            color: Color(0xff353b45).withOpacity(0.5)),
                        selectedTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.sizeByHeight(18),
                            color: Color(0xff353b45)),
                        selectedDecoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF0081FF),
                          ),
                          shape: BoxShape.circle,
                          color: Color(0xffffffff),
                        ),
                        holidayTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.sizeByHeight(18),
                            color: Color(0xff353b45).withOpacity(0.5)),
                        holidayDecoration:
                            BoxDecoration(shape: BoxShape.circle),
                        weekendTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.sizeByHeight(18),
                            color: Color(0xff353b45).withOpacity(0.5)),
                        outsideDaysVisible: false,
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
                  ],
                ),
              ),
            ),
            //3
            Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.sizeByWidth(7), 0, SizeConfig.sizeByWidth(7), 0),
              child: GlassMorphism(
                width: SizeConfig.sizeByWidth(330),
                widget: Column(
                  children: [
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.sizeByHeight(18),
                            color: Color(0xff353b45).withOpacity(1)),
                        titleCentered: true,
                        titleTextFormatter: (date, locale) =>
                            DateFormat.M(locale).format(date),
                        headerPadding: EdgeInsets.all(8),
                      ),
                      daysOfWeekHeight: 30.0,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: SizeConfig.sizeByHeight(12),
                        ),
                        weekendStyle: TextStyle(
                          fontSize: SizeConfig.sizeByHeight(12),
                        ),
                      ),
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 3, 1),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      weekendDays: [DateTime.sunday],
                      calendarStyle: CalendarStyle(
                          markersAutoAligned: false,
                          markersOffset: PositionedOffset(bottom: 10),
                          canMarkersOverflow: true,
                          markerSize: SizeConfig.sizeByHeight(4),
                          markerDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff353B45).withOpacity(0.5),
                          ),
                          defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.sizeByHeight(18),
                          ),
                          todayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: Colors.white),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0081FF),
                          ),
                          selectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: _selectedDay.weekday == 7
                                  ? Color(0xFFff3030)
                                  : Color(0xff353b45)),
                          selectedDecoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF0081FF),
                            ),
                            shape: BoxShape.circle,
                            color: Color(0xffffffff),
                          ),
                          holidayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: Color(0xffff3030)),
                          holidayDecoration:
                              BoxDecoration(shape: BoxShape.circle),
                          weekendTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: Color(0xffff3030)),
                          outsideDaysVisible: true,
                          outsideTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: Color(0xff353b45).withOpacity(0.5))),
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
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerVisible: false,
                      daysOfWeekVisible: false,
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 4, 7),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: CalendarFormat.week,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      calendarStyle: CalendarStyle(
                        markersAutoAligned: false,
                        markersOffset: PositionedOffset(bottom: 10),
                        canMarkersOverflow: true,
                        markerSize: SizeConfig.sizeByHeight(4),
                        markerDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff353B45).withOpacity(0.5),
                        ),
                        defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.sizeByHeight(18),
                            color: Color(0xff353b45).withOpacity(0.5)),
                        selectedTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.sizeByHeight(18),
                            color: Color(0xff353b45)),
                        selectedDecoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF0081FF),
                          ),
                          shape: BoxShape.circle,
                          color: Color(0xffffffff),
                        ),
                        holidayTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.sizeByHeight(18),
                            color: Color(0xff353b45).withOpacity(0.5)),
                        holidayDecoration:
                            BoxDecoration(shape: BoxShape.circle),
                        weekendTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.sizeByHeight(18),
                            color: Color(0xff353b45).withOpacity(0.5)),
                        outsideDaysVisible: false,
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
                  ],
                ),
              ),
            ),
            //4
            Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.sizeByWidth(7), 0, SizeConfig.sizeByWidth(7), 0),
              child: GlassMorphism(
                width: SizeConfig.sizeByWidth(330),
                widget: Column(
                  children: [
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.sizeByHeight(18),
                            color: Color(0xff353b45).withOpacity(1)),
                        titleCentered: true,
                        titleTextFormatter: (date, locale) =>
                            DateFormat.M(locale).format(date),
                        headerPadding: EdgeInsets.all(8),
                      ),
                      daysOfWeekHeight: 30.0,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: SizeConfig.sizeByHeight(12),
                        ),
                        weekendStyle: TextStyle(
                          fontSize: SizeConfig.sizeByHeight(12),
                        ),
                      ),
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 4, 1),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      weekendDays: [DateTime.sunday],
                      calendarStyle: CalendarStyle(
                          markersAutoAligned: false,
                          markersOffset: PositionedOffset(bottom: 10),
                          canMarkersOverflow: true,
                          markerSize: SizeConfig.sizeByHeight(4),
                          markerDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff353B45).withOpacity(0.5),
                          ),
                          defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.sizeByHeight(18),
                          ),
                          todayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: Colors.white),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0081FF),
                          ),
                          selectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: _selectedDay.weekday == 7
                                  ? Color(0xFFff3030)
                                  : Color(0xff353b45)),
                          selectedDecoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF0081FF),
                            ),
                            shape: BoxShape.circle,
                            color: Color(0xffffffff),
                          ),
                          holidayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: Color(0xffff3030)),
                          holidayDecoration:
                              BoxDecoration(shape: BoxShape.circle),
                          weekendTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: Color(0xffff3030)),
                          outsideDaysVisible: true,
                          outsideTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: Color(0xff353b45).withOpacity(0.5))),
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
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerVisible: false,
                      daysOfWeekVisible: false,
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 5, 7),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: CalendarFormat.week,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      calendarStyle: CalendarStyle(
                        markersAutoAligned: false,
                        markersOffset: PositionedOffset(bottom: 10),
                        canMarkersOverflow: true,
                        markerSize: SizeConfig.sizeByHeight(4),
                        markerDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff353B45).withOpacity(0.5),
                        ),
                        defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.sizeByHeight(18),
                            color: Color(0xff353b45).withOpacity(0.5)),
                        selectedTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.sizeByHeight(18),
                            color: Color(0xff353b45)),
                        selectedDecoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF0081FF),
                          ),
                          shape: BoxShape.circle,
                          color: Color(0xffffffff),
                        ),
                        holidayTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.sizeByHeight(18),
                            color: Color(0xff353b45).withOpacity(0.5)),
                        holidayDecoration:
                            BoxDecoration(shape: BoxShape.circle),
                        weekendTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.sizeByHeight(18),
                            color: Color(0xff353b45).withOpacity(0.5)),
                        outsideDaysVisible: false,
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
                  ],
                ),
              ),
            ),
            //5
            Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.sizeByWidth(7), 0, SizeConfig.sizeByWidth(7), 0),
              child: GlassMorphism(
                width: SizeConfig.sizeByWidth(330),
                widget: Column(
                  children: [
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.sizeByHeight(18),
                            color: Color(0xff353b45).withOpacity(1)),
                        titleCentered: true,
                        titleTextFormatter: (date, locale) =>
                            DateFormat.M(locale).format(date),
                        headerPadding: EdgeInsets.all(8),
                      ),
                      daysOfWeekHeight: 30.0,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: SizeConfig.sizeByHeight(12),
                        ),
                        weekendStyle: TextStyle(
                          fontSize: SizeConfig.sizeByHeight(12),
                        ),
                      ),
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 5, 1),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      weekendDays: [DateTime.sunday],
                      calendarStyle: CalendarStyle(
                          markersAutoAligned: false,
                          markersOffset: PositionedOffset(bottom: 10),
                          canMarkersOverflow: true,
                          markerSize: SizeConfig.sizeByHeight(4),
                          markerDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff353B45).withOpacity(0.5),
                          ),
                          defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: SizeConfig.sizeByHeight(18),
                          ),
                          todayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: Colors.white),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0081FF),
                          ),
                          selectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: _selectedDay.weekday == 7
                                  ? Color(0xFFff3030)
                                  : Color(0xff353b45)),
                          selectedDecoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF0081FF),
                            ),
                            shape: BoxShape.circle,
                            color: Color(0xffffffff),
                          ),
                          holidayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: Color(0xffff3030)),
                          holidayDecoration:
                              BoxDecoration(shape: BoxShape.circle),
                          weekendTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: Color(0xffff3030)),
                          outsideDaysVisible: true,
                          outsideTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(18),
                              color: Color(0xff353b45).withOpacity(0.5))),
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
                  ],
                ),
              ),
            ),
            //6
            Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.sizeByWidth(7), 0, SizeConfig.sizeByWidth(7), 0),
              child: GlassMorphism(
                width: SizeConfig.sizeByWidth(330),
                widget: Column(
                  children: [
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.sizeByHeight(18),
                            color: Color(0xff353b45).withOpacity(1)),
                        titleCentered: true,
                        titleTextFormatter: (date, locale) =>
                            DateFormat.M(locale).format(date),
                        headerPadding: EdgeInsets.all(8),
                      ),
                      daysOfWeekHeight: 30.0,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: 12,
                        ),
                        weekendStyle: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 6, 1),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      weekendDays: [DateTime.sunday],
                      calendarStyle: CalendarStyle(
                          markersAutoAligned: false,
                          markersOffset: PositionedOffset(bottom: 10),
                          canMarkersOverflow: true,
                          markerSize: SizeConfig.sizeByHeight(4),
                          markerDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff353B45).withOpacity(0.5),
                          ),
                          defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          ),
                          todayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Colors.white),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0081FF),
                          ),
                          selectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: _selectedDay.weekday == 7
                                  ? Color(0xFFff3030)
                                  : Color(0xff353b45)),
                          selectedDecoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF0081FF),
                            ),
                            shape: BoxShape.circle,
                            color: Color(0xffffffff),
                          ),
                          holidayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          holidayDecoration:
                              BoxDecoration(shape: BoxShape.circle),
                          weekendTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          outsideDaysVisible: true,
                          outsideTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xff353b45).withOpacity(0.5))),
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
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerVisible: false,
                      daysOfWeekVisible: false,
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 7, 7),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: CalendarFormat.week,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      calendarStyle: CalendarStyle(
                        markersAutoAligned: false,
                        markersOffset: PositionedOffset(bottom: 10),
                        canMarkersOverflow: true,
                        markerSize: SizeConfig.sizeByHeight(4),
                        markerDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff353B45).withOpacity(0.5),
                        ),
                        defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        selectedTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45)),
                        selectedDecoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF0081FF),
                          ),
                          shape: BoxShape.circle,
                          color: Color(0xffffffff),
                        ),
                        holidayTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        holidayDecoration:
                            BoxDecoration(shape: BoxShape.circle),
                        weekendTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        outsideDaysVisible: false,
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
                  ],
                ),
              ),
            ),
            //7
            Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.sizeByWidth(7), 0, SizeConfig.sizeByWidth(7), 0),
              child: GlassMorphism(
                width: SizeConfig.sizeByWidth(330),
                widget: Column(
                  children: [
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(1)),
                        titleCentered: true,
                        titleTextFormatter: (date, locale) =>
                            DateFormat.M(locale).format(date),
                        headerPadding: EdgeInsets.all(8),
                      ),
                      daysOfWeekHeight: 30.0,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: 12,
                        ),
                        weekendStyle: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 7, 1),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      weekendDays: [DateTime.sunday],
                      calendarStyle: CalendarStyle(
                          markersAutoAligned: false,
                          markersOffset: PositionedOffset(bottom: 10),
                          canMarkersOverflow: true,
                          markerSize: SizeConfig.sizeByHeight(4),
                          markerDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff353B45).withOpacity(0.5),
                          ),
                          defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          ),
                          todayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Colors.white),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0081FF),
                          ),
                          selectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: _selectedDay.weekday == 7
                                  ? Color(0xFFff3030)
                                  : Color(0xff353b45)),
                          selectedDecoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF0081FF),
                            ),
                            shape: BoxShape.circle,
                            color: Color(0xffffffff),
                          ),
                          holidayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          holidayDecoration:
                              BoxDecoration(shape: BoxShape.circle),
                          weekendTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          outsideDaysVisible: true,
                          outsideTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xff353b45).withOpacity(0.5))),
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
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerVisible: false,
                      daysOfWeekVisible: false,
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 8, 7),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: CalendarFormat.week,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      calendarStyle: CalendarStyle(
                        markersAutoAligned: false,
                        markersOffset: PositionedOffset(bottom: 10),
                        canMarkersOverflow: true,
                        markerSize: SizeConfig.sizeByHeight(4),
                        markerDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff353B45).withOpacity(0.5),
                        ),
                        defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        selectedTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45)),
                        selectedDecoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF0081FF),
                          ),
                          shape: BoxShape.circle,
                          color: Color(0xffffffff),
                        ),
                        holidayTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        holidayDecoration:
                            BoxDecoration(shape: BoxShape.circle),
                        weekendTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        outsideDaysVisible: false,
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
                  ],
                ),
              ),
            ),
            //8
            Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.sizeByWidth(7), 0, SizeConfig.sizeByWidth(7), 0),
              child: GlassMorphism(
                width: SizeConfig.sizeByWidth(330),
                widget: Column(
                  children: [
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(1)),
                        titleCentered: true,
                        titleTextFormatter: (date, locale) =>
                            DateFormat.M(locale).format(date),
                        headerPadding: EdgeInsets.all(8),
                      ),
                      daysOfWeekHeight: 30.0,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: 12,
                        ),
                        weekendStyle: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 8, 1),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      weekendDays: [DateTime.sunday],
                      calendarStyle: CalendarStyle(
                          markersAutoAligned: false,
                          markersOffset: PositionedOffset(bottom: 10),
                          canMarkersOverflow: true,
                          markerSize: SizeConfig.sizeByHeight(4),
                          markerDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff353B45).withOpacity(0.5),
                          ),
                          defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          ),
                          todayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Colors.white),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0081FF),
                          ),
                          selectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: _selectedDay.weekday == 7
                                  ? Color(0xFFff3030)
                                  : Color(0xff353b45)),
                          selectedDecoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF0081FF),
                            ),
                            shape: BoxShape.circle,
                            color: Color(0xffffffff),
                          ),
                          holidayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          holidayDecoration:
                              BoxDecoration(shape: BoxShape.circle),
                          weekendTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          outsideDaysVisible: true,
                          outsideTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xff353b45).withOpacity(0.5))),
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
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerVisible: false,
                      daysOfWeekVisible: false,
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 9, 7),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: CalendarFormat.week,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      calendarStyle: CalendarStyle(
                        markersAutoAligned: false,
                        markersOffset: PositionedOffset(bottom: 10),
                        canMarkersOverflow: true,
                        markerSize: SizeConfig.sizeByHeight(4),
                        markerDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff353B45).withOpacity(0.5),
                        ),
                        defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        selectedTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45)),
                        selectedDecoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF0081FF),
                          ),
                          shape: BoxShape.circle,
                          color: Color(0xffffffff),
                        ),
                        holidayTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        holidayDecoration:
                            BoxDecoration(shape: BoxShape.circle),
                        weekendTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        outsideDaysVisible: false,
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
                  ],
                ),
              ),
            ),
            //9
            Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.sizeByWidth(7), 0, SizeConfig.sizeByWidth(7), 0),
              child: GlassMorphism(
                width: SizeConfig.sizeByWidth(330),
                widget: Column(
                  children: [
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(1)),
                        titleCentered: true,
                        titleTextFormatter: (date, locale) =>
                            DateFormat.M(locale).format(date),
                        headerPadding: EdgeInsets.all(8),
                      ),
                      daysOfWeekHeight: 30.0,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: 12,
                        ),
                        weekendStyle: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 9, 1),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      weekendDays: [DateTime.sunday],
                      calendarStyle: CalendarStyle(
                          markersAutoAligned: false,
                          markersOffset: PositionedOffset(bottom: 10),
                          canMarkersOverflow: true,
                          markerSize: SizeConfig.sizeByHeight(4),
                          markerDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff353B45).withOpacity(0.5),
                          ),
                          defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          ),
                          todayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Colors.white),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0081FF),
                          ),
                          selectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: _selectedDay.weekday == 7
                                  ? Color(0xFFff3030)
                                  : Color(0xff353b45)),
                          selectedDecoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF0081FF),
                            ),
                            shape: BoxShape.circle,
                            color: Color(0xffffffff),
                          ),
                          holidayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          holidayDecoration:
                              BoxDecoration(shape: BoxShape.circle),
                          weekendTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          outsideDaysVisible: true,
                          outsideTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xff353b45).withOpacity(0.5))),
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
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerVisible: false,
                      daysOfWeekVisible: false,
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 10, 7),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: CalendarFormat.week,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      calendarStyle: CalendarStyle(
                        markersAutoAligned: false,
                        markersOffset: PositionedOffset(bottom: 10),
                        canMarkersOverflow: true,
                        markerSize: SizeConfig.sizeByHeight(4),
                        markerDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff353B45).withOpacity(0.5),
                        ),
                        defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        selectedTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45)),
                        selectedDecoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF0081FF),
                          ),
                          shape: BoxShape.circle,
                          color: Color(0xffffffff),
                        ),
                        holidayTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        holidayDecoration:
                            BoxDecoration(shape: BoxShape.circle),
                        weekendTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        outsideDaysVisible: false,
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
                  ],
                ),
              ),
            ),
            //10
            Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.sizeByWidth(7), 0, SizeConfig.sizeByWidth(7), 0),
              child: GlassMorphism(
                width: SizeConfig.sizeByWidth(330),
                widget: Column(
                  children: [
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(1)),
                        titleCentered: true,
                        titleTextFormatter: (date, locale) =>
                            DateFormat.M(locale).format(date),
                        headerPadding: EdgeInsets.all(8),
                      ),
                      daysOfWeekHeight: 30.0,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: 12,
                        ),
                        weekendStyle: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 10, 1),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      weekendDays: [DateTime.sunday],
                      calendarStyle: CalendarStyle(
                          markersAutoAligned: false,
                          markersOffset: PositionedOffset(bottom: 10),
                          canMarkersOverflow: true,
                          markerSize: SizeConfig.sizeByHeight(4),
                          markerDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff353B45).withOpacity(0.5),
                          ),
                          defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          ),
                          todayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Colors.white),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0081FF),
                          ),
                          selectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: _selectedDay.weekday == 7
                                  ? Color(0xFFff3030)
                                  : Color(0xff353b45)),
                          selectedDecoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF0081FF),
                            ),
                            shape: BoxShape.circle,
                            color: Color(0xffffffff),
                          ),
                          holidayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          holidayDecoration:
                              BoxDecoration(shape: BoxShape.circle),
                          weekendTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          outsideDaysVisible: true,
                          outsideTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xff353b45).withOpacity(0.5))),
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
                  ],
                ),
              ),
            ),
            //11
            Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.sizeByWidth(7), 0, SizeConfig.sizeByWidth(7), 0),
              child: GlassMorphism(
                width: SizeConfig.sizeByWidth(330),
                widget: Column(
                  children: [
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(1)),
                        titleCentered: true,
                        titleTextFormatter: (date, locale) =>
                            DateFormat.M(locale).format(date),
                        headerPadding: EdgeInsets.all(8),
                      ),
                      daysOfWeekHeight: 30.0,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: 12,
                        ),
                        weekendStyle: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 11, 1),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      weekendDays: [DateTime.sunday],
                      calendarStyle: CalendarStyle(
                          markersAutoAligned: false,
                          markersOffset: PositionedOffset(bottom: 10),
                          canMarkersOverflow: true,
                          markerSize: SizeConfig.sizeByHeight(4),
                          markerDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff353B45).withOpacity(0.5),
                          ),
                          defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          ),
                          todayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Colors.white),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0081FF),
                          ),
                          selectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: _selectedDay.weekday == 7
                                  ? Color(0xFFff3030)
                                  : Color(0xff353b45)),
                          selectedDecoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF0081FF),
                            ),
                            shape: BoxShape.circle,
                            color: Color(0xffffffff),
                          ),
                          holidayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          holidayDecoration:
                              BoxDecoration(shape: BoxShape.circle),
                          weekendTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          outsideDaysVisible: true,
                          outsideTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xff353b45).withOpacity(0.5))),
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
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerVisible: false,
                      daysOfWeekVisible: false,
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 12, 7),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: CalendarFormat.week,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      calendarStyle: CalendarStyle(
                        markersAutoAligned: false,
                        markersOffset: PositionedOffset(bottom: 10),
                        canMarkersOverflow: true,
                        markerSize: SizeConfig.sizeByHeight(4),
                        markerDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff353B45).withOpacity(0.5),
                        ),
                        defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        selectedTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45)),
                        selectedDecoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF0081FF),
                          ),
                          shape: BoxShape.circle,
                          color: Color(0xffffffff),
                        ),
                        holidayTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        holidayDecoration:
                            BoxDecoration(shape: BoxShape.circle),
                        weekendTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        outsideDaysVisible: false,
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
                  ],
                ),
              ),
            ),
            //12
            Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.sizeByWidth(7), 0, SizeConfig.sizeByWidth(7), 0),
              child: GlassMorphism(
                width: SizeConfig.sizeByWidth(330),
                widget: Column(
                  children: [
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(1)),
                        titleCentered: true,
                        titleTextFormatter: (date, locale) =>
                            DateFormat.M(locale).format(date),
                        headerPadding: EdgeInsets.all(8),
                      ),
                      daysOfWeekHeight: 30.0,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: 12,
                        ),
                        weekendStyle: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year, 12, 1),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      weekendDays: [DateTime.sunday],
                      calendarStyle: CalendarStyle(
                          markersAutoAligned: false,
                          markersOffset: PositionedOffset(bottom: 10),
                          canMarkersOverflow: true,
                          markerSize: SizeConfig.sizeByHeight(4),
                          markerDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff353B45).withOpacity(0.5),
                          ),
                          defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          ),
                          todayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Colors.white),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0081FF),
                          ),
                          selectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: _selectedDay.weekday == 7
                                  ? Color(0xFFff3030)
                                  : Color(0xff353b45)),
                          selectedDecoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF0081FF),
                            ),
                            shape: BoxShape.circle,
                            color: Color(0xffffffff),
                          ),
                          holidayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          holidayDecoration:
                              BoxDecoration(shape: BoxShape.circle),
                          weekendTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          outsideDaysVisible: true,
                          outsideTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xff353b45).withOpacity(0.5))),
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
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerVisible: false,
                      daysOfWeekVisible: false,
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year + 1, 1, 7),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: CalendarFormat.week,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      calendarStyle: CalendarStyle(
                        markersAutoAligned: false,
                        markersOffset: PositionedOffset(bottom: 10),
                        canMarkersOverflow: true,
                        markerSize: SizeConfig.sizeByHeight(4),
                        markerDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff353B45).withOpacity(0.5),
                        ),
                        defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        selectedTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45)),
                        selectedDecoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF0081FF),
                          ),
                          shape: BoxShape.circle,
                          color: Color(0xffffffff),
                        ),
                        holidayTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        holidayDecoration:
                            BoxDecoration(shape: BoxShape.circle),
                        weekendTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        outsideDaysVisible: false,
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
                  ],
                ),
              ),
            ),
            //1
            Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.sizeByWidth(7), 0, SizeConfig.sizeByWidth(7), 0),
              child: GlassMorphism(
                width: SizeConfig.sizeByWidth(330),
                widget: Column(
                  children: [
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(1)),
                        titleCentered: true,
                        titleTextFormatter: (date, locale) =>
                            DateFormat.M(locale).format(date),
                        headerPadding: EdgeInsets.all(8),
                      ),
                      daysOfWeekHeight: 30.0,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: 12,
                        ),
                        weekendStyle: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year + 1, 1, 1),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      weekendDays: [DateTime.sunday],
                      calendarStyle: CalendarStyle(
                          markersAutoAligned: false,
                          markersOffset: PositionedOffset(bottom: 10),
                          canMarkersOverflow: true,
                          markerSize: SizeConfig.sizeByHeight(4),
                          markerDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff353B45).withOpacity(0.5),
                          ),
                          defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          ),
                          todayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Colors.white),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0081FF),
                          ),
                          selectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: _selectedDay.weekday == 7
                                  ? Color(0xFFff3030)
                                  : Color(0xff353b45)),
                          selectedDecoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF0081FF),
                            ),
                            shape: BoxShape.circle,
                            color: Color(0xffffffff),
                          ),
                          holidayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          holidayDecoration:
                              BoxDecoration(shape: BoxShape.circle),
                          weekendTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          outsideDaysVisible: true,
                          outsideTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xff353b45).withOpacity(0.5))),
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
                  ],
                ),
              ),
            ),
            //2
            Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.sizeByWidth(7), 0, SizeConfig.sizeByWidth(7), 0),
              child: GlassMorphism(
                width: SizeConfig.sizeByWidth(330),
                widget: Column(
                  children: [
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(1)),
                        titleCentered: true,
                        titleTextFormatter: (date, locale) =>
                            DateFormat.M(locale).format(date),
                        headerPadding: EdgeInsets.all(8),
                      ),
                      daysOfWeekHeight: 30.0,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: 12,
                        ),
                        weekendStyle: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year + 1, 2, 1),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      weekendDays: [DateTime.sunday],
                      calendarStyle: CalendarStyle(
                          markersAutoAligned: false,
                          markersOffset: PositionedOffset(bottom: 10),
                          canMarkersOverflow: true,
                          markerSize: SizeConfig.sizeByHeight(4),
                          markerDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff353B45).withOpacity(0.5),
                          ),
                          defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          ),
                          todayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Colors.white),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0081FF),
                          ),
                          selectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: _selectedDay.weekday == 7
                                  ? Color(0xFFff3030)
                                  : Color(0xff353b45)),
                          selectedDecoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF0081FF),
                            ),
                            shape: BoxShape.circle,
                            color: Color(0xffffffff),
                          ),
                          holidayTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          holidayDecoration:
                              BoxDecoration(shape: BoxShape.circle),
                          weekendTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xffff3030)),
                          outsideDaysVisible: true,
                          outsideTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color(0xff353b45).withOpacity(0.5))),
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
                    TableCalendar<Event>(
                      onDaySelected: _onDaySelected,
                      availableGestures: AvailableGestures.none,
                      headerVisible: false,
                      daysOfWeekVisible: false,
                      locale: 'ko_KR',
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: DateTime(kToday.year + 1, 3, 7),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: CalendarFormat.week,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      calendarStyle: CalendarStyle(
                        markersAutoAligned: false,
                        markersOffset: PositionedOffset(bottom: 10),
                        canMarkersOverflow: true,
                        markerSize: SizeConfig.sizeByHeight(4),
                        markerDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff353B45).withOpacity(0.5),
                        ),
                        defaultTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        selectedTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45)),
                        selectedDecoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF0081FF),
                          ),
                          shape: BoxShape.circle,
                          color: Color(0xffffffff),
                        ),
                        holidayTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        holidayDecoration:
                            BoxDecoration(shape: BoxShape.circle),
                        weekendTextStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xff353b45).withOpacity(0.5)),
                        outsideDaysVisible: false,
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
                  ],
                ),
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
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.sizeByWidth(50),
                    ),
                    child: ListTile(
                      onTap: () => print('${value[index]}'),
                      leading: Container(
                        width: 4,
                        decoration: BoxDecoration(
                          color: Color(0xff0081ff),
                          shape: BoxShape.circle,
                        ),
                      ),
                      title: Transform.translate(
                        offset: Offset(-36, 0),
                        child: Text(
                          '${value[index]}',
                          style: TextStyle(
                              fontSize: SizeConfig.sizeByHeight(16), fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,0,10,30),
          child: TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '전체일정 보기',
                  style: TextStyle(
                      fontSize: SizeConfig.sizeByWidth(12),
                      fontWeight: FontWeight.w300,
                      color: Color(0xff353B45)),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: SizeConfig.sizeByWidth(10),
                    color: Color(0xff353B45),
                  ),
                ),
              ],
            ),
            onPressed: _launchURL,
          ),
        )
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
final kLastDay = DateTime(2022, 3, 31);

_launchURL() async {
  const url =
      'https://www.kmou.ac.kr/onestop/cm/cntnts/cntntsView.do?mi=74&cntntsId=1755';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
