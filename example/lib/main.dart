import 'package:flutter/material.dart';
import 'package:persian_calendar/persian_calendar.dart';

import 'persian_calendar.dart';

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
          begin: Jalali(1399,10),
          end: Jalali(1400,6),
        ),
      )
    );
  }
}


