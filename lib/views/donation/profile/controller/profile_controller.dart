import 'dart:io';

import 'package:bridges_of_glory/model/privacy_model.dart';
import 'package:bridges_of_glory/model/profile_info_model.dart';
import 'package:bridges_of_glory/service/profile/profile_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../core/common_widgets/custom_toast.dart' as utils;

class DonerProfileController extends GetxController {
  RxBool isLoading = RxBool(false);

  TextEditingController textController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  RxInt textCharCount = 0.obs;
  Rxn<ProfileInfoModel> profileInfo = Rxn<ProfileInfoModel>(null);
  RxList<PrivacyModel> privacyList = RxList<PrivacyModel>();
  Rx<File?> selectedImage = Rx<File?>(null);

  final ProfileService _profileService = ProfileService();

  Future<void> fetchProfileData() async {
    isLoading.value = true;

    final response = await _profileService.fetchUserInfo();

    if (response.data != null) {
      isLoading.value = false;
      profileInfo.value = response.data;
    } else {
      isLoading.value = false;
      utils.showCustomToast(text: 'fetching data not found');
    }
  }

  Future<void> fetchPrivacy() async {
    isLoading.value = true;

    final response = await _profileService.fetchPrivacy();

    if (response.data != null) {
      isLoading.value = false;
      privacyList.assignAll(response.data!);
    } else {
      isLoading.value = false;
      utils.showCustomToast(text: 'privacy data not found');
    }
  }

  Future<void> updateName(String name) async {
    isLoading.value = true;

    final response = await _profileService.updateName(name);

    if (response.data != null) {
      isLoading.value = false;
      profileInfo.value = response.data;
      profileInfo.refresh();
      utils.showCustomToast(
        text: 'user name changed successfully',
        toastType: utils.ToastTypesInfo(utils.ToastTypes.success),
      );
    } else {
      isLoading.value = false;
      utils.showCustomToast(text: 'privacy data not found');
    }
  }

  Future<void> updateImage() async {
    final response = await _profileService.updateProfilePic(selectedImage.value!);

    if (response.data != null) {
      utils.showCustomToast(
        text: 'upload image successfully',
        toastType: utils.ToastTypesInfo(utils.ToastTypes.success),
      );

      profileInfo.refresh();
    } else {
      utils.showCustomToast(
        text: response.error ?? 'something went wrong',
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
    fetchPrivacy();
  }

  @override
  void onClose() {
    super.onClose();
    textController.dispose();
    nameController.dispose();
  }
}
