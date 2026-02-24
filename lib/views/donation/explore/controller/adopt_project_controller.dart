import 'package:bridges_of_glory/service/payment/payment_service.dart';
import 'package:bridges_of_glory/service/view_count/project_view_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/common_widgets/custom_toast.dart';
import '../../../../core/route/app_routes.dart';
import '../../../../model/category_model.dart';
import '../../../../model/project_detail_model.dart';
import '../../../../model/project_model.dart';
import '../../../../service/category/category_service.dart';
import '../../../../service/project_service/project_service.dart';
import '../../../../service/search/search_service.dart';
import '../../../../utils/helper/app_helper.dart';

class AdoptProjectController extends GetxController {
  final int id;

  AdoptProjectController({required this.id});

  RxList<ProjectModel> villageProjectList = <ProjectModel>[].obs;
  RxList<ProjectModel> filterVillageProjectList = <ProjectModel>[].obs;
  final ProjectService _projectService = ProjectService();
  final SearchService _searchService = SearchService();
  final PaymentService _paymentService = PaymentService();
  final ProjectViewCountService _projectViewCountService =
      ProjectViewCountService();

  Rxn<ProjectDetailsModel> adoptProjectDetail = Rxn(null);
  RxList<ProjectModel> searchProjectList = <ProjectModel>[].obs;

  RxString selectedSupportTitle = ''.obs;
  RxString selectedSupportValue = ''.obs;
  RxString searchText = ''.obs;
  String otp = '';

  RxString selected = RxString('All');
  TextEditingController searchController = TextEditingController();
  RxBool isLoading = RxBool(false);

  final CategoryService _categoryService = CategoryService();
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxInt selectedCategoryId = RxInt(0);

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
      _projectViewCountService.postView(projectId);
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
      categoryID: selectedCategoryId.value,
      projectID: 4,
    );

    if (response.data != null) {
      isLoading.value = false;
      searchProjectList.assignAll(response.data!);
    } else {
      isLoading.value = false;
      showCustomToast(text: response.error ?? 'Something went wrong 404.');
    }
  }

  Future<bool> getOtp() async {
    isLoading.value = true;
    final userId = await AppHelper.instance.getUserId();
    if (userId == null) return false;
    final response = await _paymentService.fetchOtp(userId);

    if (response.data == true) {
      isLoading.value = false;
      showCustomToast(
        text: 'OTP sent successfully in your gmail',
        toastType: ToastTypesInfo(ToastTypes.success),
      );
      return true;
    } else {
      isLoading.value = false;
      showCustomToast(text: 'Something went wrong 404. please try again.');
      return false;
    }
  }

  Future<void> submitOtp(
    int projectId,
    String projectName,
    String supportType,
    double amount,
  ) async {
    isLoading.value = true;
    final userId = await AppHelper.instance.getUserId();
    if (userId == null) return;
    final response = await _paymentService.submitOtp(userId, otp);

    if (response.data == true) {
      isLoading.value = false;
      Get.offNamed(AppRoutes.paymentScreen, arguments: {
        'projectId': projectId,
        'projectName': projectName,
        'supportType': supportType,
        'amount': amount,
      });
    } else {
      isLoading.value = false;
      showCustomToast(text: 'Something went wrong 404. please try again.');
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
