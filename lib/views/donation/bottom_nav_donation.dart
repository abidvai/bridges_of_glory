import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/donation/explore/adopt_project_screen.dart';
import 'package:bridges_of_glory/views/donation/explore/explore_screen.dart';
import 'package:bridges_of_glory/views/donation/home/donar_home_screen.dart';
import 'package:bridges_of_glory/views/donation/library/library_screen.dart';
import 'package:bridges_of_glory/views/donation/profile/donar_setting_screen.dart';
import 'package:bridges_of_glory/views/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constant/color.dart';
import '../../gen/assets.gen.dart';

class BottomNavDonation extends StatefulWidget {
  final int index;

  const BottomNavDonation({super.key, this.index = 2});

  @override
  State<BottomNavDonation> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNavDonation> {
  late int currentIndex = widget.index;

  List<Widget> pages = [
    DonerHomeScreen(),
    AdoptProjectScreen(showBottomButton: false, id: 4,),
    ExploreScreen(),
    LibraryScreen(),
    DonerSettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1,
        currentIndex: currentIndex,
        backgroundColor: AppColors.surfaceBg,
        unselectedItemColor: AppColors.text,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedItemColor: AppColors.red,
        unselectedFontSize: 13.sp,
        selectedFontSize: 13.sp,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 4.h, bottom: 5.h),
              child: Assets.icons.home.svg(
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
              ),
            ),
            label: 'Home',
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 4.h, bottom: 5.h),
              child: Assets.icons.fillHome.svg(
                color: AppColors.red,
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 4.h, bottom: 5.h),
              child: Assets.icons.groups.svg(
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
              ),
            ),
            label: 'Villages',
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 4.h, bottom: 5.h),
              child: Assets.icons.fillUsers.svg(
                color: AppColors.red,
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 4.h, bottom: 5.h),
              child: Assets.icons.exlore.svg(
                color: AppColors.border,
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
              ),
            ),
            label: 'Explore',
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 4.h, bottom: 5.h),
              child: Assets.icons.add.svg(
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Library',
            icon: Padding(
              padding: EdgeInsets.only(top: 4.h, bottom: 5.h),
              child: Assets.icons.library.svg(
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
              ),
            ),
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 4.h, bottom: 5.h),
              child: Assets.icons.fillLibrary.svg(),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Padding(
              padding: EdgeInsets.only(top: 4.h, bottom: 5.h),
              child: Assets.icons.user.svg(
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
              ),
            ),
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 4.h, bottom: 5.h),
              child: Assets.icons.fillUser.svg(
                color: AppColors.red,
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
