import 'package:bridges_of_glory/core/common_widgets/primary_button.dart';
import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:bridges_of_glory/views/auth/signup/controller/signup_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/common_widgets/custom_text_field.dart';
import '../../../core/route/app_routes.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final SignupController signupController = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Sign up",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 8.h),
              Center(
                child: Text(
                  "Create an Account",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),

              SizedBox(height: 20.h),
              Text('Name', style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: signupController.nameController,
                hintText: 'name',
              ),

              SizedBox(height: 12.h),
              Text('Email', style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: signupController.emailController,
                hintText: 'justin45@company.com',
              ),

              SizedBox(height: 12.h),
              Text('Password', style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: signupController.passwordController,
                hintText: 'password',
              ),

              SizedBox(height: 12.h),
              Text(
                'Rewrite password',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: signupController.rewritePasswordController,
                hintText: 're-write password',
              ),

              SizedBox(height: 12.h),
              Row(
                children: [
                  Obx(() {
                    return Checkbox(
                      activeColor: AppColors.red,
                      value: signupController.isCheck.value,
                      onChanged: (value) {
                        signupController.isCheck.value = value!;
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    );
                  }),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'By signing up , you are agreeing to ',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                          TextSpan(
                            text: ' Terms of services ',
                            style: TextStyle(color: AppColors.red),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                          TextSpan(
                            text: ' Privacy Policy  ',
                            style: TextStyle(color: AppColors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              PrimaryButton(
                text: 'Next',
                loading: signupController.isLoading.value,
                onTap: () {
                  signupController.signup();
                },
              ),

              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  SizedBox(width: 4.w),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.login);
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(color: AppColors.red),
                    ),
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
