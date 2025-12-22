import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:bridges_of_glory/core/common_widgets/image_uploader.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constant/color.dart';

class DonerSettingScreen extends StatelessWidget {
  const DonerSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppTopBar(text: 'Settings'),

              SizedBox(height: 24.h),
              ImageUploaderVOne(),
              SizedBox(height: 24.h),
              _topSection(context),
              SizedBox(height: 24.h),
              _settingMenuSection(),
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

  Widget _settingMenuSection() {
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
            onTap: () {},
          ),
          Divider(),
          SettingMenuCard(
            title: 'Notifications',
            leading: Iconsax.notification,
            onTap: () {},
          ),
          Divider(),
          SettingMenuCard(
            title: 'Logout',
            leading: Iconsax.logout,
            onTap: () {},
          ),
          Divider(),
        ],
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
