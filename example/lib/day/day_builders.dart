import 'package:flutter/material.dart';
import 'package:persian_calendar/persian_calendar.dart';

typedef DayBuilder = Widget Function(BuildContext context,Jalali day);

class CalendarDayBuilder {
  final DayBuilder? monthDayBuilder;
  final DayBuilder? sideMonthDayBuilder;
  final DayBuilder? currentDayBuilder;

  const CalendarDayBuilder({
    this.monthDayBuilder,
    this.currentDayBuilder,
    this.sideMonthDayBuilder,
  });
}