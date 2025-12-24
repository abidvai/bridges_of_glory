import 'package:bridges_of_glory/core/common_widgets/custom_toast.dart';
import 'package:bridges_of_glory/core/common_widgets/primary_button.dart';
import 'package:bridges_of_glory/utils/enum/user_type.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/auth/signup/controller/signup_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/constant/color.dart';
import '../../gen/assets.gen.dart';

class SelectUserScreen extends StatelessWidget {
  SelectUserScreen({super.key});

  final SignupController signupController = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 100.h),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                'Select a user type',
                style: TextTheme.of(context).titleLarge,
              ),
              SizedBox(height: 12.h),
              Text(
                'Join now to streamline you ',
                style: TextTheme.of(context).bodyMedium,
              ),
              SizedBox(height: 12.h),
              _roleItem(
                type: UserType.donator.name,
                image: Assets.images.donate.path,
                name: 'Join the Movement',
              ),
              SizedBox(height: 24.h),
              _roleItem(
                type: UserType.projectOwner.name,
                image: 'assets/images/leader.png',
                name: 'Project Leader',
              ),
              SizedBox(height: 40.h),
              PrimaryButton(
                text: 'Next',
                onTap: () {
                  if (signupController.selectedUser.value.isEmpty) {
                    showCustomToast(text: 'Please select any user type');
                  } else {
                    Get.toNamed(AppRoutes.login);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleItem({
    required String type,
    required String image,
    required String name,
  }) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          signupController.selectedUser.value = type;
        },
        child: Container(
          width: .6.sw,
          height: .45.sw,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: signupController.selectedUser.value == type
                  ? AppColors.yellowish
                  : AppColors.border.withValues(alpha: 0.3),
              width: signupController.selectedUser.value == type ? 3 : 1,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(image, width: .35.sw, height: .25.sw),
                SizedBox(height: 10.h),
                Text(
                  name,
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
