import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/common_widgets/primary_button.dart';
import '../../../core/common_widgets/custom_text_field.dart';
import '../../../core/common_widgets/app_top_bar.dart';
import '../../../core/constant/color.dart';
import 'controller/profile_controller.dart';

class DonerProfileSetting extends StatefulWidget {
  const DonerProfileSetting({super.key});

  @override
  State<DonerProfileSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<DonerProfileSetting> {
  final ProfileController profileController = Get.put(ProfileController());

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
        border: Border(bottom: BorderSide(color: AppColors.hintText.withValues(alpha: 0.3))),
      ),
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
                  style: TextStyle(color: AppColors.hintText, fontSize: 14.sp),
                ),
              ],
            ),
          ),
          if (showEditOption)
            Row(
              children: [
                Icon(Iconsax.edit, size: 20.w),
                SizedBox(width: 6.w),
                GestureDetector(
                  onTap: onEditClick,
                  child: Text(
                    editText,
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
        ],
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
                    text: 'Jenny Smith',
                    onEditClick: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomModal(
                            controller: profileController.nameController,
                            title: 'Full name',
                            text: 'Jenny Smith',
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
                  _settingsItem(
                    title: 'Password',
                    text: '●●●●●●●●●●●●',
                    editText: 'Change',
                    onEditClick: () {
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
  final ProfileController profileController = Get.find<ProfileController>();

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
                      backgroundColor: AppColors.border,
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
                      backgroundColor: AppColors.text,
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
