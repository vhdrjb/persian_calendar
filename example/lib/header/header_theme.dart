import 'package:example/calendar_theme.dart';
import 'package:flutter/material.dart';

import 'header_text_theme.dart';

class HeaderTheme extends CalendarTheme {
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final HeaderTextTheme? headerTextTheme;

  const HeaderTheme({
    required this.padding,
    required this.margin,
    required this.headerTextTheme,
  });
}