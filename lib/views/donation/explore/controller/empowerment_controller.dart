import 'package:bridges_of_glory/core/common_widgets/custom_toast.dart';
import 'package:bridges_of_glory/model/project_model.dart';
import 'package:bridges_of_glory/service/project_service/project_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/route/app_routes.dart';
import '../../../../model/category_model.dart';
import '../../../../model/project_detail_model.dart';
import '../../../../service/category/category_service.dart';
import '../../../../service/payment/payment_service.dart';
import '../../../../service/search/search_service.dart';
import '../../../../service/view_count/project_view_service.dart';
import '../../../../utils/helper/app_helper.dart';

class EmpowermentController extends GetxController {
  final int id;

  EmpowermentController({required this.id});

  TextEditingController searchController = TextEditingController();

  RxString selectedSupportTitle = ''.obs;
  RxString selectedSupportValue = ''.obs;
  RxString searchText = ''.obs;
  RxString selected = RxString('All');
  RxBool isLoading = RxBool(false);

  final ProjectService _projectService = ProjectService();
  final SearchService _searchService = SearchService();
  final PaymentService _paymentService = PaymentService();
  final ProjectViewCountService _projectViewCountService =
      ProjectViewCountService();

  RxList<ProjectModel> empowermentList = <ProjectModel>[].obs;
  RxList<ProjectModel> searchProjectList = <ProjectModel>[].obs;
  RxList<ProjectModel> filterEmpowermentList = <ProjectModel>[].obs;
  Rxn<ProjectDetailsModel> empowermentDetail = Rxn(null);

  final CategoryService _categoryService = CategoryService();
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxInt selectedCategoryId = RxInt(0);
  String otp = '';

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
      _projectViewCountService.postView(projectId);
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
      categoryID: selectedCategoryId.value,
      projectID: 2,
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
      Get.offNamed(
        AppRoutes.paymentScreen,
        arguments: {
          'projectId': projectId,
          'projectName': projectName,
          'supportType': supportType,
          'amount': amount,
        },
      );
    } else {
      isLoading.value = false;
      showCustomToast(text: 'Something went wrong 404. please try again.');
    }
  }

  @override
  void onInit() {
    fetchEmpowermentProject(id);
    fetchCategory();
    ever(selected, (_) => applyFilter());
    super.onInit();
  }
}
