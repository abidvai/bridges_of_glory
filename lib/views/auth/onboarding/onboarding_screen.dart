import 'package:bridges_of_glory/core/common_widgets/primary_button.dart';
import 'package:bridges_of_glory/gen/assets.gen.dart';
import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:bridges_of_glory/views/auth/onboarding/controller/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingController onboardingController = Get.put(
    OnboardingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: onboardingController.pageController,
                  itemCount: onboardingController.pages.length,
                  onPageChanged: (page) {
                    onboardingController.currentPage.value = page;
                  },
                  itemBuilder: (context, index) {
                    final page = onboardingController.pages[index];

                    return BoardingPage(image: page.image, title: page.title);
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: onboardingController.pageController,
                count: 3,
                effect: WormEffect(
                  dotHeight: 8.h,
                  dotWidth: 8.w,
                  activeDotColor: AppColors.red,
                ),
              ),
              SizedBox(height: 20),
              PrimaryButton(
                text: 'Next',
                onTap: () {
                  onboardingController.next();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BoardingPage extends StatelessWidget {
  final AssetGenImage image;
  final String title;

  const BoardingPage({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(10.r),
          child: image.image(
            width: double.infinity,
            height: 218.h,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 85.h),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: AppColors.red),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
