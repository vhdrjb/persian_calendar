import 'package:example/calendar_theme.dart';
import 'package:flutter/material.dart';

class WeekTheme extends CalendarTheme {
  final TextStyle? weekStyle;
  final TextAlign? weekAlign;

  const WeekTheme({
    this.weekStyle,
    this.weekAlign,
  });
}
