import 'package:bridges_of_glory/core/common_widgets/info_widget.dart';
import 'package:bridges_of_glory/core/common_widgets/primary_button.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/views/donation/explore/controller/explore_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WelcomingInfoScreen extends StatelessWidget {
  const WelcomingInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: InfoWidget(
                title: 'Walking Witness',
                information:
                    'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                description:
                    'Walking Witness is a nonprofit platform that connects donors in the United States with Village Leaders in rural Uganda. These leaders support 20–30 families who may farm, raise livestock, or run small businesses. Donors can fund a project or adopt a family, helping create sustainable growth and support for the community.',
                onTap: () {},
                showMovement: true,
                url: 'https://www.youtube.com/watch?v=dGiW5_m4Ihc',
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: PrimaryButton(
          text: 'Skip',
          onTap: () {
            Get.toNamed(AppRoutes.login);
          },
        ),
      ),
    );
  }
}
