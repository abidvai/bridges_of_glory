import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:bridges_of_glory/core/common_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/common_widgets/primary_button.dart';
import '../../../utils/constant/color.dart';

class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key});

  // final ChangePassController changePassController = Get.put(
  //   ChangePassController(),
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(text: 'Update Password'),backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.surface,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Current Password',
                // error: changePassController.currentError.value,
                controller: TextEditingController(),
                isPassword: true,
              ),
        
              SizedBox(height: 24.h),
        
              CustomTextField(
                hintText: 'New Password',
                // error: changePassController.newPassError.value,
                controller: TextEditingController(),
                isPassword: true,
              ),
        
              SizedBox(height: 24.h),
              CustomTextField(
                hintText: 'Confirm Password',
                // error: changePassController.confirmError.value,
                controller: TextEditingController(),
                isPassword: true,
              ),
              Spacer(),
              SafeArea(
                bottom: true,
                child: PrimaryButton(
                  text: 'Update',
                  textStyle: TextStyle(
                    color: AppColors.surface,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  // loading: changePassController.isLoading.value,
                  onTap: () async {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
