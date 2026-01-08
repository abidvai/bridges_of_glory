import 'package:bridges_of_glory/gen/assets.gen.dart';
import 'package:bridges_of_glory/model/project_model.dart';
import 'package:bridges_of_glory/service/project_service/project_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/custom_toast.dart';
import '../../../../model/CategoryModel.dart';
import '../../../../model/showing_card_model.dart';

class DonerHomeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  final ProjectService _projectService = ProjectService();
  RxBool isLoading = RxBool(false);
  RxList<ProjectModel> empowermentList =
      <ProjectModel>[].obs;

  final categoryList = [
    CategoryModel(Assets.images.chicken, 'Chicken'),
    CategoryModel(Assets.images.cow, 'Cow'),
    CategoryModel(Assets.images.goat, 'Goat'),
    CategoryModel(Assets.images.pig, 'pig'),
    CategoryModel(Assets.images.chicken, 'Chicken'),
    CategoryModel(Assets.images.leader, 'Business'),
  ];

  Future<void> fetchEmpowermentProject() async {
    isLoading.value = true;
    final response = await _projectService.fetchProject(2);

    if (response.data != null) {
      isLoading.value = false;
      empowermentList.assignAll(response.data!);
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Something went wrong 404.');
    }
  }

  @override
  void onInit() {
    fetchEmpowermentProject();
    super.onInit();
  }
}
