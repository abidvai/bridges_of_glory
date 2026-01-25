import 'package:bridges_of_glory/model/project_detail_model.dart';
import 'package:get/get.dart';
import '../../../../core/common_widgets/custom_toast.dart';
import '../../../../model/category_model.dart';
import '../../../../model/project_model.dart';
import '../../../../service/category/category_service.dart';
import '../../../../service/project_service/project_service.dart';
import '../../../../service/view_count/project_view_service.dart';

class WitnessWomenController extends GetxController {
  final int id;

  WitnessWomenController({required this.id});

  RxList<String> menuList = [
    'All',
    'Chicken',
    'Cow',
    'Goat',
    'pig',
    'Business',
  ].obs;
  RxString selected = RxString('All');

  RxBool isLoading = RxBool(false);
  final ProjectService _projectService = ProjectService();
  final ProjectViewCountService _projectViewCountService =
      ProjectViewCountService();
  RxList<ProjectModel> witnessProjectList = <ProjectModel>[].obs;
  RxList<ProjectModel> filteredWitnessProjectList = <ProjectModel>[].obs;
  Rxn<ProjectDetailsModel> witnessProjectDetailsList = Rxn(null);

  final CategoryService _categoryService = CategoryService();
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;

  RxString selectedSupport = ''.obs;

  Future<void> fetchWitnessProject(int id) async {
    isLoading.value = true;
    final response = await _projectService.fetchProject(id);

    if (response.data != null) {
      isLoading.value = false;
      witnessProjectList.assignAll(response.data!);
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
      witnessProjectDetailsList.value = response.data!;
      _projectViewCountService.postView(projectId);
    } else {
      showCustomToast(text: response.error ?? 'Failed to load project details');
    }
    isLoading.value = false;
  }

  void applyFilter() {
    if (selected.value == 'All') {
      filteredWitnessProjectList.value = List.from(witnessProjectList);
    } else {
      filteredWitnessProjectList.value = witnessProjectList
          .where(
            (project) =>
                project.category?.name?.toLowerCase() ==
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

  @override
  void onInit() {
    fetchCategory();
    fetchWitnessProject(id);
    ever(selected, (_) => applyFilter());

    super.onInit();
  }
}
