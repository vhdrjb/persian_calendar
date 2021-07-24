import 'package:example/week_day/week_day_builders.dart';
import 'package:example/week_day/days.dart';
import 'package:flutter/material.dart';

import 'week_theme.dart';
import '../validation/build_validation.dart';

class WeekWidget extends StatelessWidget {
  final WeekDayBuilder? weekDayBuilder;
  final Days weekDay;
  final String title;
  final WeekTheme? weekTheme;

  WeekWidget(
      {this.weekDayBuilder,
      required this.weekDay,
      required this.title,
      this.weekTheme});

  @override
  Widget build(BuildContext context) {
    assert(BuildValidation.isValid(weekDayBuilder, weekTheme),
        'can not use theme and builder at same time for weeks');
    return weekDayBuilder?.call(context, weekDay, title) ??
        Center(
            child: Text(
          title,
          textAlign: weekTheme?.weekAlign ?? TextAlign.center,
          style: weekTheme?.weekStyle,
        ));
  }
}
