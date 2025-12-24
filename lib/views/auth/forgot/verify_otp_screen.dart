import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/auth/forgot/controller/forgot_controller.dart';
import 'package:bridges_of_glory/views/auth/signup/controller/timer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/common_widgets/primary_button.dart';

class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({super.key});

  final TimerController timerController = Get.put(TimerController(), tag: 'verifyOtp');
  final ForgotController forgotController = Get.find<ForgotController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Check your email',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Please enter the four verification code we sent to ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 6.h),
                Text(
                  'example@gmail.com',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.red),
                ),
        
                SizedBox(height: 20.h),
                OtpTextField(
                  numberOfFields: 4,
                  cursorColor: AppColors.text,
                  fillColor: AppColors.surface,
                  filled: true,
                  focusedBorderColor: AppColors.red,
                  enabledBorderColor: AppColors.border,
                  showFieldAsBox: true,
                  borderRadius: BorderRadius.circular(12.r),
                  fieldWidth: 48.w,
                  borderWidth: 1.5,
                  fieldHeight: 48.w,
                  textStyle: TextStyle(
                    color: AppColors.text,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) {
                    forgotController.otp = verificationCode;
                  },
                ),
        
                SizedBox(height: 32.h),
                PrimaryButton(
                  text: 'Next',
                  onTap: () {
                    Get.toNamed(AppRoutes.resetPassword);
                  },
                ),
        
                SizedBox(height: 16.h),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Didn\’t get the email?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(width: 4.w),
                      Obx(() {
                        final seconds = timerController.seconds.value;
                        return GestureDetector(
                          onTap: () {
                            seconds == 0
                                ? () {
                                    //TODO:
                                    return null;
                                  }
                                : null;
                          },
                          child: Text(
                            seconds == 0
                                ? 'Resend'
                                : "Resent in 00:${timerController.seconds.value.toString().padLeft(2, '0')}",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.red),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
