import 'package:flutter/material.dart';
import 'package:persian_calendar/src/month_header.dart';
import 'package:shamsi_date/shamsi_date.dart';

class PersianCalendar extends StatelessWidget {
  final Jalali begin;
  final Jalali end;
  final Jalali currentDay;

  PersianCalendar({
    required this.begin,
    required this.end,
    Jalali? currentDay,
  }) : currentDay = currentDay == null ? Jalali.now() : currentDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MonthHeader(currentDay)
      ],
    );
  }
}
