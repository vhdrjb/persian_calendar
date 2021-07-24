import 'package:flutter/cupertino.dart';
import 'package:persian_calendar/persian_calendar.dart';

typedef HeaderIconBuilder = Widget? Function(BuildContext context);

typedef HeaderTitleBuilder = Widget Function(BuildContext context, Jalali date);

class CalendarHeaderBuilder {
  final HeaderIconBuilder? rightIconBuilder;
  final HeaderIconBuilder? leftIconBuilder;
  final HeaderTitleBuilder? headerTitleBuilder;

  const CalendarHeaderBuilder({
    this.rightIconBuilder,
    required this.headerTitleBuilder,
    this.leftIconBuilder,
  });
}
