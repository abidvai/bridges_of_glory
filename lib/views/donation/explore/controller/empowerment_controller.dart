import 'package:bridges_of_glory/core/common_widgets/custom_toast.dart';
import 'package:bridges_of_glory/model/project_model.dart';
import 'package:bridges_of_glory/service/project_service/project_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../model/showing_card_model.dart';

class EmpowermentController extends GetxController {
  late int id;

  TextEditingController searchController = TextEditingController();

  List<String> menuList = ['All', 'Chicken', 'Cow', 'Goat', 'pig', 'Business'];
  RxInt pastorSupport = RxInt(100);
  RxInt liveStockSupport = RxInt(100);
  RxInt churchSupport = RxInt(100);
  RxString selected = RxString('All');
  RxBool isLoading = RxBool(false);

  RxList<ProjectModel> empowermentList =
      <ProjectModel>[].obs;
  final ProjectService _projectService = ProjectService();


  Future<void> fetchEmpowermentProject(int id) async {
    isLoading.value = true;
    final response = await _projectService.fetchProject(id);

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
    final args = Get.arguments as Map<String, dynamic>;
    id = args['id'];

    fetchEmpowermentProject(id);
    super.onInit();
  }
}
