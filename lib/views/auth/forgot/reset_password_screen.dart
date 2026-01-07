import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/auth/forgot/controller/forgot_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/common_widgets/custom_text_field.dart';
import '../../../core/common_widgets/primary_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final ForgotController forgotController = Get.find<ForgotController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
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
                    'Enter your new password here',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),

                SizedBox(height: 12.h),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: forgotController.passwordController,
                        hintText: 'password',
                        isPassword: true,
                        validator: (value) {
                          if (value!.length < 8) {
                            return 'password must be 8 character';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 12.h),
                      Text(
                        'Rewrite password',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        isPassword: true,
                        controller: forgotController.rewritePasswordController,
                        hintText: 're-write password',
                        validator: (value) {
                          if (value!.length < 8) {
                            return 'password must be 8 character';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                Obx(() {
                  return PrimaryButton(
                    text: 'Next',
                    loading: forgotController.isLoading.value,
                    onTap: () {
                      if(_formKey.currentState!.validate()) {
                        forgotController.resetPassword();

                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
