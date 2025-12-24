import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AppBackButton extends StatelessWidget {
  final Color? iconColor;
  const AppBackButton({super.key, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Get.back(),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
            color: AppColors.border.withValues(alpha: 0.5),
            width: 1.2.w,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.h),
          child: Icon(Icons.arrow_back_ios_new, size: 14.h, color: iconColor,),
        ),
      ),
    );
  }
}
