import 'package:example/validation/build_validation.dart';
import 'package:flutter/material.dart';
import 'package:persian_calendar/persian_calendar.dart';

import 'day_builders.dart';
import 'month_day_theme.dart';

class DayWidget extends StatelessWidget {
  final Jalali day;
  final CalendarDayBuilder? dayBuilder;
  final MonthDayTheme? daysTheme;
  final bool currentMonth;
  final bool displaySideMonths;

  const DayWidget({
    required this.day,
    required this.currentMonth,
    this.dayBuilder,
    this.daysTheme,
    this.displaySideMonths = true,
  });

  @override
  Widget build(BuildContext context) {
    assert(
        BuildValidation.isValid(
            dayBuilder?.sideMonthDayBuilder, daysTheme?.sideMonthDayTheme),
        'can not use theme and builder at same time for side month days');

    assert(
        BuildValidation.isValid(
            dayBuilder?.monthDayBuilder, daysTheme?.currentMonthDayTheme),
        'can not use theme and builder at same time for month days');

    assert(
        BuildValidation.isValid(
            dayBuilder?.currentDayBuilder, daysTheme?.currentDayTheme),
        'can not use theme and builder at same time for current day');

    if (day == Jalali.now()) {
      return dayBuilder?.currentDayBuilder?.call(context, day) ??
          Container(
            decoration: daysTheme?.currentDayTheme?.decoration,
            padding:
                daysTheme?.currentDayTheme?.padding ?? const EdgeInsets.all(10),
            child: Center(
              child: Text(
                day.day.toString(),
                style: daysTheme?.currentDayTheme?.textStyle,
                textAlign: daysTheme?.currentDayTheme?.textAlign,
              ),
            ),
          );
    }

    if (dayBuilder?.monthDayBuilder != null && currentMonth) {
      return dayBuilder!.monthDayBuilder!.call(context, day);
    }

    if (dayBuilder?.sideMonthDayBuilder != null &&
        !currentMonth &&
        displaySideMonths) {
      assert(displaySideMonths,
          'side_month_day_builder can not be used while display_side_month are false');
      return dayBuilder!.sideMonthDayBuilder!.call(context, day);
    }

    if (currentMonth) {
      return Container(
        decoration: daysTheme?.currentMonthDayTheme?.decoration,
        padding: daysTheme?.currentMonthDayTheme?.padding,
        child: Text(
          day.day.toString(),
          style: daysTheme?.currentMonthDayTheme?.textStyle,
          textAlign: daysTheme?.currentMonthDayTheme?.textAlign,
        ),
      );
    }
    if (displaySideMonths) {
      return Container(
        decoration: daysTheme?.sideMonthDayTheme?.decoration,
        padding: daysTheme?.sideMonthDayTheme?.padding,
        child: Text(
          day.day.toString(),
          style: daysTheme?.sideMonthDayTheme?.textStyle,
          textAlign: daysTheme?.sideMonthDayTheme?.textAlign,
        ),
      );
    } else {
      return Container();
    }
  }
}
