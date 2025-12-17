import 'package:bridges_of_glory/core/common_widgets/primary_button.dart';
import 'package:bridges_of_glory/core/constant/color.dart';
import 'package:bridges_of_glory/views/auth/signup/controller/signup_Controller.dart';
import 'package:bridges_of_glory/views/auth/signup/controller/timer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/route/app_routes.dart';

class CheckEmailScreen extends StatelessWidget {
  CheckEmailScreen({super.key});

  final SignupController signupController = Get.find<SignupController>();
  final TimerController timerController = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                style: TextStyle(
                  color: AppColors.red,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: 20.h),
              OtpTextField(
                numberOfFields: 6,
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
                  signupController.otp = verificationCode;
                },
              ),

              SizedBox(height: 32.h),
              PrimaryButton(title: 'Next', onTap: () {}),

              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Didn\’t get the email?'),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Obx(() {
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
                          style: TextStyle(
                            color: AppColors.red,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
