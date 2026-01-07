import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/gen/assets.gen.dart';
import 'package:bridges_of_glory/utils/constant/color.dart';
import 'package:bridges_of_glory/utils/helper/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<Offset> _walkingAnimation;
  late Animation<Offset> _witnessAnimation;

  late Animation<double> _bookFadeAnimation;
  late Animation<double> _bookScaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _walkingAnimation =
        Tween<Offset>(
          begin: const Offset(0, -20),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _bookFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut), // middle e asbe
      ),
    );

    _bookScaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.3,
          0.8,
          curve: Curves.elasticOut,
        ), // bouncy feel
      ),
    );

    _witnessAnimation =
        Tween<Offset>(
          begin: const Offset(0, 1.5),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward();

    _animationController.forward().whenComplete(() {
      isLogin();
    });
  }

  void isLogin() async {
    final token = await AppHelper.instance.getAccessToken();

    if (token != null) {
      Get.offAllNamed(AppRoutes.donationBottomNav);
    } else {
      Get.offNamed(AppRoutes.onboardingScreen);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlideTransition(
            position: _walkingAnimation,
            child: Assets.images.walkingLogo.image(),
          ),
          const SizedBox(height: 2),
          SlideTransition(
            position: _witnessAnimation,
            child: Assets.images.witnessLogo.image(),
          ),

          const SizedBox(height: 2),
          Center(
            child: FadeTransition(
              opacity: _bookFadeAnimation,
              child: ScaleTransition(
                scale: _bookScaleAnimation,
                child: Assets.images.appLogoBook.image(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
