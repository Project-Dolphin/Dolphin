import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:oceanview/common/container/glassMorphism.dart';
import 'package:oceanview/common/sizeConfig.dart';
import 'package:oceanview/common/text/textBox.dart';
import 'package:oceanview/pages/calendar/calendar_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  Calendar(
      {this.calendarData,
      this.holidayData,
      this.kFirstDay,
      this.specificFocusedDay,
      Key? key})
      : super(key: key);

  final List<CalendarData>? calendarData;
  final List<HolidayData>? holidayData;
  final DateTime? specificFocusedDay;

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

  String _holidayContent = '';

  makeEvent() {
    widget.calendarData!.forEach((element) {
      DateTime _calendarStart =
          DateFormat("yyyy-M-dd").parse(element.term!.startedAt.toString());
      DateTime _calendarEnd =
          DateFormat("yyyy-M-dd").parse(element.term!.endedAt.toString());
      if (_calendarStart == _calendarEnd) {
        kEvents[_calendarStart] = kEvents[_calendarStart] ?? [];
        kEvents[_calendarStart]?.add(Event(element.content!));
      } else {
        for (int i = 0;
            i < _calendarEnd.difference(_calendarStart).inDays;
            i++) {
          kEvents[_calendarStart.add(Duration(days: i))] =
              kEvents[_calendarStart.add(Duration(days: i))] ?? [];
          kEvents[_calendarStart.add(Duration(days: i))]
              ?.add(Event(element.content!));
        }
      }
    });
    _selectedEvents = ValueNotifier(_getEventsForDay(
        // DateTime(widget.kFirstDay.year, widget.kFirstDay.month, 15)
        _selectedDay!));
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
        _holiday[_holidayStart]?.add(Event(_holidayContent));
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

    _focusedDay = widget.specificFocusedDay;
    _selectedDay = _focusedDay;
    kEvents = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    makeEvent();
    makeHoliday();
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
        height: SizeConfig.sizeByHeight(600),
        width: SizeConfig.sizeByWidth(375),
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.sizeByWidth(5)),
        child: Container(
            child: Stack(
          children: [
            Container(
                alignment: Alignment.center,
                height: SizeConfig.sizeByHeight(30),
                child: TextBox('${DateFormat('yyyy').format(widget.kFirstDay)}',
                    22, FontWeight.w400, Color(0xFF353B45))),
            Positioned(
                top: SizeConfig.sizeByHeight(40),
                child: GlassMorphism(
                  width: SizeConfig.sizeByWidth(290),
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
                              fontSize: SizeConfig.sizeByHeight(15),
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
                            markersOffset: PositionedOffset(bottom: 1),
                            canMarkersOverflow: true,
                            markerSize: SizeConfig.sizeByHeight(4),
                            markerMargin: EdgeInsets.only(
                              top: SizeConfig.sizeByHeight(2),
                              left: SizeConfig.sizeByHeight(1),
                              right: SizeConfig.sizeByHeight(1),
                            ),
                            markerDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(59),
                              color: Color(0xFF353B45).withOpacity(0.5),
                            ),
                            defaultTextStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              //fontSize: SizeConfig.sizeByHeight(16),
                            ),
                            todayTextStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                //fontSize: SizeConfig.sizeByHeight(16),
                                color: Colors.white),
                            todayDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF0081FF),
                                border: Border.all(
                                    width: 1,
                                    color: Colors.white.withOpacity(0.8))),
                            selectedTextStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                //fontSize: SizeConfig.sizeByHeight(16),
                                color: Colors.black),
                            selectedDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                    width: 1,
                                    color: Color(0xFF0081FF).withOpacity(0.8))),
                            holidayTextStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                //fontSize: SizeConfig.sizeByHeight(16),
                                color: Color(0xffff3030)),
                            holidayDecoration:
                                BoxDecoration(shape: BoxShape.circle),
                            weekendTextStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                //fontSize: SizeConfig.sizeByHeight(16),
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
              margin: EdgeInsets.only(top: SizeConfig.sizeByHeight(420)),
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: ListTile(
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          onTap: () => {},
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
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        )));
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
