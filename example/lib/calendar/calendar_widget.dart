import 'package:example/day/day_builders.dart';
import 'package:example/day/month_day_theme.dart';
import 'package:flutter/material.dart';
import 'package:persian_calendar/persian_calendar.dart';
import 'calendar_extensions.dart';
import '../month/month_widget.dart';

class CalendarWidget extends StatelessWidget {
  final PageController pageController;
  final Jalali beginDate;
  final Jalali endDate;
  final Jalali currentDate;
  final int? initIndex;
  final ValueChanged<Jalali> onDateChanged;
  final CalendarDayBuilder? dayBuilder;
  final MonthDayTheme? daysTheme;
  final BoxDecoration? weekDecoration;
  final bool displaySideMonths;
  final bool swippable;
  final TableCellVerticalAlignment? daysAlignment;
  const CalendarWidget({
    required this.pageController,
    required this.beginDate,
    required this.endDate,
    required this.currentDate,
    this.initIndex,
    required this.onDateChanged,
    this.dayBuilder,
    this.daysTheme,
    this.weekDecoration,
    this.displaySideMonths = true,
    this.swippable = true, this.daysAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      physics: swippable ? null : NeverScrollableScrollPhysics(),
      itemCount: _getMonthBetween(end: endDate, begin: beginDate),
      onPageChanged: (value) {
        Jalali date;
        if (initIndex == null) {
          date = _getDefaultDays(value);
        } else {
          date = _getPageDays(currentDate, value);
        }
        onDateChanged.call(date);
      },
      itemBuilder: (context, index) {
        Jalali date;
        if (initIndex == null) {
          date = _getDefaultDays(index);
        } else {
          date = _getPageDays(currentDate, index);
        }
        List<Jalali> dates = _getMonthDays(date);
        return MonthWidget(
          daysAlignment: daysAlignment,
          displaySideMonths: displaySideMonths,
          daysTheme: daysTheme,
          dayBuilder: dayBuilder,
          weekDecoration: weekDecoration,
          monthDays: dates,
          currentMonth: date.month,
        );
      },
    );
  }

  int _getMonthBetween({required Jalali begin, required Jalali end}) {
    int years = end.year - begin.year;
    int months = end.month - begin.month;
    return years * 12 + months + 1;
  }

  Jalali _getDefaultDays(int pageIndex) {
    Jalali firstDayJalali = beginDate;
    Jalali jalaliDay = firstDayJalali.addMonths(pageIndex);
    Jalali date = jalaliDay;
    if (date.isBefore(beginDate)) {
      jalaliDay = beginDate;
    } else if (date.isAfter(endDate)) {
      jalaliDay = endDate;
    }
    return date;
  }

  Jalali _getPageDays(Jalali prevFocusedDay, int pageIndex) {
    if (pageIndex == initIndex) {
      return prevFocusedDay;
    }

    final pageDif = pageIndex - initIndex!;
    Jalali day = prevFocusedDay.addMonths(pageDif);
    if (day.isBefore(beginDate)) {
      day = beginDate;
    } else if (day.isAfter(endDate)) {
      day = endDate;
    }

    return day;
  }

  List<Jalali> _getMonthDays(Jalali date) {
    final Jalali firstDayOfMonth = Jalali(date.year, date.month, 1);
    final Jalali lastDayOfMonth = firstDayOfMonth.addMonths(1).addDays(-1);
    final int monthDays =
        lastDayOfMonth.distanceFrom(firstDayOfMonth).abs() + 1;
    int daysBefore = firstDayOfMonth.weekDay - 1;
    int daysAfter = displaySideMonths ? (7 - lastDayOfMonth.weekDay) : 0;
    final int count = (monthDays + daysBefore + daysAfter);
    return List.generate(count, (index) {
      return firstDayOfMonth.addDays(index - daysBefore);
    });
  }
}
