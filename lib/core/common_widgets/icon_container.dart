import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constant/color.dart';


class IconContainer extends StatelessWidget {
  final double? width;
  final String path;
  final Color? color;

  const IconContainer({super.key, required this.path, this.color, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 42.w,
      height: 50.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
        color?.withValues(alpha: 0.1) ??
            AppColors.red.withValues(alpha: 0.1),
      ),
      child: Center(
        child: SvgPicture.asset(
          path,
          width: 20.w,
          height: 20.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}