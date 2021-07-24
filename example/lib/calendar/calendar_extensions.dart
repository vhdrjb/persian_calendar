import 'package:persian_calendar/persian_calendar.dart';

extension ShamsiDateExtensions on Jalali {
  bool isAfter(Jalali other) {
    return this.distanceFrom(other) > 0;
  }

  bool isBefore(Jalali other) {
    return this.distanceTo(other) > 0;
  }
}
