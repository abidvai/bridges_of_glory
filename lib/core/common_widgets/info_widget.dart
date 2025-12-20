import 'package:bridges_of_glory/core/common_widgets/app_back_button.dart';
import 'package:bridges_of_glory/core/common_widgets/primary_button.dart';
import 'package:bridges_of_glory/core/constant/color.dart';
import 'package:bridges_of_glory/views/auth/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/assets.gen.dart';

class InfoWidget extends StatelessWidget {
  final String information;
  final String description;
  final VoidCallback onTap;

  const InfoWidget({
    super.key,
    required this.information,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Container(height: double.infinity),
            Container(
              width: double.infinity,
              height: 121.h,
              color: AppColors.secondary,
            ),
            Positioned(
              left: 96.w,
              top: 45.h,
              child: Assets.images.appLogo2.image(),
            ),
            Positioned(top: 8, left: 16, child: AppBackButton()),
            Positioned(
              top: 100.h,
              left: 0.w,
              right: 0.w,
              bottom: 0.h,
              // Add bottom padding for the button
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 20.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Walking Witness',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Information',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              information,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              description,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Spacer(),
                            PrimaryButton(title: 'Skip', onTap: onTap),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomSheet: BottomButton(
      //   title: 'Skip',
      //   onTap: () {
      //     // TODO: Add navigation logic
      //   },
      // ),
    );
  }
}
