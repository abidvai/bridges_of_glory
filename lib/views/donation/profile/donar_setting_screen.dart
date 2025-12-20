import 'package:bridges_of_glory/core/common_widgets/app_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              _topSection(),
              SizedBox(height: 24.h),
              _settingMenuSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topSection() {
    return Column(children: [Text('Jenny Smith'), Text('jenny@gmail.com')]);
  }

  Widget _settingMenuSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SettingMenuCard(
            title: 'Account Information',
            leading: Iconsax.edit,
            onTap: () {},
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
