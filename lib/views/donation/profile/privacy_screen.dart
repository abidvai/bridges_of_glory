import 'package:bridges_of_glory/views/donation/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/constant/color.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});

  final DonerProfileController _donerProfileController =
  Get.find<DonerProfileController>();

  Widget _listText({
    required BuildContext context,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 5.w,
                height: 5.w,
                margin: EdgeInsets.only(top: 7.h),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.hintText,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  description,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,

      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leadingWidth: 60.w,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.border.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16.w,
              color: AppColors.text,
            ),
          ),
        ),
        title: Text(
          'Privacy & Policy',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView.separated(
            itemCount: _donerProfileController.privacyList.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final privacy = _donerProfileController.privacyList[index];
              return _listText(
                context: context,
                title: privacy.title ?? 'title',
                description: privacy.description ?? 'description',
              );
            },
          ),
        ),
      ),
    );
  }
}
