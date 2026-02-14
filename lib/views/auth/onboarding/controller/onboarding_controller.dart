import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../model/onboarding_data_model.dart';

class OnboardingController extends GetxController {
  PageController pageController = PageController();
  RxInt currentPage = RxInt(0);

  void next() {
    if (currentPage.value == pages.length - 1) {
      saveOnboardingSeen();
      Get.offAllNamed(AppRoutes.welcoming);
    }
    pageController.nextPage(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  List<OnboardingDataModel> pages = [
    OnboardingDataModel(
      image: Assets.images.onboardingClient1,
      title:
          'This app is a tool to help answer the command of the great Commission - making disciples throught the world',
    ),
    OnboardingDataModel(
      image: Assets.images.onboardingClient2,
      title: 'Every Empowerment project contributes to improving communities',
    ),
    OnboardingDataModel(
      image: Assets.images.onboardingClient3,
      title:
          'Become the Movement: You are invited to take part in this soul-winnig strategy',
    ),
  ];

  Future<void> saveOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_onboarding', true);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
