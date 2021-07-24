import 'package:flutter/material.dart';

import '../calendar_theme.dart';

class DayTheme extends CalendarTheme {
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;

  const DayTheme({
    this.textStyle,
    this.textAlign,
    this.decoration,
    this.padding,
  });
}
