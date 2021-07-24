import 'package:example/day/day_builders.dart';
import 'package:example/day/month_day_theme.dart';
import 'package:flutter/material.dart';
import 'package:persian_calendar/persian_calendar.dart';
import '../day/day_widget.dart';

class MonthWidget extends StatelessWidget {
  final List<Jalali> monthDays;
  final int currentMonth;
  final CalendarDayBuilder? dayBuilder;
  final MonthDayTheme? daysTheme;
  final BoxDecoration? weekDecoration;
  final bool displaySideMonths;
  final TableCellVerticalAlignment? daysAlignment;

  MonthWidget(
      {required this.monthDays,
      required this.currentMonth,
      this.dayBuilder,
      this.daysTheme,
      this.weekDecoration,
      this.displaySideMonths = true,
      this.daysAlignment});

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment:
          daysAlignment ?? TableCellVerticalAlignment.middle,
      children: _buildMonthRow(),
    );
  }

  TableRow _buildDays(int row) {
    return TableRow(
      decoration: weekDecoration,
      children: List.generate(
        7,
        (col) {
          final int index = (row * 7) + col;
          if (index >= monthDays.length) {
            return Container();
          } else {
            return _getDay(monthDays[index]);
          }
        },
      ).reversed.toList(growable: false),
    );
  }

  Widget _getDay(Jalali date) {
    return DayWidget(
      currentMonth: date.month == currentMonth,
      displaySideMonths: displaySideMonths,
      dayBuilder: dayBuilder,
      daysTheme: daysTheme,
      day: date,
    );
  }

  List<TableRow> _buildMonthRow() {
    final int rowCount = (monthDays.length ~/ 7) + 1;
    return List.generate(rowCount, (row) => _buildDays(row))
        .toList(growable: false);
  }
}
