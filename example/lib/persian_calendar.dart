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
        keepPage: false);
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
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: _getMonthBetween(end: widget.end, begin: widget.begin),
            onPageChanged: (value) {
              setState(() {
                if (lastIndex == null) {
                  lastDate = Jalali(1400, widget.begin.month + value);
                } else {
                  final difference = value - lastIndex!;
                  lastDate = Jalali(1400, lastDate.month + difference);
                }
                _onDateChangeNotifier.value =lastDate;
                lastIndex = value;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                child: Text(index.toString()),
              );
            },
          ),
        ),
      ],
    );
    // return Column(
    //   children: [

    //     SizedBox(
    //       height: 200,
    //       child: PageView.builder(
    //         itemCount: _monthCount(),
    //         itemBuilder: (context, index) {
    //           return Container(
    //             height: 100,
    //             child: Text(index.toString()),
    //             color: Colors.red,
    //           );
    //         },
    //         onPageChanged: (value) {
    //           setState(() {
    //             _onDateChangeNotifier.value = Jalali(1400, value);
    //           });
    //         },
    //       ),
    //     )
    //   ],
    // );
  }

  int _getMonthBetween({required Jalali begin, required Jalali end}) {
    int years = end.year - begin.year;
    int months = end.month - begin.month;
    return years * 12 + months + 1;
  }
}
