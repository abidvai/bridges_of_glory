import 'package:bridges_of_glory/core/common_widgets/custom_toast.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/service/auth/auth_service.dart';
import 'package:bridges_of_glory/utils/helper/app_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rewritePasswordController = TextEditingController();

  String otp = '';
  RxBool isLoading = RxBool(false);
  final AuthService _authService = AuthService();

  Future<void> verifyEmail() async {
    isLoading.value = true;

    final response = await _authService.forgetPassEmailVerify(
      emailController.text.toString(),
    );

    if (response.success) {
      isLoading.value = false;
      Get.toNamed(AppRoutes.verifyOtp);
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Please enter a valid email');
    }
  }

  Future<void> verifyOtp() async {
    isLoading.value = true;

    final userId = await AppHelper.instance.getUserId();

    if (userId == null) return;

    final response = await _authService.resetPassOtpVerify(userId, otp);

    if (response.success) {
      isLoading.value = false;
      Get.toNamed(AppRoutes.resetPassword);
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Please enter a valid email');
    }
  }

  Future<void> resetPassword() async {
    isLoading.value = true;

    final userId = await AppHelper.instance.getUserId();
    final secretkey = await AppHelper.instance.getSecretKey();

    if (userId == null || secretkey == null) return;
    final response = await _authService.resetPass(
      userId,
      secretkey,
      passwordController.text.trim().toString(),
      rewritePasswordController.text.trim().toString(),
    );

    if (response.success) {
      isLoading.value = false;
      showCustomToast(
        text: 'Password Change successfully',
        toastType: ToastTypesInfo(ToastTypes.success),
      );
      Get.toNamed(AppRoutes.login);
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Something went wrong 404. Please try again.');
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
}
