import 'package:example/day/day_builders.dart';
import 'package:example/day/day_theme.dart';
import 'package:example/day/month_day_theme.dart';
import 'package:example/header/header_builders.dart';
import 'package:example/header/header_click_config.dart';
import 'package:example/week_day/week_theme.dart';
import 'package:flutter/material.dart';
import 'package:persian_calendar/persian_calendar.dart';

import 'persian_calendar.dart';
import 'week_day/days.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(),
          body: PersianCalendar(
            swippable: true,
            begin: Jalali(1399, 10),
            end: Jalali(1400, 6),
            headerDecoration: BoxDecoration(color: Colors.greenAccent),
            weekDayDecoration: BoxDecoration(color: Colors.yellow),
            headerClickBehavior: HeaderClickBehavior(
                clickable: true,
                curve: Curves.easeOutSine,
                duration: Duration(milliseconds: 1000)),
            headerBuilder: CalendarHeaderBuilder(
              rightIconBuilder: (context) {
                return SizedBox(
                  height: 100,
                  width: 100,
                  child: Container(
                    color: Colors.red,
                  ),
                );
              },
              leftIconBuilder: (context) {
                return SizedBox(
                  height: 100,
                  width: 100,
                  child: Container(
                    color: Colors.red,
                  ),
                );
              },
              headerTitleBuilder: (context, date) {
                return Center(child: Text(date.toString()));
              },
            ),
            weekDaysLabel: {Days.FRIDAY: "ج"},
            weekDecoration: BoxDecoration(
                color: Colors.greenAccent,
                border: Border.all(color: Colors.black12)),
            daysTheme: MonthDayTheme(
              currentDayTheme: DayTheme(
                  textStyle: TextStyle(color: Colors.red),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blue)),
              currentMonthDayTheme: DayTheme(
                  padding: const EdgeInsets.all(10),
                  textStyle: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center),
            ),
            dayBuilder: CalendarDayBuilder(
              sideMonthDayBuilder: (context, day) {
                return Center(
                  child: Container(
                    child: Text("😀"),
                    padding: const EdgeInsets.all(10),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
