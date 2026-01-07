import 'dart:async';

import 'package:bridges_of_glory/core/common_widgets/custom_toast.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/service/auth/auth_service.dart';
import 'package:bridges_of_glory/utils/helper/app_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  AuthService _authService = AuthService();

  RxString selectedUser = RxString('');
  RxBool isCheck = RxBool(false);
  RxBool isLoading = RxBool(false);
  String otp = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rewritePasswordController = TextEditingController();

  Future<void> signup() async {
    isLoading.value = true;
    final response = await _authService.signup(
      nameController.text.toString(),
      emailController.text.toString(),
      passwordController.text.trim().toString(),
      rewritePasswordController.text.trim().toString(),
      isCheck.value,
    );

    if (response.success) {
      isLoading.value = false;
      Get.offAllNamed(AppRoutes.checkEmail);
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Something went wrong');
    }
  }

  Future<void> verifyOtp() async {
    isLoading.value = true;
    final userId = await AppHelper.instance.getUserId();

    if (userId == null) return;
    final response = await _authService.verifyEmailSign(otp, userId);

    if (response.success) {
      isLoading.value = false;
      Get.offAllNamed(AppRoutes.donationBottomNav);
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Something went wrong');
    }
  }

  Future<void> resendOtp() async {
    isLoading.value = true;
    final userId = await AppHelper.instance.getUserId();

    if (userId == null) return;
    final response = await _authService.resendOtp(userId);

    if (response.success) {
      isLoading.value = false;
      showCustomToast(
        text: 'Otp sent to your email.',
        toastType: ToastTypesInfo(ToastTypes.success),
      );
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Something went wrong');
    }
  }

  RxInt seconds = RxInt(60);
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds.value == 0) {
        timer.cancel();
      } else {
        seconds.value--;
      }
    });
  }
}
