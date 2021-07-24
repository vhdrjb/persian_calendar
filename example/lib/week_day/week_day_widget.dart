import 'package:example/week_day/days.dart';
import 'package:flutter/material.dart';

import 'week_day_builders.dart';
import 'week_theme.dart';
import 'week_widget.dart';

class WeekDayWidget extends StatelessWidget {
  static const Map<Days, String> _days = {
    Days.SATURDAY: "شنبه",
    Days.SUNDAY: "یک شنبه",
    Days.MONDAY: "دو شنبه",
    Days.TUESDAY: 'سه شنبه',
    Days.WEDNESDAY: 'چهار شنبه',
    Days.THURSDAY: 'پنج شنبه',
    Days.FRIDAY: 'جمعه'
  };

  final Map<Days, String>? weekDays;
  final WeekDayBuilder? weekDayBuilder;
  final WeekTheme? weekTheme;
  final TableCellVerticalAlignment? weekDayVerticalAlignment;
  final BoxDecoration? weekDayDecoration;

  WeekDayWidget(
      {this.weekDays,
      this.weekDayBuilder,
      this.weekTheme,
      this.weekDayVerticalAlignment,
      this.weekDayDecoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: weekDayDecoration,
      child: Table(
        defaultVerticalAlignment:
            weekDayVerticalAlignment ?? TableCellVerticalAlignment.top,
        children: [
          TableRow(
              children: _days.entries
                  .map((e) => WeekWidget(
                      weekDay: e.key,
                      title: _getTitle(e.key),
                      weekTheme: weekTheme,
                      weekDayBuilder: weekDayBuilder))
                  .toList()),
        ],
      ),
    );
  }

  _getTitle(Days value) {
    return weekDays?[value] ?? _days[value];
  }
}
