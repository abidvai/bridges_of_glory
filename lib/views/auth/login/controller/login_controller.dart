import 'package:bridges_of_glory/core/common_widgets/custom_toast.dart';
import 'package:bridges_of_glory/core/route/app_routes.dart';
import 'package:bridges_of_glory/service/auth/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isCheck = RxBool(false);
  RxBool isLoading = RxBool(false);
  final AuthService _authService = AuthService();

  Future<void> login() async {
    isLoading.value = true;

    final response = await _authService.signIn(
      emailController.text.toString(),
      passwordController.text.trim().toString(),
    );

    if (response.success) {
      isLoading.value = false;
      Get.offAllNamed(AppRoutes.donationBottomNav);
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Credential not matching');
    }
  }
}
