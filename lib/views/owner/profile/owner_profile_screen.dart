import 'package:bridges_of_glory/views/owner/profile/controller/owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/common_widgets/primary_button.dart';
import '../../../core/common_widgets/custom_text_field.dart';
import '../../../core/common_widgets/app_top_bar.dart';
import '../../../utils/constant/color.dart';
import '../../donation/profile/change_password_screen.dart';
import '../../donation/profile/controller/profile_controller.dart';


class OwnerProfileScreen extends StatefulWidget {
  const OwnerProfileScreen({super.key});

  @override
  State<OwnerProfileScreen> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<OwnerProfileScreen> {
  final OwnerProfileController ownerProfileController = Get.put(OwnerProfileController());

  Widget _settingsItem({
    required String title,
    required String text,
    bool showEditOption = true,
    String editText = 'Edit',
    VoidCallback? onEditClick,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.hintText.withValues(alpha: 0.3)),
        ),
      ),
      child: GestureDetector(
        onTap: onEditClick,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    text,
                    style: TextStyle(
                      color: AppColors.hintText,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            if (showEditOption)
              Row(
                children: [
                  Icon(Iconsax.edit, size: 20.w),
                  SizedBox(width: 6.w),
                  Text(
                    editText,
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            AppTopBar(text: 'Account Settings'),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  _settingsItem(
                    title: 'Full name',
                    text: 'Abid',
                    onEditClick: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomModal(
                            controller: ownerProfileController.nameController,
                            title: 'Full name',
                            text: 'Abid',
                            limit: 32,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 18.h),
                  _settingsItem(
                    title: 'Email',
                    text: 'example@gmail.com',
                    showEditOption: false,
                  ),
                  SizedBox(height: 18.h),
                  _settingsItem(
                    title: 'Password',
                    text: '●●●●●●●●●●●●',
                    editText: 'Change',
                    onEditClick: () {
                      Get.to(UpdatePasswordScreen());
                      // Navigate to change password page
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomModal extends StatefulWidget {
  final String title;
  final String text;
  final int limit;
  final TextEditingController controller;
  final VoidCallback? onTap;

  const CustomModal({
    super.key,
    required this.limit,
    required this.text,
    required this.title,
    this.onTap,
    required this.controller,
  });

  @override
  State<CustomModal> createState() => _CustomModalState();
}

class _CustomModalState extends State<CustomModal> {
  final DonerProfileController profileController = Get.find<DonerProfileController>();

  @override
  void initState() {
    super.initState();

    // set initial text
    widget.controller.text = widget.text;

    // listener for char count
    widget.controller.addListener(() {
      profileController.textCharCount.value = widget.controller.text.length;
    });

    // initial value
    profileController.textCharCount.value = widget.controller.text.length;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 1.sw - 40.w,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            color: AppColors.surface,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: AppColors.hintText,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6.h),
              CustomTextField(
                controller: widget.controller,
                hintText: widget.title,
                maxLength: widget.limit,
              ),
              SizedBox(height: 36.h),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'Cancel',
                      height: 48.h,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      backgroundColor: AppColors.border.withValues(alpha: 0.2),
                      textStyle: TextStyle(
                        color: AppColors.text,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Save',
                      height: 48.h,
                      onTap: widget.onTap,
                      backgroundColor: AppColors.text.withValues(alpha: 0.9),
                      textStyle: TextStyle(
                        color: AppColors.surface,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
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