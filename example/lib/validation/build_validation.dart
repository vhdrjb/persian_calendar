import 'package:example/calendar_theme.dart';

class BuildValidation {
  static bool isValid(builder, CalendarTheme? theme) {
    return !(builder != null && theme != null);
  }
}
