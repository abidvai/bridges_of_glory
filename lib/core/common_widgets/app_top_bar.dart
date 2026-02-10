import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_back_button.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const AppTopBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          AppBackButton(),
          Spacer(),
          // Expanded(
          //   child: Center(
          //     child: Text(
          //       text,
          //       style: Theme.of(context).textTheme.titleMedium,
          //       maxLines: 1,
          //       overflow: TextOverflow.ellipsis,
          //     ),
          //   ),
          // ),
          // Spacer()
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(58.h);
}
