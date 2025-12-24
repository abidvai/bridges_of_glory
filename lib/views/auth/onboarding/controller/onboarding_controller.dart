import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../model/onboarding_data_model.dart';

class OnboardingController extends GetxController {
  PageController pageController = PageController();
  RxInt currentPage = RxInt(0);

  void next() {
    if (currentPage.value == pages.length - 1) {
      Get.offAllNamed(AppRoutes.welcoming);
    }
    pageController.nextPage(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  List<OnboardingDataModel> pages = [
    OnboardingDataModel(
      image: Assets.images.onboarding1,
      title: 'Choose local and empower small businesses to succeed.',
    ),
    OnboardingDataModel(
      image: Assets.images.onboarding2,
      title: 'Every purchase contributes to something meaningful',
    ),
    OnboardingDataModel(
      image: Assets.images.onboarding3,
      title:
          'Make a difference—purchase an item that will be passed on to someone in need.',
    ),
  ];

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
