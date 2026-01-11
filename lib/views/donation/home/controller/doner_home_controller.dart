import 'package:bridges_of_glory/model/category_wise_project_model.dart';
import 'package:bridges_of_glory/model/project_detail_model.dart';
import 'package:bridges_of_glory/model/project_model.dart';
import 'package:bridges_of_glory/service/category/category_service.dart';
import 'package:bridges_of_glory/service/project_service/project_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/common_widgets/custom_toast.dart';
import '../../../../model/category_model.dart';

class DonerHomeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  final ProjectService _projectService = ProjectService();

  final CategoryService _categoryService = CategoryService();
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<CategoryWiseprojectModel> categoryProjectList =
      <CategoryWiseprojectModel>[].obs;
  Rxn<ProjectDetailsModel> projectDetail = Rxn<ProjectDetailsModel>(null);

  RxBool isLoading = RxBool(false);
  RxList<ProjectModel> empowermentList = <ProjectModel>[].obs;


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

  Future<void> fetchCategory() async {
    isLoading.value = true;
    final response = await _categoryService.fetchCategory();

    if (response.data != null) {
      isLoading.value = false;
      categoryList.value = response.data!;
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Something went wrong 404.');
    }
  }

  Future<void> fetchCategoryProject(int id) async {
    isLoading.value = true;
    final response = await _categoryService.fetchCategoryWiseProject(id);

    if (response.data != null) {
      isLoading.value = false;
      categoryProjectList.value = response.data!;
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Something went wrong 404.');
    }
  }

  Future<void> fetchProjectDetails(int projectId) async {
    isLoading.value = true;
    final response = await _projectService.fetchProjectDetail(projectId);

    if (response.data != null) {
      projectDetail.value = response.data!;
    } else {
      showCustomToast(text: response.error ?? 'Failed to load project details');
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    fetchEmpowermentProject();
    fetchCategory();
    super.onInit();
  }
}
