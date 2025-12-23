import 'package:bridges_of_glory/core/common_widgets/custom_text_field.dart';
import 'package:bridges_of_glory/core/common_widgets/primary_button.dart';
import 'package:bridges_of_glory/core/constant/color.dart';
import 'package:bridges_of_glory/core/enum/user_type.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/auth/login/controller/login_controller.dart';
import 'package:bridges_of_glory/views/auth/signup/controller/signup_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController loginController = Get.find<LoginController>();
  final SignupController signupController = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 1.sh),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Log in",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Center(
                    child: Text(
                      "Welcome Back!",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text('Email', style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: loginController.emailController,
                    hintText: 'justin45@company.com',
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Password',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    controller: loginController.passwordController,
                    hintText: 'enter your password',
                    isPassword: true,
                    obscure: '*',
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Obx(() {
                            return Checkbox(
                              checkColor: AppColors.surface,
                              activeColor: AppColors.red,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: loginController.isCheck.value,
                              onChanged: (value) {
                                loginController.isCheck.value = value!;
                              },
                            );
                          }),
                          Text('Remember Me'),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.verifyEmail);
                        },
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(color: AppColors.red),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 32.h),
                  PrimaryButton(
                    text: 'Next',
                    onTap: () {
                      if(signupController.selectedUser.value == UserType.donator.name) {
                        Get.toNamed(AppRoutes.donationBottomNav);
                      }

                      if(signupController.selectedUser.value == UserType.projectOwner.name) {
                        Get.toNamed(AppRoutes.ownerBottomNav);
                      }
                    },
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      SizedBox(width: 4.w),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.signup);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: AppColors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
