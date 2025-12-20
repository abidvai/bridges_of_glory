

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProfileController extends GetxController {
  RxBool isLoading = RxBool(false);

  TextEditingController textController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  RxInt textCharCount = 0.obs;

  // Future<void> fetchProfileData() async {
  //   try {
  //     isLoading.value = true;
  //
  //     final token = await AppHelper.instance.getAccessToken();
  //
  //     if (token == null) return;
  //     final response = await profileAuth.fetchProfile(token);
  //
  //     if (response != null) {
  //       profileInfo.value = response;
  //     } else {
  //       utils.showCustomToast(text: 'fetching data not found');
  //     }
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Future<void> updatePhoneNumber(String number) async {
  //   try {
  //     isLoading.value = true;
  //     final token = await AppHelper.instance.getAccessToken();
  //     if (token == null) return;
  //
  //     final response = await profileAuth.updateNumber(token, number);
  //
  //     if (response) {
  //       utils.showCustomToast(
  //         text: 'number updated',
  //         toastType: utils.ToastTypesInfo(utils.ToastTypes.success),
  //       );
  //       fetchProfileData();
  //     } else {
  //       utils.showCustomToast(text: 'Something went wrong');
  //     }
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  //
  // Future<void> updateName(String name) async {
  //   try {
  //     isLoading.value = true;
  //     final token = await AppHelper.instance.getAccessToken();
  //     if (token == null) return;
  //
  //     final response = await profileAuth.updateName(token, name);
  //
  //
  //     if (response.success == true) {
  //       utils.showCustomToast(
  //         text: 'name updated',
  //         toastType: utils.ToastTypesInfo(utils.ToastTypes.success),
  //       );
  //       fetchProfileData();
  //     } else {
  //       utils.showCustomToast(text: 'Something went wrong');
  //     }
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  //
  // Future<void> uploadImage() async {
  //   final response = await profileAuth.uploadProImage(profilePic.value!);
  //
  //   if (response?.data != null) {
  //     utils.showCustomToast(
  //       text: 'upload image successfully',
  //       toastType: utils.ToastTypesInfo(utils.ToastTypes.success),
  //     );
  //
  //     // profileInfo.refresh();
  //     fetchProfileData();
  //   } else {
  //     // utils.showCustomToast(
  //     //   text: response?.error ?? 'something went wrong',
  //     // );
  //   }
  // }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    textController.dispose();
    nameController.dispose();
  }
}