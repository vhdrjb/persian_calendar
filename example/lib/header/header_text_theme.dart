import 'package:example/calendar_theme.dart';
import 'package:flutter/material.dart';

class HeaderTextTheme extends CalendarTheme { 
  final TextStyle? monthTextStyle;
  final TextAlign? monthTextAlign;

  const HeaderTextTheme({
    required this.monthTextStyle,
    required this.monthTextAlign,
  });
}