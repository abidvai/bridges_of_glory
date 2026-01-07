import 'dart:io';

import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:bridges_of_glory/core/common_widgets/image_uploader.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/gen/assets.gen.dart';
import 'package:bridges_of_glory/utils/helper/app_helper.dart';
import 'package:bridges_of_glory/views/donation/profile/notification_screen.dart';
import 'package:bridges_of_glory/views/donation/profile/privacy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/common_widgets/primary_button.dart';
import '../../../utils/constant/color.dart';

class DonerSettingScreen extends StatefulWidget {
  const DonerSettingScreen({super.key});

  @override
  State<DonerSettingScreen> createState() => _DonerSettingScreenState();
}

class _DonerSettingScreenState extends State<DonerSettingScreen> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: AppColors.surfaceBg,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24.h),
              ImageUploaderVOne(
                currentImage: Assets.icons.user.path,
                defaultImage: Assets.icons.user.path,
                onImageSelected: (file) {
                  selectedImage = file;
                  print(selectedImage);
                },
              ),
              SizedBox(height: 24.h),
              _topSection(context),
              SizedBox(height: 24.h),
              _settingMenuSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topSection(BuildContext context) {
    return Column(
      children: [
        Text('Jenny Smith', style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 12.h),
        Text(
          'jenny@gmail.com',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.hintText),
        ),
      ],
    );
  }

  Widget _settingMenuSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SettingMenuCard(
            title: 'Account Information',
            leading: Iconsax.edit,
            onTap: () {
              Get.toNamed(AppRoutes.donerProfileSettings);
            },
          ),
          Divider(),
          SettingMenuCard(
            title: 'Privacy & Policy ',
            leading: Iconsax.shield_tick,
            onTap: () {
              Get.to(PrivacyPolicyScreen());
            },
          ),
          Divider(),
          SettingMenuCard(
            title: 'Notifications',
            leading: Iconsax.notification,
            onTap: () {
              Get.to(NotificationSettings());
            },
          ),
          Divider(),
          SettingMenuCard(
            title: 'Logout',
            leading: Iconsax.logout,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return _customModal(context);
                },
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _customModal(BuildContext context) {
    return Center(
      child: Container(
        width: 1.sw - 40.w,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          color: AppColors.surface,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.images.logout.image(
              width: 82.w,
              height: 80.h,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 18.h),
            SvgPicture.asset('assets/icons/logout_modal.svg', width: 108.w),
            SizedBox(height: 12.h),
            SizedBox(
              width: .7.sw,
              child: Text(
                'Are you sure, you want to log out?',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
                textAlign: TextAlign.center,
              ),
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
                    backgroundColor: AppColors.border.withValues(alpha: 0.3),
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
                    text: 'Log out',
                    height: 48.h,
                    onTap: () async {
                      AppHelper.instance.clearAllPrefValue();
                      Get.offAllNamed(AppRoutes.login);
                    },
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
    );
  }
}

class SettingMenuCard extends StatelessWidget {
  final String title;
  final IconData leading;
  final VoidCallback onTap;

  const SettingMenuCard({
    super.key,
    required this.title,
    required this.leading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(leading),
      title: Text(title, style: Theme.of(context).textTheme.titleSmall),
      trailing: Icon(Icons.arrow_forward_ios_outlined),
    );
  }
}
