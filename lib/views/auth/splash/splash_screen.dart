import 'package:bridges_of_glory/core/constant/color.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

import '../../../core/common_widgets/primary_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Center(child: Assets.images.appLogo.image())],
          ),
        ),
        bottomSheet: PrimaryButton(
          title: "Next",
          onTap: () {
            Get.toNamed(AppRoutes.infoScreen);
          },
        ),
      ),
    );
  }
}

