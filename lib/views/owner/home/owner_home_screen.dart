import 'package:bridges_of_glory/core/constant/color.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../gen/assets.gen.dart';

class OwnerHomeScreen extends StatelessWidget {
  const OwnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hey Jhon 👋',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Welcome back to your dashboard!',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.hintText,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.messageScreen);
                    },
                    icon: Icon(Iconsax.message, size: 25.h),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
              Container(
                width: 335.w,
                height: 380.h,
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.surface,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.text.withOpacity(0.2),
                      offset: Offset(0, 5),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Activity & Projects',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: AppColors.red),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'Based on your last activities',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.text.withValues(alpha: 0.5),
                      ),
                    ),

                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: AnalysisInfoCard(
                            iconData: Iconsax.task_square,
                            title: 'Total Projects',
                            value: '0',
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: AnalysisInfoCard(
                            iconData: Iconsax.user,
                            title: 'Total Members',
                            value: '0',
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15.h),
                    Container(
                      width: 303.w,
                      height: 94.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 20.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColors.secondary.withValues(alpha: 0.4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Assets.icons.groups.svg(width: 25.w),
                              SizedBox(width: 8.w),
                              Text(
                                'Total Families',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '\$0 USD',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnalysisInfoCard extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String value;

  const AnalysisInfoCard({
    super.key,
    required this.iconData,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 144.w,
      height: 134.w,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.secondary.withValues(alpha: 0.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(iconData, size: 25.w),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
          ),
          SizedBox(height: 6.h),
          Text(value, style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}
