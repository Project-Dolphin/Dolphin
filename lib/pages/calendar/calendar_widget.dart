import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';

import 'package:oceanview/pages/calendar/calendar_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class Calendar extends StatefulWidget {
  Calendar({this.calendarData, this.holidayData, this.kFirstDay, Key? key})
      : super(key: key);

  final List<CalendarData>? calendarData;
  final List<HolidayData>? holidayData;

  final kFirstDay;
  late final kLastDay =
      DateTime(kFirstDay.year, kFirstDay.month + 1, kFirstDay.day - 1);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime? _focusedDay;
  DateTime? _selectedDay;

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

  makeEvent() {
    for (int i = 0; i < widget.calendarData!.length; i++) {
      _calendarContent = widget.calendarData![i].content!;
      DateTime _calendarStart = DateFormat("yyyy-M-dd")
          .parse(widget.calendarData![i].term!.startedAt.toString());
      DateTime _calendarEnd = DateFormat("yyyy-M-dd")
          .parse(widget.calendarData![i].term!.endedAt.toString());
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
    _selectedEvents = ValueNotifier(_getEventsForDay(
        DateTime(widget.kFirstDay.year, widget.kFirstDay.month, 15)));
  }

  makeHoliday() {
    for (int i = 0; i < widget.holidayData!.length; i++) {
      _holidayContent = widget.holidayData![i].content!;
      DateTime _holidayStart =
          DateTime.parse(widget.holidayData![i].term!.startedAt!.toString());
      DateTime _holidayEnd =
          DateTime.parse(widget.holidayData![i].term!.endedAt!.toString());

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

  void initState() {
    super.initState();

    if (widget.kFirstDay.month == DateTime.now().month)
      _focusedDay = DateTime.now();
    else
      _focusedDay = widget.kFirstDay;

    _selectedDay = _focusedDay;
    kEvents = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    print(widget.calendarData![0].content);
    print(widget.holidayData![0].content);

    makeEvent();
  }

  @override
  void dispose() {
    super.dispose();
    _selectedEvents.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.sizeByWidth(375),
        margin: EdgeInsets.symmetric(vertical: SizeConfig.sizeByWidth(16)),
        child: Stack(
          children: [
            Container(
                alignment: Alignment.center,
                height: SizeConfig.sizeByHeight(30),
                child: TextBox('${DateFormat('yyyy').format(widget.kFirstDay)}',
                    22, FontWeight.w400, Color(0xFF353B45))),
            Positioned(
                top: SizeConfig.sizeByHeight(30),
                child: GlassMorphism(
                  width: SizeConfig.sizeByWidth(300),
                  height: SizeConfig.sizeByHeight(367),
                  widget: Container(
                      child: Column(
                    children: [
                      Container(
                          height: SizeConfig.sizeByHeight(40),
                          child: TextBox(
                              '${DateFormat('MM').format(widget.kFirstDay)}',
                              26,
                              FontWeight.w800,
                              Color(0xFF353B45))),
                      TableCalendar<Event>(
                        rowHeight: SizeConfig.sizeByHeight(40),
                        headerVisible: false,
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
                          headerPadding:
                              EdgeInsets.all(SizeConfig.sizeByHeight(8)),
                        ),
                        daysOfWeekHeight: SizeConfig.sizeByHeight(30),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                            fontSize: SizeConfig.sizeByHeight(12),
                          ),
                          weekendStyle: TextStyle(
                            fontSize: SizeConfig.sizeByHeight(12),
                          ),
                        ),
                        locale: 'ko',
                        firstDay: widget.kFirstDay,
                        lastDay: widget.kLastDay,
                        focusedDay: _focusedDay!,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        calendarFormat: _calendarFormat,
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        weekendDays: [DateTime.sunday],
                        calendarStyle: CalendarStyle(
                            markersAutoAligned: false,
                            markersOffset: PositionedOffset(bottom: 0),
                            canMarkersOverflow: true,
                            markerSize: SizeConfig.sizeByHeight(10),
                            markerMargin: EdgeInsets.only(
                                top: SizeConfig.sizeByHeight(40)),
                            markerDecoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.5),
                            ),
                            defaultTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.sizeByHeight(14),
                            ),
                            todayTextStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: SizeConfig.sizeByHeight(14),
                                color: Colors.black),
                            /*todayDecoration:
                                      BoxDecoration(color: Colors.yellow),*/
                            selectedTextStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: SizeConfig.sizeByHeight(18),
                                color: Colors.black),
                            selectedDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
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
                        eventLoader: _getEventsForDay,
                        holidayPredicate: isHoliday,
                      )
                    ],
                  )),
                )),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.sizeByHeight(400)),
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Container(
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
                                  fontSize: SizeConfig.sizeByHeight(16),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 20),
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
                ))
          ],
        ));
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

_launchURL() async {
  const url =
      'https://www.kmou.ac.kr/onestop/cm/cntnts/cntntsView.do?mi=74&cntntsId=1755';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
