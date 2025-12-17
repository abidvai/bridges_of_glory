import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/color.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const PrimaryButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 335.w,
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: AppColors.primaryGradient,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
