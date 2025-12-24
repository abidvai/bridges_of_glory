import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DetailInfoText extends StatelessWidget {
  final String title;
  final String value;

  const DetailInfoText({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$title: ', style: Theme.of(context).textTheme.bodyLarge),
        SizedBox(width: 2),
        Expanded(child: Padding(padding: EdgeInsets.symmetric(vertical: 2.6.h),
        child: Text(value))),
      ],
    );
  }
}
