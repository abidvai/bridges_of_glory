import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:bridges_of_glory/core/common_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/common_widgets/primary_button.dart';
import '../../../utils/constant/color.dart';
import 'controller/change_password_controller.dart';

class UpdatePasswordScreen extends StatelessWidget {
  UpdatePasswordScreen({super.key});

  final ChangePasswordController changePassController = Get.put(
    ChangePasswordController(),
  );
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(text: 'Update Password'),
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.surface,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  hintText: 'Current Password',
                  // error: changePassController.currentError.value,
                  controller: changePassController.currentPassController,
                  isPassword: true,
                  validator: (value) {
                    if (value!.length < 8) {
                      return 'password must be 8 character';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 24.h),

                CustomTextField(
                  hintText: 'New Password',
                  // error: changePassController.newPassError.value,
                  controller: changePassController.newPassController,
                  isPassword: true,
                  validator: (value) {
                    if (value!.length < 8) {
                      return 'password must be 8 character';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 24.h),
                CustomTextField(
                  hintText: 'Confirm Password',
                  // error: changePassController.confirmError.value,
                  controller: changePassController.confirmPassController,
                  isPassword: true,
                  validator: (value) {
                    if (value!.length < 8) {
                      return 'password must be 8 character';
                    }
                    return null;
                  },
                ),
                Spacer(),
                SafeArea(
                  bottom: true,
                  child: Obx(() {
                    return PrimaryButton(
                      text: 'Update',
                      textStyle: TextStyle(
                        color: AppColors.surface,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      loading: changePassController.isLoading.value,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          changePassController.changePassword();
                        }
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
