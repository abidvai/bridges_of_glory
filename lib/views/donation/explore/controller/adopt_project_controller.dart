import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/common_widgets/custom_toast.dart';
import '../../../../model/category_model.dart';
import '../../../../model/project_detail_model.dart';
import '../../../../model/project_model.dart';
import '../../../../model/showing_card_model.dart';
import '../../../../service/category/category_service.dart';
import '../../../../service/project_service/project_service.dart';
import '../../../../service/search/search_service.dart';

class AdoptProjectController extends GetxController {
  final int id;

  AdoptProjectController({required this.id});

  RxList<ProjectModel> villageProjectList = <ProjectModel>[].obs;
  RxList<ProjectModel> filterVillageProjectList = <ProjectModel>[].obs;
  final ProjectService _projectService = ProjectService();
  final SearchService _searchService = SearchService();

  Rxn<ProjectDetailsModel> adoptProjectDetail = Rxn(null);
  RxList<ProjectModel> searchProjectList = <ProjectModel>[].obs;

  RxString selectedSupport = ''.obs;
  RxString searchText = ''.obs;

  List<String> menuList = ['All', 'Chicken', 'Cow', 'Goat', 'pig', 'Business'];

  RxString selected = RxString('All');
  TextEditingController searchController = TextEditingController();
  RxBool isLoading = RxBool(false);

  final CategoryService _categoryService = CategoryService();
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;

  Future<void> fetchVillageProject(int id) async {
    isLoading.value = true;
    final response = await _projectService.fetchProject(id);

    if (response.data != null) {
      isLoading.value = false;
      villageProjectList.assignAll(response.data!);
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
      adoptProjectDetail.value = response.data!;
    } else {
      showCustomToast(text: response.error ?? 'Failed to load project details');
    }
    isLoading.value = false;
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

  void applyFilter() {
    if (selected.value == 'All') {
      filterVillageProjectList.value = List.from(villageProjectList);
    } else {
      filterVillageProjectList.value = villageProjectList
          .where(
            (item) =>
                item.category?.name?.toLowerCase() ==
                selected.value.toLowerCase(),
          )
          .toList();
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
    fetchVillageProject(id);
    fetchCategory();

    ever(selected, (_) => applyFilter());
    super.onInit();
  }
}
