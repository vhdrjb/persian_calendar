import 'package:example/header/header_click_config.dart';
import 'package:example/validation/build_validation.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'header_builders.dart';
import '../config/calendar_config.dart';
import 'header_theme.dart';

class MonthHeaderWidget extends StatelessWidget {
  static const double padding_value = 8.0;
  static const double title_margins_value = 16.0;
  final Jalali currentDate;
  final Jalali beginDate;
  final Jalali endDate;
  final CalendarHeaderBuilder? headerBuilder;
  final HeaderTheme? headerTheme;
  final VoidCallback? onRightClicked;
  final VoidCallback? onLeftClicked;
  final BoxDecoration? headerDecoration;
  final PageController pageController;
  final HeaderClickBehavior? headerClickBehavior;

  MonthHeaderWidget(
      {required this.currentDate,
      required this.beginDate,
      required this.endDate,
      required this.pageController,
      this.headerBuilder,
      this.onRightClicked,
      this.onLeftClicked,
      this.headerDecoration,
      this.headerTheme,
      this.headerClickBehavior});

  @override
  Widget build(BuildContext context) {
    assert(
        BuildValidation.isValid(
            headerBuilder?.headerTitleBuilder, headerTheme?.headerTextTheme),
        'can not use theme and builder at same time for month title');

    Widget text;
    if (headerBuilder?.headerTitleBuilder == null) {
      JalaliFormatter formatter = JalaliFormatter(currentDate);
      final date = "${formatter.mN} - ${formatter.yyyy}";
      text = Text(
        date,
        style: headerTheme?.headerTextTheme?.monthTextStyle,
        textAlign:
            headerTheme?.headerTextTheme?.monthTextAlign ?? TextAlign.end,
      );
    } else {
      text = headerBuilder!.headerTitleBuilder!.call(context, currentDate);
    }

    return Container(
      margin: headerTheme?.margin,
      decoration: headerDecoration,
      padding: headerTheme?.padding ?? const EdgeInsets.all(padding_value),
      child: Container(
        child: Row(
          children: [
            if (_isLeftClickEnabled())
              GestureDetector(
                child: headerBuilder?.leftIconBuilder?.call(context) ??
                    Container(),
                onTap: () {
                  if (headerClickBehavior ==null || headerClickBehavior?.clickable == true) {
                   _previousPage();
                  }
                  onLeftClicked?.call();
                },
              ),
            SizedBox(
              width: title_margins_value,
            ),
            Expanded(child: text),
            SizedBox(
              width: title_margins_value,
            ),
            if (_isRightClickEnabled())
              GestureDetector(
                child: headerBuilder?.rightIconBuilder?.call(context) ??
                    Container(),
                onTap: () {
                  if (headerClickBehavior ==null || headerClickBehavior?.clickable == true) {
                    pageController.nextPage(
                        duration: headerClickBehavior?.duration ?? defaultAnimationDuration,
                        curve: headerClickBehavior?.curve ?? defaultCurve);
                  }
                  onRightClicked?.call();
                },
              )
          ],
        ),
      ),
    );
  }

  bool _isLeftClickEnabled() {
    return headerBuilder?.leftIconBuilder != null &&
        currentDate.month != beginDate.month;
  }

  bool _isRightClickEnabled() {
    return headerBuilder?.rightIconBuilder != null &&
        currentDate.month != endDate.month;
  }

  void _previousPage() {
    pageController.previousPage(
        duration: headerClickBehavior?.duration ?? defaultAnimationDuration,
        curve: headerClickBehavior?.curve ?? defaultCurve);
  }
}
