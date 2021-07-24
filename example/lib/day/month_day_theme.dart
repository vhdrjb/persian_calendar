import 'package:example/calendar_theme.dart';
import 'package:example/day/day_theme.dart';

class MonthDayTheme extends CalendarTheme {
  final DayTheme? currentMonthDayTheme;
  final DayTheme? sideMonthDayTheme;
  final DayTheme? currentDayTheme;
  const MonthDayTheme({
    this.currentMonthDayTheme,
    this.currentDayTheme,
    this.sideMonthDayTheme,
  });
}