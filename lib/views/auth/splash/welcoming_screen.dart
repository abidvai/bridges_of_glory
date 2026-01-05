import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

import '../../../core/common_widgets/primary_button.dart';
import '../../../gen/assets.gen.dart';

class WelcomingPage extends StatelessWidget {
  const WelcomingPage({super.key});

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
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: PrimaryButton(
            text: "Next",
            onTap: () {
              Get.to(
                InfoScreen(
                  onTap: () {
                    Get.toNamed(AppRoutes.login);
                  },
                  title: 'Walking Witness',
                  information:
                      'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                  description:
                      'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
