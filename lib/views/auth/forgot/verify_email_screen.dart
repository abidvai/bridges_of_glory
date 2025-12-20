import 'package:bridges_of_glory/core/common_widgets/primary_button.dart';
import 'package:bridges_of_glory/core/constant/color.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/auth/forgot/controller/forgot_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/common_widgets/custom_text_field.dart';

class VerifyEmailScreen extends StatelessWidget {
  VerifyEmailScreen({super.key});

  final ForgotController forgotController = Get.put(ForgotController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Reset Password',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 8.h),
            Center(
              child: Text(
                'Enter your email to reset your password',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            SizedBox(height: 20.h),
            Text('Email', style: Theme.of(context).textTheme.titleSmall),
            SizedBox(height: 8.h),
            CustomTextField(
              controller: forgotController.emailController,
              hintText: 'justin45@company.com',
            ),

            SizedBox(height: 20.h),
            PrimaryButton(
              title: 'Next',
              onTap: () {
                Get.toNamed(AppRoutes.verifyOtp);
              },
            ),
          ],
        ),
      ),
    );
  }
}
