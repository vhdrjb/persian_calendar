import 'package:flutter/material.dart';
import 'package:persian_calendar/src/month_header.dart';
import 'package:shamsi_date/shamsi_date.dart';

class PersianCalendar extends StatefulWidget {
  final Jalali begin;
  final Jalali end;
  final Jalali currentDay;

  PersianCalendar({
    required this.begin,
    required this.end,
    Jalali? currentDay,
  }) : currentDay = currentDay == null ? Jalali.now() : currentDay;

  @override
  _PersianCalendarState createState() => _PersianCalendarState();
}

class _PersianCalendarState extends State<PersianCalendar> {
  late final ValueNotifier<Jalali> _onDateChangeNotifier;

  @override
  void initState() {
    _onDateChangeNotifier = ValueNotifier(widget.currentDay);
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
            return MonthHeader(value);
          },
        ),
        SizedBox(
          height: 200,
          child: PageView.builder(
            itemCount: _monthCount(),
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                child: Text(index.toString()),
                color: Colors.red,
              );
            },
            onPageChanged: (value) {
              setState(() {
                _onDateChangeNotifier.value = Jalali(1400, value);
              });
            },
          ),
        )
      ],
    );
  }

  int _monthCount() {
    return widget.begin.month - widget.end.month;
  }
}
