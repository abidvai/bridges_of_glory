import 'package:bridges_of_glory/core/common_widgets/custom_toast.dart';
import 'package:bridges_of_glory/service/profile/profile_service.dart';
import 'package:bridges_of_glory/utils/helper/app_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final ProfileService _profileService = ProfileService();

  RxBool isLoading = RxBool(false);
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  Future<void> changePassword() async {
    isLoading.value = true;
    final token = await AppHelper.instance.getAccessToken();

    if (token == null) return;
    final response = await _profileService.changePassword(
      token,
      currentPassController.text.trim().toString(),
      newPassController.text.trim().toString(),
      confirmPassController.text.trim().toString(),
    );

    if (response.success) {
      isLoading.value = false;
      showCustomToast(
        text: 'Password Changed Successfully',
        toastType: ToastTypesInfo(ToastTypes.success),
      );
      Get.back();
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Something went wrong');
    }
  }
}
