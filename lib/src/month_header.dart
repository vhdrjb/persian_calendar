import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class MonthHeader extends StatelessWidget {
  final Jalali currentDay;

  MonthHeader(this.currentDay);

  @override
  Widget build(BuildContext context) {
    JalaliFormatter formatter = JalaliFormatter(currentDay);
    final text = "${formatter.mN} - ${formatter.yyyy}";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.end,
              ),
            ),
            SizedBox(width: 16,)
          ],
        ),
      ),
    );
  }
}
