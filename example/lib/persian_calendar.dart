import 'package:example/calendar/calendar_widget.dart';
import 'package:example/day/month_day_theme.dart';
import 'package:example/header/header_theme.dart';
import 'package:example/week_day/week_day_builders.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'day/day_builders.dart';
import 'day/day_theme.dart';
import 'header/header_builders.dart';
import 'header/header_click_config.dart';
import 'header/month_header_widget.dart';
import 'week_day/days.dart';
import 'week_day/week_day_widget.dart';
import 'week_day/week_theme.dart';

class PersianCalendar extends StatefulWidget {
  final Jalali begin;
  final Jalali end;
  final Jalali currentDay;
  final CalendarDayBuilder? dayBuilder;
  final MonthDayTheme? daysTheme;
  final BoxDecoration? weekDecoration;
  final WeekTheme? weekTheme;
  final Map<Days, String>? weekDaysLabel;
  final WeekDayBuilder? weekDayBuilder;
  final CalendarHeaderBuilder? headerBuilder;
  final HeaderTheme? headerTheme;
  final BoxDecoration? headerDecoration;
  final ValueChanged<Jalali>? onDateChanged;
  final HeaderClickBehavior? headerClickBehavior;
  final bool displaySideMonths;
  final TableCellVerticalAlignment? weekDayVerticalAlignment;
  final bool swippable;
  final BoxDecoration? weekDayDecoration;
  final TableCellVerticalAlignment? daysAlignment;

  PersianCalendar(
      {required this.begin,
      required this.end,
      Jalali? currentDay,
      this.dayBuilder,
      this.daysTheme,
      this.weekDecoration,
      this.weekTheme,
      this.weekDaysLabel,
      this.weekDayBuilder,
      this.headerBuilder,
      this.headerTheme,
      this.headerDecoration,
      this.onDateChanged,
      this.displaySideMonths = true,
      this.headerClickBehavior,
      this.weekDayVerticalAlignment,
      this.swippable = true,
      this.weekDayDecoration,
      this.daysAlignment})
      : currentDay = currentDay == null ? Jalali.now() : currentDay;

  @override
  _PersianCalendarState createState() => _PersianCalendarState();
}

class _PersianCalendarState extends State<PersianCalendar> {
  late final ValueNotifier<Jalali> _onDateChangeNotifier;
  late final PageController _pageController;
  int? lastIndex;
  late Jalali lastDate;

  @override
  void initState() {
    _onDateChangeNotifier = ValueNotifier(widget.currentDay);
    lastDate = widget.currentDay;
    _pageController = PageController(
      initialPage:
          _getMonthBetween(begin: widget.begin, end: widget.currentDay),
    );
    super.initState();
  }

  @override
  void dispose() {
    _onDateChangeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: _onDateChangeNotifier,
          builder: (context, Jalali value, child) {
            return MonthHeaderWidget(
              headerClickBehavior: widget.headerClickBehavior,
              headerDecoration: widget.headerDecoration,
              headerBuilder: widget.headerBuilder,
              headerTheme: widget.headerTheme,
              pageController: _pageController,
              beginDate: widget.begin,
              endDate: widget.end,
              currentDate: value,
            );
          },
        ),
        WeekDayWidget(
          weekDayDecoration: widget.weekDayDecoration,
          weekDayVerticalAlignment: widget.weekDayVerticalAlignment,
          weekDays: widget.weekDaysLabel,
          weekDayBuilder: widget.weekDayBuilder,
          weekTheme: widget.weekTheme,
        ),
        Flexible(
          child: CalendarWidget(
            daysAlignment: widget.daysAlignment,
            swippable: widget.swippable,
            displaySideMonths: widget.displaySideMonths,
            weekDecoration: widget.weekDecoration,
            daysTheme: widget.daysTheme,
            dayBuilder: widget.dayBuilder,
            pageController: _pageController,
            onDateChanged: (value) {
              _onDateChangeNotifier.value = value;
              widget.onDateChanged?.call(value);
            },
            initIndex: _pageController.initialPage,
            beginDate: widget.begin,
            endDate: widget.end,
            currentDate: lastDate,
          ),
        ),
      ],
    );
  }

  int _getMonthBetween({required Jalali begin, required Jalali end}) {
    int years = end.year - begin.year;
    int months = end.month - begin.month;
    return years * 12 + months + 1;
  }
}
