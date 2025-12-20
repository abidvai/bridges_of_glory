import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_back_button.dart';


class AppTopBar extends StatelessWidget {
  final String text;

  const AppTopBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          AppBackButton(),
          Spacer(),
          Center(
            child: Text(text, style: Theme.of(context).textTheme.titleMedium),
          ),
          Spacer(),
          Opacity(opacity: 0, child: AppBackButton()),
        ],
      ),
    );
  }
}
