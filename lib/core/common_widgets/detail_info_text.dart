import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // <-- for date formatting

class DetailInfoText extends StatelessWidget {
  final String title;
  final dynamic value;

  const DetailInfoText({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    String displayValue;

    if (value is DateTime) {
      displayValue = DateFormat('M/d/yy').format(value);
    } else if (value is String) {
      try {
        final date = DateTime.parse(value);
        displayValue = DateFormat('M/d/yy').format(date);
      } catch (_) {
        displayValue = value;
      }
    } else {
      displayValue = value.toString();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$title: ', style: Theme.of(context).textTheme.bodyLarge),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.6.h),
            child: Text(displayValue),
          ),
        ),
      ],
    );
  }
}
