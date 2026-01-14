import 'package:bridges_of_glory/core/common_widgets/custom_toast.dart';
import 'package:bridges_of_glory/model/project_model.dart';
import 'package:bridges_of_glory/service/project_service/project_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../model/category_model.dart';
import '../../../../model/project_detail_model.dart';
import '../../../../service/category/category_service.dart';
import '../../../../service/search/search_service.dart';

class EmpowermentController extends GetxController {
  final int id;

  EmpowermentController({required this.id});

  TextEditingController searchController = TextEditingController();

  List<String> menuList = ['All', 'Chicken', 'Cow', 'Goat', 'pig', 'Business'];
  RxString selectedSupport = ''.obs;
  RxString searchText = ''.obs;
  RxString selected = RxString('All');
  RxBool isLoading = RxBool(false);

  final ProjectService _projectService = ProjectService();
  final SearchService _searchService = SearchService();

  RxList<ProjectModel> empowermentList = <ProjectModel>[].obs;
  RxList<ProjectModel> searchProjectList = <ProjectModel>[].obs;
  RxList<ProjectModel> filterEmpowermentList = <ProjectModel>[].obs;
  Rxn<ProjectDetailsModel> empowermentDetail = Rxn(null);

  final CategoryService _categoryService = CategoryService();
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;

  Future<void> fetchEmpowermentProject(int id) async {
    isLoading.value = true;
    final response = await _projectService.fetchProject(id);

    if (response.data != null) {
      isLoading.value = false;
      empowermentList.assignAll(response.data!);
      applyFilter();
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Something went wrong 404.');
    }
  }

  Future<void> fetchProjectDetails(int projectId) async {
    isLoading.value = true;
    final response = await _projectService.fetchProjectDetail(projectId);

    if (response.data != null) {
      empowermentDetail.value = response.data!;
    } else {
      showCustomToast(text: response.error ?? 'Failed to load project details');
    }
    isLoading.value = false;
  }

  void applyFilter() {
    if (selected.value == 'All') {
      filterEmpowermentList.value = List.from(empowermentList);
    } else {
      filterEmpowermentList.value = empowermentList
          .where(
            (item) =>
                item.category?.name?.toLowerCase() ==
                selected.value.toLowerCase(),
          )
          .toList();
    }
  }

  Future<void> fetchCategory() async {
    isLoading.value = true;
    final response = await _categoryService.fetchCategory();

    if (response.data != null) {
      isLoading.value = false;
      categoryList.assignAll([CategoryModel(name: 'All'), ...response.data!]);

    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Something went wrong 404.');
    }
  }

  Future<void> search({required String searchText}) async {
    isLoading.value = true;
    final response = await _searchService.search(
      searchText: searchText,
      categoryID: id,
    );

    if (response.data != null) {
      isLoading.value = false;
      searchProjectList.assignAll(response.data!);
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Something went wrong 404.');
    }
  }

  @override
  void onInit() {
    fetchEmpowermentProject(id);
    fetchCategory();
    ever(selected,(_) => applyFilter());
    super.onInit();
  }
}
